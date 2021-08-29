const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const firestore = admin.firestore();

exports.onUserStatusChange = functions.database
  .instance("wuphf-chat-flutter-presence")
  .ref("/{uid}/presence")
  .onUpdate(async (change, context) => {
    // Get the data written to Realtime Database
    const isOnline = change.after.val();

    // Get a reference to the Firestore document
    const userStatusFirestoreRef = firestore.doc(`users/${context.params.uid}`);

    console.log(`status: ${isOnline}`);

    // Update the values in firestore
    return userStatusFirestoreRef.update({
      presence: isOnline,
      last_seen: Date.now(),
    });
  });

exports.onStartNewMessage = functions.firestore
  .document("/messagesDb/{messagesDbId}")
  .onCreate(async (snapshot, context) => {
    const data = snapshot.data();
    const userId = data.startedBy;
    const recipientId = data.startedWith;

    const recipientDocSnapshot = await admin
      .firestore()
      .collection("users")
      .doc(recipientId)
      .get();
    const recipientUserData = recipientDocSnapshot.data();
    const token = recipientUserData.token;

    const senderDocSnapshot = await admin
      .firestore()
      .collection("users")
      .doc(userId)
      .get();
    const senderUserData = senderDocSnapshot.data();

    // No token present for user
    if (token === "") {
      console.log(
        `TERMINATE No token user ${recipientId} ${recipientUserData.displayName}`
      );
      return null;
    }

    const payload = {
      token: token,
      android: {
        notification: {
          title: `${senderUserData.displayName}`,
          body: `Wants to chat with you.`,
          imageUrl: `${senderUserData.profileImageUrl}`,
        },
        data: {
          type: "new-chat",
          userId: userId,
        },
      },
    };

    admin
      .messaging()
      .send(payload)
      .then((response) => {
        console.log("Successfully sent message:", response);
        return { success: true };
      })
      .catch((error) => {
        console.log(`TERMINATE No token ${recipientId}`);
        return { error: error.code };
      });
  });

exports.onStartNewGroup = functions.firestore
  .document("/groupsDb/{groupDbId}")
  .onCreate(async (snapshot, context) => {
    const data = snapshot.data();
    const creatorId = data.createdBy;
    const groupName = data.groupName;
    const groupImageUrl = data.groupImage;
    const participants = data.participants;
    const groupDbId = context.params.groupDbId;

    const creatorDocSnapshot = await admin
      .firestore()
      .collection("users")
      .doc(creatorId)
      .get();
    const creatorData = creatorDocSnapshot.data();

    await Promise.all(
      participants.map(async (participant) => {
        if (participant != creatorId) {
          const participantDocSnapshot = await admin
            .firestore()
            .collection("users")
            .doc(participant)
            .get();
          const participantData = participantDocSnapshot.data();
          if (participantData.token !== "") {
            const payload = {
              token: participantData.token,
              android: {
                notification: {
                  title: `${groupName}`,
                  body: `${creatorData.displayName} added you to the group.`,
                  imageUrl: `${groupImageUrl}`,
                },
                data: {
                  type: "new-group",
                  groupDbId: groupDbId,
                },
              },
            };
            try {
              const response = await admin.messaging().send(payload);
              console.log("Successfully sent message:", response);
            } catch (error) {
              console.log("ERROR :", error);
            }
          }
        }
      })
    );
    return { success: true };
  });

exports.onNewMessage = functions.firestore
  .document("/messages/{userId}/userMessages/{recipientId}")
  .onUpdate(async (change, context) => {
    const userId = context.params.userId;
    const data = change.after.data();
    const sentBy = data.sentBy;
    const text = data.text;
    const imageUrl = data.imageUrl;

    // User himself/herself has sent the message
    if (userId === sentBy) {
      console.log(`Same User Return ${userId}`);
      return null;
    }

    const userDocSnapshot = await admin
      .firestore()
      .collection("users")
      .doc(userId)
      .get();
    const userData = userDocSnapshot.data();
    const token = userData.token;
    const isOnline = userData.presence;

    // No token present for user
    if (token === "" || isOnline == true) {
      console.log(
        `TERMINATE No token/ User online user ${userId} ${userData.displayName}`
      );
      return null;
    }

    const senderDocSnapshot = await admin
      .firestore()
      .collection("users")
      .doc(sentBy)
      .get();
    const senderUserData = senderDocSnapshot.data();

    var subtitle;
    if (text === "") {
      // Message with only image
      subtitle = "Sent you a picture.";
    } else if (imageUrl != "") {
      // Message with image and text
      subtitle = `📷 ${text}`;
    } else {
      // Message with only text
      subtitle = text;
    }

    var notification;
    if (imageUrl === "") {
      notification = {
        title: `${senderUserData.displayName}`,
        body: subtitle,
      };
    } else {
      notification = {
        title: `${senderUserData.displayName}`,
        body: subtitle,
        imageUrl: `${imageUrl}`,
      };
    }

    const payload = {
      token: token,
      android: {
        notification: notification,
        data: {
          type: "new-chat",
          userId: sentBy,
        },
      },
    };

    try {
      const response = await admin.messaging().send(payload);
      console.log("Successfully sent message:", response);
    } catch (error) {
      console.log("ERROR: ", error);
    }
  });

exports.onNewGroupMessage = functions.firestore
  .document("/groupsDb/{groupDbId}")
  .onUpdate(async (change, context) => {
    const data = change.after.data();
    const beforeData = change.before.data();
    const groupDbId = context.params.groupDbId;
    const groupImage = data.groupImage;

    if (data.id == beforeData.id) {
      console.log(`TERMINATE Message Not Changed ${groupDbId}`);
      return null;
    }

    const sentBy = data.sentBy;
    const groupName = data.groupName;
    const text = data.text;
    const imageUrl = data.imageUrl;
    const participants = data.participants;

    var subtitle;
    if (text === "") {
      // Message with only image
      subtitle = "📷";
    } else if (imageUrl != "") {
      // Message with image and text
      subtitle = `📷 ${text}`;
    } else {
      // Message with only text
      subtitle = text;
    }

    var notification;
    if (imageUrl === "") {
      notification = {
        title: `${groupName}`,
        body: subtitle,
        imageUrl: `${groupImage}`,
      };
    } else {
      notification = {
        title: `${groupName}`,
        body: subtitle,
        imageUrl: `${imageUrl}`,
      };
    }

    await Promise.all(
      participants.map(async (participant) => {
        if (participant != sentBy) {
          const participantDocSnapshot = await admin
            .firestore()
            .collection("users")
            .doc(participant)
            .get();
          const participantData = participantDocSnapshot.data();
          if (participantData.token !== "") {
            const payload = {
              token: participantData.token,
              android: {
                notification: notification,
                data: {
                  type: "new-group",
                  groupDbId: groupDbId,
                },
              },
            };
            try {
              const response = await admin.messaging().send(payload);
              console.log("Successfully sent message:", response);
            } catch (error) {
              console.log("ERROR :", error);
            }
          }
        }
      })
    );
    return { success: true };
  });

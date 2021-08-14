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
      },
    };

    admin
      .messaging()
      .send((message = payload))
      .then((response) => {
        console.log("Successfully sent message:", response);
        return { success: true };
      })
      .catch((error) => {
        console.log(`TERMINATE No token ${recipientId}`);
        return { error: error.code };
      });
  });

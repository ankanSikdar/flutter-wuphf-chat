import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:wuphf_chat/config/configs.dart';

import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/messages/base_messages_repository.dart';
import 'package:wuphf_chat/repositories/repositories.dart';

class MessagesRepository extends BaseMessagesRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final UserRepository _userRepository = UserRepository();

  MessagesRepository({
    firebase_auth.FirebaseAuth firebaseAuth,
    FirebaseFirestore firebaseFirestore,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> sendMessage(
      {@required String recipientId,
      @required DocumentReference<Object> documentReference,
      @required String message}) async {
    try {
      final date = DateTime.now();

      String messageId = '';
      await documentReference.collection(Paths.messagesData).add({
        'sentAt': date,
        'sentBy': _firebaseAuth.currentUser.uid,
        'text': message,
      }).then((doc) => messageId = doc.id);

      final createdMessage = Message(
        id: messageId,
        sentBy: _firebaseAuth.currentUser.uid,
        sentAt: date,
        text: message,
      );

      await _firebaseFirestore
          .collection(Paths.messages)
          .doc(_firebaseAuth.currentUser.uid)
          .collection(Paths.userMessages)
          .doc(recipientId)
          .update(createdMessage.toDocument());

      await _firebaseFirestore
          .collection(Paths.messages)
          .doc(recipientId)
          .collection(Paths.userMessages)
          .doc(_firebaseAuth.currentUser.uid)
          .update(createdMessage.toDocument());
    } catch (e) {
      throw Exception('sendMessage ERROR: ${e.message}');
    }
  }

  @override
  Stream<List<Future<ChatUser>>> getUserChatList() {
    try {
      return _firebaseFirestore
          .collection(Paths.messages)
          .doc(_firebaseAuth.currentUser.uid)
          .collection(Paths.userMessages)
          .orderBy('sentAt', descending: true)
          .snapshots()
          .map((QuerySnapshot snap) =>
              snap.docs.map((QueryDocumentSnapshot doc) async {
                final user =
                    await _userRepository.getUserWithId(userId: doc.id);
                final data = doc.data() as Map;
                final messagesDbRef =
                    data[Paths.messagesDb] as DocumentReference;
                return ChatUser(
                  user: user,
                  messagesDbRef: messagesDbRef,
                  lastMessage: Message.fromMap(data),
                );
              }).toList());
    } catch (e) {
      throw Exception('getUserChatList ERROR: ${e.message}');
    }
  }

  Future<bool> checkMessagesExists({@required User user}) async {
    try {
      final docSnapshot = await _firebaseFirestore
          .collection(Paths.messages)
          .doc(_firebaseAuth.currentUser.uid)
          .collection(Paths.userMessages)
          .doc(user.id)
          .get();

      return docSnapshot.exists;
    } catch (e) {
      throw Exception('checkMessagesExists ERROR: ${e.message}');
    }
  }

  Future<DocumentReference<Object>> createMessagesDb(
      {@required User user}) async {
    try {
      final documentReference =
          await _firebaseFirestore.collection(Paths.messagesDb).add({});

      await _firebaseFirestore
          .collection(Paths.messages)
          .doc(_firebaseAuth.currentUser.uid)
          .collection(Paths.userMessages)
          .doc(user.id)
          .set({
        Paths.messagesDb: documentReference,
      });

      await _firebaseFirestore
          .collection(Paths.messages)
          .doc(user.id)
          .collection(Paths.userMessages)
          .doc(_firebaseAuth.currentUser.uid)
          .set({
        Paths.messagesDb: documentReference,
      });

      return documentReference;
    } catch (e) {
      throw Exception('createMessagesDb ERROR: ${e.message}');
    }
  }

  Future<DocumentReference<Object>> getAlreadyPresentMessagesDb(
      {@required User user}) async {
    try {
      final docSnapshot = await _firebaseFirestore
          .collection(Paths.messages)
          .doc(_firebaseAuth.currentUser.uid)
          .collection(Paths.userMessages)
          .doc(user.id)
          .get();

      final data = docSnapshot.data();
      final messagesDb = data['messagesDb'];
      return messagesDb;
    } catch (e) {
      throw Exception('getAlreadyPresentMessagesDb ERROR: ${e.message}');
    }
  }

  Future<DocumentReference<Object>> sendFirstMessage({
    @required User user,
    @required String message,
  }) async {
    try {
      final messagesDbRef = await createMessagesDb(user: user);
      await sendMessage(
        recipientId: user.id,
        documentReference: messagesDbRef,
        message: message,
      );
      return messagesDbRef;
    } catch (e) {
      throw Exception('sendFirstMessage ERROR: ${e.message}');
    }
  }

  Stream<List<Message>> getMessagesList(
      {@required DocumentReference messagesDbRef}) {
    try {
      return messagesDbRef
          .collection(Paths.messagesData)
          .orderBy('sentAt', descending: true)
          .snapshots()
          .map((QuerySnapshot snap) =>
              snap.docs.map((QueryDocumentSnapshot doc) {
                final data = doc.data() as Map;
                return Message(
                  id: doc.id,
                  sentAt: (data['sentAt'] as Timestamp).toDate(),
                  sentBy: data['sentBy'],
                  text: data['text'],
                );
              }).toList());
    } catch (e) {
      throw Exception('getMessagesList ERROR: ${e.message}');
    }
  }
}

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
  }

  @override
  Stream<List<Future<ChatUser>>> getUserChatList() {
    return _firebaseFirestore
        .collection(Paths.messages)
        .doc(_firebaseAuth.currentUser.uid)
        .collection(Paths.userMessages)
        .snapshots()
        .map((QuerySnapshot snap) =>
            snap.docs.map((QueryDocumentSnapshot doc) async {
              final user = await _userRepository.getUserWithId(userId: doc.id);
              final data = doc.data() as Map;
              final messagesDbRef = data[Paths.messagesDb] as DocumentReference;
              return ChatUser(
                user: user,
                messagesDbRef: messagesDbRef,
                lastMessage: Message.fromMap(data),
              );
            }).toList());
  }
}
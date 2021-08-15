import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:wuphf_chat/config/configs.dart';
import 'package:rxdart/rxdart.dart';

import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/messages/base_messages_repository.dart';
import 'package:wuphf_chat/repositories/repositories.dart';

class MessagesRepository extends BaseMessagesRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final UserRepository _userRepository = UserRepository();
  final StorageRepository _storageRepository = StorageRepository();

  MessagesRepository({
    firebase_auth.FirebaseAuth firebaseAuth,
    FirebaseFirestore firebaseFirestore,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> sendMessage({
    @required String recipientId,
    @required DocumentReference<Object> documentReference,
    @required String message,
    File image,
  }) async {
    try {
      String imageUrl = '';
      if (image != null) {
        imageUrl = await _storageRepository.uploadMessageImage(file: image);
      }

      final docReference =
          await documentReference.collection(Paths.messagesData).add({
        'sentAt': FieldValue.serverTimestamp(),
        'sentBy': _firebaseAuth.currentUser.uid,
        'text': message,
        'imageUrl': imageUrl,
      });
      final docSnapshot = await docReference.get();

      final createdMessage = Message(
        id: docSnapshot.id,
        sentBy: _firebaseAuth.currentUser.uid,
        sentAt: (docSnapshot['sentAt'] as Timestamp).toDate(),
        text: message,
        imageUrl: imageUrl,
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

  Stream<List<ChatList>> _getChatList() {
    try {
      return _firebaseFirestore
          .collection(Paths.messages)
          .doc(_firebaseAuth.currentUser.uid)
          .collection(Paths.userMessages)
          .orderBy('sentAt', descending: true)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs.map((doc) {
                final data = doc.data();
                final messagesDbRef =
                    data[Paths.messagesDb] as DocumentReference;
                return ChatList(
                    userId: doc.id,
                    messagesDbRef: messagesDbRef,
                    lastMessage: Message.fromMap(data));
              }).toList());
    } catch (e) {
      throw Exception('getChatList ERROR: ${e.message}');
    }
  }

  @override
  Stream<List<ChatUser>> getUserChats() {
    try {
      return Rx.combineLatest2<List<ChatList>, List<User>, List<ChatUser>>(
          _getChatList(),
          _userRepository.getAllUsers(),
          (chatList, usersList) => chatList.map((chat) {
                final user = usersList.firstWhere((u) => u.id == chat.userId);
                return ChatUser(
                  user: user,
                  messagesDbRef: chat.messagesDbRef,
                  lastMessage: chat.lastMessage,
                );
              }).toList());
    } catch (e) {
      throw Exception('getUserChats ERROR: ${e.message}');
    }
  }

  Future<bool> checkMessagesExists({@required String userId}) async {
    try {
      final docSnapshot = await _firebaseFirestore
          .collection(Paths.messages)
          .doc(_firebaseAuth.currentUser.uid)
          .collection(Paths.userMessages)
          .doc(userId)
          .get();

      return docSnapshot.exists;
    } catch (e) {
      throw Exception('checkMessagesExists ERROR: ${e.message}');
    }
  }

  // Separate than checkMessagesExists because this stream should be
  // only subscribed if no message exists and the other user may start
  // a message while the user has opened the chatting screen
  Stream<bool> messageExistsStream({@required String userId}) {
    try {
      return _firebaseFirestore
          .collection(Paths.messages)
          .doc(_firebaseAuth.currentUser.uid)
          .collection(Paths.userMessages)
          .doc(userId)
          .snapshots()
          .map((docSnapshot) => docSnapshot.exists);
    } catch (e) {
      throw Exception('messageExistsStream ERROR: ${e.message}');
    }
  }

  Future<DocumentReference<Object>> createMessagesDb(
      {@required String userId}) async {
    try {
      final documentReference =
          await _firebaseFirestore.collection(Paths.messagesDb).add({
        'startedBy': _firebaseAuth.currentUser.uid,
        'startedWith': userId,
      });

      await _firebaseFirestore
          .collection(Paths.messages)
          .doc(_firebaseAuth.currentUser.uid)
          .collection(Paths.userMessages)
          .doc(userId)
          .set({
        Paths.messagesDb: documentReference,
      });

      await _firebaseFirestore
          .collection(Paths.messages)
          .doc(userId)
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
      {@required String userId}) async {
    try {
      final docSnapshot = await _firebaseFirestore
          .collection(Paths.messages)
          .doc(_firebaseAuth.currentUser.uid)
          .collection(Paths.userMessages)
          .doc(userId)
          .get();

      final data = docSnapshot.data();
      final messagesDb = data['messagesDb'];
      return messagesDb;
    } catch (e) {
      throw Exception('getAlreadyPresentMessagesDb ERROR: ${e.message}');
    }
  }

  Future<DocumentReference<Object>> sendFirstMessage({
    @required String userId,
    @required String message,
    File image,
  }) async {
    try {
      final messagesDbRef = await createMessagesDb(userId: userId);
      await sendMessage(
        recipientId: userId,
        documentReference: messagesDbRef,
        message: message,
        image: image,
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
                  // Time can be null because server has not yet written the time
                  // Delay of a few milliseconds to write time can throw null error
                  sentAt: ((data['sentAt'] as Timestamp) ?? Timestamp.now())
                      .toDate(),
                  sentBy: data['sentBy'],
                  text: data['text'],
                  imageUrl: data['imageUrl'] ?? '',
                );
              }).toList());
    } catch (e) {
      throw Exception('getMessagesList ERROR: ${e.message}');
    }
  }
}

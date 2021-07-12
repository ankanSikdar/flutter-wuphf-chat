import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:wuphf_chat/models/models.dart';

//* For abstracting the underlying implementation of how a user is authenticated as well as how a user is fetched.
abstract class BaseMessagesRepository {
  Future<void> sendMessage({
    @required String recipientId,
    @required DocumentReference<Object> documentReference,
    @required String message,
  });

  Stream<List<Future<ChatUser>>> getUserChatList();

  Future<DocumentReference<Object>> createMessagesDb({@required User user});

  Future<DocumentReference<Object>> getAlreadyPresentMessagesDb(
      {@required User user});

  Future<bool> checkMessagesExists({@required User user});

  Future<DocumentReference<Object>> sendFirstMessage({
    @required User user,
    @required String message,
  });

  Stream<List<Message>> getMessagesList(
      {@required DocumentReference messagesDbRef});
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:wuphf_chat/models/models.dart';

//* For abstracting the underlying implementation of how a user is authenticated as well as how a user is fetched.
abstract class BaseMessagesRepository {
  Future<void> sendMessage({
    @required String recipientId,
    @required DocumentReference<Object> documentReference,
    @required String message,
    File image,
  });

  Stream<List<ChatUser>> getUserChats();

  Future<DocumentReference<Object>> createMessagesDb({@required String userId});

  Future<DocumentReference<Object>> getAlreadyPresentMessagesDb(
      {@required String userId});

  Future<bool> checkMessagesExists({@required String userId});

  Future<DocumentReference<Object>> sendFirstMessage({
    @required String userId,
    @required String message,
    File image,
  });

  Stream<List<Message>> getMessagesList(
      {@required DocumentReference messagesDbRef});
}

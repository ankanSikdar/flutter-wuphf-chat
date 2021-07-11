import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:wuphf_chat/models/models.dart';

class ChatUser extends Equatable {
  final User user;
  final DocumentReference messagesDbRef;
  final Message lastMessage;

  ChatUser({
    @required this.user,
    @required this.messagesDbRef,
    @required this.lastMessage,
  });

  @override
  List<Object> get props => [user, messagesDbRef, lastMessage];
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:wuphf_chat/models/models.dart';

class ChatList extends Equatable {
  final String userId;
  final DocumentReference messagesDbRef;
  final Message lastMessage;

  ChatList({
    @required this.userId,
    @required this.messagesDbRef,
    @required this.lastMessage,
  });

  @override
  List<Object> get props => [userId, messagesDbRef, lastMessage];
}

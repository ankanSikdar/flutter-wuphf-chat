import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:wuphf_chat/models/message_model.dart';

import 'models.dart';

class Group extends Equatable {
  final String groupId;
  final String groupName;
  final String groupImage;
  final Message lastMessage;
  final List<String> participants;
  final List<User> usersList;

  Group({
    @required this.groupId,
    @required this.groupName,
    @required this.groupImage,
    @required this.lastMessage,
    @required this.participants,
    this.usersList,
  });

  Map<String, dynamic> toMap() {
    return {
      'groupId': groupId,
      'groupName': groupName,
      'groupImage': groupImage,
      'lastMessage': lastMessage.toDocument(),
      'participants': participants,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      groupId: map['groupId'],
      groupName: map['groupName'],
      groupImage: map['groupImage'],
      lastMessage: Message.fromMap(map),
      participants: List<String>.from(map['participants']),
    );
  }

  @override
  List<Object> get props {
    return [
      groupId,
      groupName,
      groupImage,
      lastMessage,
      participants,
    ];
  }

  Group copyWith({
    String groupId,
    String groupName,
    String groupImage,
    Message lastMessage,
    List<String> participants,
    List<User> usersList,
  }) {
    return Group(
      groupId: groupId ?? this.groupId,
      groupName: groupName ?? this.groupName,
      groupImage: groupImage ?? this.groupImage,
      lastMessage: lastMessage ?? this.lastMessage,
      participants: participants ?? this.participants,
      usersList: usersList ?? this.usersList,
    );
  }
}

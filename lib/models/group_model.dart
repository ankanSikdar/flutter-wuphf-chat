import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:wuphf_chat/models/message_model.dart';

import 'models.dart';

class Group extends Equatable {
  final String groupId;
  final String groupName;
  final String groupImage;
  final DateTime createdAt;
  final String createdBy;
  final Message lastMessage;
  final List<String> participants;
  final List<User> usersList;

  Group({
    @required this.groupId,
    @required this.groupName,
    @required this.groupImage,
    @required this.createdAt,
    @required this.createdBy,
    @required this.lastMessage,
    @required this.participants,
    this.usersList,
  });

  Map<String, dynamic> toMap() {
    return {
      'groupId': groupId,
      'groupName': groupName,
      'groupImage': groupImage,
      'createdAt': Timestamp.fromDate(createdAt),
      'createdBy': createdBy,
      'lastMessage': lastMessage.toDocument(),
      'participants': participants,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      groupId: map['groupId'],
      groupName: map['groupName'],
      groupImage: map['groupImage'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      createdBy: map['createdBy'],
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
      createdAt,
      createdBy,
      lastMessage,
      participants,
    ];
  }

  Group copyWith({
    String groupId,
    String groupName,
    String groupImage,
    DateTime createdAt,
    String createdBy,
    Message lastMessage,
    List<String> participants,
    List<User> usersList,
  }) {
    return Group(
      groupId: groupId ?? this.groupId,
      groupName: groupName ?? this.groupName,
      groupImage: groupImage ?? this.groupImage,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      lastMessage: lastMessage ?? this.lastMessage,
      participants: participants ?? this.participants,
      usersList: usersList ?? this.usersList,
    );
  }
}

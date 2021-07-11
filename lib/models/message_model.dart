import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Message extends Equatable {
  final String id;
  final String sentBy;
  final DateTime sentAt;
  final String text;

  Message({
    @required this.id,
    @required this.sentBy,
    @required this.sentAt,
    @required this.text,
  });

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'sentBy': sentBy,
      'sentAt': Timestamp.fromDate(sentAt),
      'text': text,
    };
  }

  factory Message.fromDocument(DocumentSnapshot doc) {
    if (doc == null) return null;
    final data = doc.data() as Map;

    return Message(
      id: doc.id,
      sentBy: data['sentBy'] ?? '',
      sentAt: (data['sentAt'] as Timestamp).toDate(),
      text: data['text'] ?? '',
    );
  }

  factory Message.fromMap(Map data) {
    if (data == null) return null;

    return Message(
      id: data['id'],
      sentBy: data['sentBy'] ?? '',
      sentAt: (data['sentAt'] as Timestamp).toDate(),
      text: data['text'] ?? '',
    );
  }

  @override
  List<Object> get props => [id, sentAt, sentBy, text];

  Message copyWith({
    String id,
    String sentBy,
    DateTime sentAt,
    String text,
  }) {
    return Message(
      id: id ?? this.id,
      sentBy: sentBy ?? this.sentBy,
      sentAt: sentAt ?? this.sentAt,
      text: text ?? this.text,
    );
  }
}

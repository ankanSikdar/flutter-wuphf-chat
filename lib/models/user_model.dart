import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class User extends Equatable {
  final String id;
  final String displayName;
  final String email;
  final String profileImageUrl;
  final String bio;
  final bool presence;
  final DateTime lastSeen;

  const User({
    @required this.id,
    @required this.displayName,
    @required this.email,
    @required this.profileImageUrl,
    @required this.bio,
    this.presence = false,
    this.lastSeen,
  });

  Map<String, dynamic> toDocument() {
    return {
      'email': email,
      'displayName': displayName,
      'profileImageUrl': profileImageUrl,
      'bio': bio,
    };
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    if (doc == null) return null;
    final data = doc.data() as Map;
    return User(
      id: doc.id,
      displayName: data['displayName'] ?? '',
      email: data['email'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
      bio: data['bio'] ?? '',
      presence: data['presence'] ?? false,
      lastSeen: data['last_seen'] == null
          ? DateTime.now()
          : DateTime.fromMillisecondsSinceEpoch(data['last_seen']),
    );
  }

  //* It's useful to define a static empty User so that we don't have to handle null Users and can always work with a concrete User object.
  static const empty =
      User(id: '', displayName: '', email: '', profileImageUrl: '', bio: '');

  //* Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  //* Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object> get props {
    return [
      id,
      displayName,
      email,
      profileImageUrl,
      bio,
      presence,
      lastSeen,
    ];
  }

  User copyWith({
    String id,
    String displayName,
    String email,
    String profileImageUrl,
    String bio,
    bool presence,
    DateTime lastSeen,
  }) {
    return User(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      bio: bio ?? this.bio,
      presence: presence ?? this.presence,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }
}

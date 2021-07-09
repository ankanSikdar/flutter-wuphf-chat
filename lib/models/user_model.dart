import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class User extends Equatable {
  final String id;
  final String displayName;
  final String email;
  final String profileImageUrl;
  final String bio;

  User({
    @required this.id,
    @required this.displayName,
    @required this.email,
    @required this.profileImageUrl,
    @required this.bio,
  });

  @override
  List<Object> get props {
    return [
      id,
      displayName,
      email,
      profileImageUrl,
      bio,
    ];
  }

  User copyWith({
    String id,
    String displayName,
    String email,
    String profileImageUrl,
    String bio,
  }) {
    return User(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      bio: bio ?? this.bio,
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String profileImageUrl;
  final String bio;

  User({
    @required this.id,
    @required this.username,
    @required this.email,
    @required this.profileImageUrl,
    @required this.bio,
  });

  @override
  List<Object> get props {
    return [
      id,
      username,
      email,
      profileImageUrl,
      bio,
    ];
  }

  User copyWith({
    String id,
    String username,
    String email,
    String profileImageUrl,
    String bio,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      bio: bio ?? this.bio,
    );
  }
}

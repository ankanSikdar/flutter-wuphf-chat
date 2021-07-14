import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/repositories.dart';

part 'userprofile_event.dart';
part 'userprofile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserRepository _userRepository;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  UserProfileBloc({
    @required UserRepository userRepository,
    @required firebase_auth.FirebaseAuth firebaseAuth,
  })  : _userRepository = userRepository,
        _firebaseAuth = firebaseAuth,
        super(UserProfileState.initial());

  @override
  Stream<UserProfileState> mapEventToState(
    UserProfileEvent event,
  ) async* {
    if (event is LoadUserProfile) {
      yield* _mapLoadUserProfileToState();
    }
  }

  Stream<UserProfileState> _mapLoadUserProfileToState() async* {
    yield (state.copyWith(status: UserProfileStatus.loading));

    try {
      final userId = _firebaseAuth.currentUser.uid;
      final user = await _userRepository.getUserWithId(userId: userId);
      yield (state.copyWith(user: user, status: UserProfileStatus.loaded));
    } catch (e) {
      yield (state.copyWith(status: UserProfileStatus.error, error: e.message));
    }
  }
}

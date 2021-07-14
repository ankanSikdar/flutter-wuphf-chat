import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/repositories.dart';

part 'userprofile_event.dart';
part 'userprofile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final String _userId;
  final UserRepository _userRepository;

  UserProfileBloc({
    @required UserRepository userRepository,
    @required String userId,
  })  : _userId = userId,
        _userRepository = userRepository,
        super(UserProfileState.initial()) {
    add(LoadUserProfile());
  }

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
      final user = await _userRepository.getUserWithId(userId: _userId);
      yield (state.copyWith(user: user, status: UserProfileStatus.loaded));
    } catch (e) {
      yield (state.copyWith(status: UserProfileStatus.error, error: e.message));
    }
  }
}

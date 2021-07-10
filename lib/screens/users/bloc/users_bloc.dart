import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:wuphf_chat/bloc/blocs.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/user/user_repository.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final AuthBloc _authBloc;
  final UserRepository _userRepository;

  UsersBloc(
      {@required AuthBloc authBloc, @required UserRepository userRepository})
      : _authBloc = authBloc,
        _userRepository = userRepository,
        super(UsersState.inital());

  @override
  Stream<UsersState> mapEventToState(
    UsersEvent event,
  ) async* {
    if (event is UsersFetchUser) {
      yield* _mapUsersFetchUserToState();
    }
  }

  Stream<UsersState> _mapUsersFetchUserToState() async* {
    yield state.copyWith(status: UsersStateStatus.loading);
    try {
      final usersList = await _userRepository.getAllUsers();

      // Removing the current user from the usersList
      usersList.removeWhere((user) => user.id == _authBloc.state.user.uid);

      yield state.copyWith(
          usersList: usersList, status: UsersStateStatus.loaded);
    } catch (e) {
      yield state.copyWith(status: UsersStateStatus.error, error: e.message);
    }
  }
}

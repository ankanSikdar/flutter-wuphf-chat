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
  StreamSubscription _usersSubscription;

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
    if (event is UsersUpdateUser) {
      yield* _mapUsersUpdateUserToState(event);
    }
    if (event is UsersUpdateSearchList) {
      yield* _mapUsersUpdateSearchListToState(event);
    }
    if (event is UsersStopSearching) {
      yield* _mapUsersStopSearchingToState();
    }
  }

  @override
  Future<void> close() {
    _usersSubscription.cancel();
    super.close();
  }

  Stream<UsersState> _mapUsersFetchUserToState() async* {
    yield state.copyWith(status: UsersStateStatus.loading);
    try {
      _usersSubscription?.cancel();

      _usersSubscription = _userRepository.getAllUsers().listen((usersList) {
        add(UsersUpdateUser(usersList: usersList));
      });
    } catch (e) {
      yield state.copyWith(status: UsersStateStatus.error, error: e.message);
    }
  }

  Stream<UsersState> _mapUsersUpdateUserToState(UsersUpdateUser event) async* {
    // Removing the current user from the usersList
    event.usersList.removeWhere(
      (user) => user.id == _authBloc.state.user.uid,
    );

    yield state.copyWith(
        usersList: event.usersList, status: UsersStateStatus.loaded);
  }

  Stream<UsersState> _mapUsersUpdateSearchListToState(
      UsersUpdateSearchList event) async* {
    List<User> results = [];

    state.usersList.forEach((user) {
      if (user.displayName.toLowerCase().contains(event.name.toLowerCase())) {
        results.add(user);
      }
    });

    yield state.copyWith(
      searchList: results,
      status: UsersStateStatus.searching,
    );
  }

  Stream<UsersState> _mapUsersStopSearchingToState() async* {
    yield state.copyWith(searchList: [], status: UsersStateStatus.loaded);
  }
}

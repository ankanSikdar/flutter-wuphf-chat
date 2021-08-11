import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/repositories.dart';

part 'liveuser_event.dart';
part 'liveuser_state.dart';

class LiveUserBloc extends Bloc<LiveUserEvent, LiveUserState> {
  final UserRepository _userRepository;
  final String _userId;
  StreamSubscription _userSubscription;

  LiveUserBloc(
      {@required UserRepository userRepository, @required String userId})
      : _userRepository = userRepository,
        _userId = userId,
        super(LiveUserState.initial()) {
    add(GetUser());
  }

  @override
  Stream<LiveUserState> mapEventToState(
    LiveUserEvent event,
  ) async* {
    if (event is GetUser) {
      yield* _mapGetUserToState();
    }
    if (event is UpdateUser) {
      yield* _mapUpdateUserToState(event);
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    super.close();
  }

  Stream<LiveUserState> _mapGetUserToState() async* {
    try {
      yield state.copyWith(status: LiveUserStatus.loading);

      _userSubscription?.cancel();

      _userSubscription =
          _userRepository.getUserStream(userId: _userId).listen((user) {
        add(UpdateUser(user: user));
      });
    } catch (e) {
      yield state.copyWith(status: LiveUserStatus.error, error: e.message);
    }
  }

  Stream<LiveUserState> _mapUpdateUserToState(UpdateUser event) async* {
    yield state.copyWith(user: event.user, status: LiveUserStatus.loaded);
  }
}

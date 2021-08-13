import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:wuphf_chat/repositories/repositories.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final FirebaseMessaging _firebaseMessaging;
  StreamSubscription<firebase_auth.User> _userSubscription;

  AuthBloc(
      {@required AuthRepository authRepository,
      @required UserRepository userRepository})
      : _authRepository = authRepository,
        _userRepository = userRepository,
        _firebaseMessaging = FirebaseMessaging.instance,
        super(AuthState.unknown()) {
    _userSubscription = _authRepository.user.listen((user) {
      add(AuthUserChanged(user: user));
    });
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthUserChanged) {
      yield* _mapAuthUserChangedToState(event);
    }
    if (event is AuthUserLogOut) {
      yield* _mapAuthLogOutToState();
    }
  }

  Stream<AuthState> _mapAuthUserChangedToState(AuthUserChanged event) async* {
    // yield event.user != null
    //     ? AuthState.authenticated(user: event.user)
    //     : AuthState.unauthenticated();
    if (event.user != null) {
      try {
        final token = await _firebaseMessaging.getToken();
        await _userRepository.updateUserToken(
            userId: event.user.uid, token: token);
      } catch (e) {
        print('TOKEN ERROR: ${e.message}');
      }
      yield AuthState.authenticated(user: event.user);
    } else {
      yield AuthState.unauthenticated();
    }
  }

  Stream<AuthState> _mapAuthLogOutToState() async* {
    await _userRepository.updateUserToken(userId: state.user.uid, token: '');
    await _authRepository.logOut();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}

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
  final PresenceRepository _presenceRepository;
  final FirebaseMessaging _firebaseMessaging;
  StreamSubscription<firebase_auth.User> _userSubscription;
  StreamSubscription<String> _tokenRefreshStream;

  AuthBloc({
    @required AuthRepository authRepository,
    @required UserRepository userRepository,
    @required PresenceRepository presenceRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        _presenceRepository = presenceRepository,
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
    if (event is AppInBackgroundUpdatePresence) {
      yield* _mapAppInBackgroundUpdatePresence();
    }
    if (event is AppResumedUpdatePresence) {
      yield* _mapAppResumedUpdatePresence();
    }
  }

  Stream<AuthState> _mapAuthUserChangedToState(AuthUserChanged event) async* {
    // yield event.user != null
    //     ? AuthState.authenticated(user: event.user)
    //     : AuthState.unauthenticated();
    if (event.user != null) {
      try {
        //Update user presence
        // No need for await
        _presenceRepository.updateUserPresence();

        //Update user token
        final token = await _firebaseMessaging.getToken();
        await _userRepository.updateUserToken(
            userId: event.user.uid, token: token);

        _tokenRefreshStream?.cancel();
        _tokenRefreshStream =
            _firebaseMessaging.onTokenRefresh.listen((newToken) async {
          await _userRepository.updateUserToken(
              userId: event.user.uid, token: token);
        });
      } catch (e) {
        //* Preparing For Release
        // print('TOKEN ERROR: ${e.message}');
      }

      yield AuthState.authenticated(user: event.user);
    } else {
      yield AuthState.unauthenticated();
    }
  }

  Stream<AuthState> _mapAppInBackgroundUpdatePresence() async* {
    if (state.user == null) {
      return;
    }
    await _presenceRepository.onAppInBackground(uid: state.user.uid);
  }

  Stream<AuthState> _mapAppResumedUpdatePresence() async* {
    if (state.user == null) {
      return;
    }

    await _presenceRepository.onAppResumed(uid: state.user.uid);
  }

  Stream<AuthState> _mapAuthLogOutToState() async* {
    await _presenceRepository.onUserLoggedOut(uid: state.user.uid);
    await _userRepository.updateUserToken(userId: state.user.uid, token: '');
    await _authRepository.logOut();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _tokenRefreshStream.cancel();
    return super.close();
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:wuphf_chat/repositories/repositories.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository _authRepository;

  SignUpCubit({@required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignUpState.initial());

  void reset() {
    emit(SignUpState.initial());
  }

  void emailChanged(String value) {
    emit(state.copyWith(email: value));
  }

  void displayNameChanged(String value) {
    emit(state.copyWith(displayName: value));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value));
  }

  Future<void> sendPasswordResetMail() async {
    try {
      await _authRepository.forgotPassword(email: state.email);
    } catch (e) {
      emit(state.copyWith(status: SignUpStatus.error, error: e.message));
    }
  }

  Future<void> singUpWithCredentials() async {
    // If already in state of submitting
    if (state.status == SignUpStatus.submitting) return;

    // Double check to see credentials are not empty
    if (state.email.isEmpty ||
        state.displayName.isEmpty ||
        state.password.isEmpty) return;

    // Creating a new account using auth repository
    emit(state.copyWith(status: SignUpStatus.submitting));
    try {
      await _authRepository.signUpWithEmailAndPassword(
        displayName: state.displayName,
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: SignUpStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SignUpStatus.error, error: e.message));
    }
  }

  Future<void> loginWithCredentials() async {
    // If already in state of submitting
    if (state.status == SignUpStatus.submitting) return;

    // Double check to see credentials are not empty
    if (state.email.isEmpty || state.password.isEmpty) return;

    // Logging in the user
    emit(state.copyWith(status: SignUpStatus.submitting));
    try {
      await _authRepository.loginWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: SignUpStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SignUpStatus.error, error: e.message));
    }
  }
}

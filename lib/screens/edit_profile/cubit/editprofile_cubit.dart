import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/repositories.dart';

part 'editprofile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final User _user;
  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  final StorageRepository _storageRepository;

  EditProfileCubit({
    @required User user,
    @required UserRepository userRepository,
    @required AuthRepository authRepository,
    @required StorageRepository storageRepository,
  })  : _userRepository = userRepository,
        _user = user,
        _authRepository = authRepository,
        _storageRepository = storageRepository,
        super(EditProfileState.inital()) {
    emit(state.copyWith(
      displayName: _user.displayName,
      email: _user.email,
      bio: _user.bio,
      profileImageUrl: _user.profileImageUrl,
    ));
  }

  Future<void> emailChanged(String value) {
    emit(state.copyWith(email: value));
  }

  Future<void> displayNameChanged(String value) {
    emit(state.copyWith(displayName: value));
  }

  Future<void> bioChanged(String value) {
    emit(state.copyWith(bio: value.trimLeft().trimRight()));
  }

  Future<void> profileImageChanged(File file) {
    emit(state.copyWith(newProfileImage: file));
  }

  Future<void> _updateEmailAndDisplayNameIfChangedInAuthRepo() async {
    try {
      if (_user.email != state.email) {
        await _authRepository.updateEmail(email: state.email);
      }
      if (_user.displayName != state.displayName) {
        await _authRepository.updateDisplayName(displayName: state.displayName);
      }
    } catch (e) {
      throw Exception(e.message);
    }
  }

  Future<String> _uploadProfilePicture({@required File file}) async {
    try {
      final downloadUrl = await _storageRepository.uploadProfileImage(
        userId: _user.id,
        file: file,
      );
      return downloadUrl;
    } catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> submitForm() async {
    emit(state.copyWith(status: EditProfileStatus.submitting));
    try {
      await _updateEmailAndDisplayNameIfChangedInAuthRepo();

      if (state.newProfileImage != null) {
        final newProfileImageUrl =
            await _uploadProfilePicture(file: state.newProfileImage);
        emit(state.copyWith(profileImageUrl: newProfileImageUrl));
      }

      await _userRepository.updateUser(
          user: User(
        id: _user.id,
        displayName: state.displayName,
        email: state.email,
        profileImageUrl: state.profileImageUrl,
        bio: state.bio,
      ));
      emit(state.copyWith(status: EditProfileStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditProfileStatus.error, error: e.message));
    }
  }

  void reset() {
    emit(state.copyWith(
      status: EditProfileStatus.intial,
      error: '',
    ));
  }
}

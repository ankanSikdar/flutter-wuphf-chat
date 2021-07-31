import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/repositories.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

part 'creategroup_state.dart';

class CreateGroupCubit extends Cubit<CreateGroupState> {
  final StorageRepository _storageRepository;
  final GroupsRepository _groupsRepository;

  CreateGroupCubit({
    @required List<User> participants,
    @required UserRepository userRepository,
    @required StorageRepository storageRepository,
    @required GroupsRepository groupsRepository,
    firebase_auth.FirebaseAuth firebaseAuth,
  })  : _storageRepository = storageRepository,
        _groupsRepository = groupsRepository,
        super(CreateGroupState.initial(participants: participants));

  Future<void> groupNameChanged(String value) {
    emit(state.copyWith(groupName: value.trim()));
  }

  Future<void> groupImageChanged(File file) {
    emit(state.copyWith(newGroupImage: file));
  }

  Future<String> _uploadGroupImage({@required File file}) async {
    try {
      final downloadUrl = await _storageRepository.uploadGroupImage(
        file: file,
      );
      return downloadUrl;
    } catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> submitForm() async {
    emit(state.copyWith(status: CreateGroupStatus.submitting));
    try {
      if (state.newGroupImage != null) {
        final newGroupDPImageUrl =
            await _uploadGroupImage(file: state.newGroupImage);
        emit(state.copyWith(groupImageUrl: newGroupDPImageUrl));
      }

      final List<String> participantIds =
          state.participants.map((user) => user.id).toList();

      await _groupsRepository.createGroup(
        groupName: state.groupName,
        groupImageUrl: state.groupImageUrl,
        participants: participantIds,
      );

      emit(state.copyWith(status: CreateGroupStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CreateGroupStatus.error, error: e.message));
    }
  }

  void reset() {
    // Default Image and Participants are not reset
    emit(state.copyWith(
      status: CreateGroupStatus.initial,
      groupName: '',
      newGroupImage: null,
      error: '',
    ));
  }
}

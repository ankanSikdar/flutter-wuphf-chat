import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/repositories.dart';

part 'editgroup_state.dart';

class EditGroupCubit extends Cubit<EditGroupState> {
  final GroupsRepository _groupsRepository;
  final StorageRepository _storageRepository;

  EditGroupCubit({
    @required Group group,
    @required GroupsRepository groupsRepository,
    @required StorageRepository storageRepository,
  })  : _groupsRepository = groupsRepository,
        _storageRepository = storageRepository,
        super(
          EditGroupState.initial(
            groupId: group.groupId,
            groupName: group.groupName,
            groupImageUrl: group.groupImage,
          ),
        );

  Future<void> groupNameChanged(String value) {
    emit(state.copyWith(groupName: value.trim()));
  }

  Future<void> groupImageChanged(File file) {
    emit(state.copyWith(newGroupImage: file));
  }

  Future<String> _uploadGroupProfilePicture({@required File file}) async {
    try {
      final downloadUrl = await _storageRepository.uploadGroupImage(file: file);
      return downloadUrl;
    } catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> submitForm() async {
    emit(state.copyWith(status: EditGroupStatus.submitting));
    try {
      if (state.newGroupImage != null) {
        final newProfileImageUrl =
            await _uploadGroupProfilePicture(file: state.newGroupImage);
        emit(state.copyWith(groupImageUrl: newProfileImageUrl));
      }

      await _groupsRepository.updateGroupDetails(
          groupId: state.groupId,
          name: state.groupName,
          imageUrl: state.groupImageUrl);

      emit(state.copyWith(status: EditGroupStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditGroupStatus.error, error: e.message));
    }
  }

  void reset() {
    emit(state.copyWith(
      status: EditGroupStatus.initial,
      error: '',
    ));
  }
}

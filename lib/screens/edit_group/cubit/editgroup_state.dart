part of 'editgroup_cubit.dart';

enum EditGroupStatus {
  initial,
  submitting,
  success,
  error,
}

class EditGroupState extends Equatable {
  final String groupId;
  final String groupName;
  final String groupImageUrl;
  final File newGroupImage;
  final EditGroupStatus status;
  final String error;

  EditGroupState({
    @required this.groupId,
    @required this.groupName,
    @required this.groupImageUrl,
    @required this.newGroupImage,
    @required this.status,
    @required this.error,
  });

  factory EditGroupState.initial({
    @required String groupId,
    @required String groupName,
    @required String groupImageUrl,
  }) {
    return EditGroupState(
      groupId: groupId,
      groupName: groupName,
      groupImageUrl: groupImageUrl,
      newGroupImage: null,
      status: EditGroupStatus.initial,
      error: '',
    );
  }

  @override
  List<Object> get props => [
        groupId,
        groupName,
        groupImageUrl,
        newGroupImage,
        status,
        error,
      ];

  EditGroupState copyWith({
    String groupId,
    String groupName,
    String groupImageUrl,
    File newGroupImage,
    EditGroupStatus status,
    String error,
  }) {
    return EditGroupState(
      groupId: groupId ?? this.groupId,
      groupName: groupName ?? this.groupName,
      groupImageUrl: groupImageUrl ?? this.groupImageUrl,
      newGroupImage: newGroupImage ?? this.newGroupImage,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

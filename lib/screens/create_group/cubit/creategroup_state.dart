part of 'creategroup_cubit.dart';

enum CreateGroupStatus {
  initial,
  submitting,
  success,
  error,
}

class CreateGroupState extends Equatable {
  final String groupName;
  final String groupImageUrl;
  final File newGroupImage;
  final List<User> participants;
  final CreateGroupStatus status;
  final String error;

  const CreateGroupState({
    @required this.groupName,
    @required this.groupImageUrl,
    @required this.newGroupImage,
    @required this.participants,
    @required this.status,
    @required this.error,
  });

  factory CreateGroupState.initial({@required List<User> participants}) {
    return CreateGroupState(
      groupName: '',
      groupImageUrl:
          'https://firebasestorage.googleapis.com/v0/b/wuphf-chat-flutter.appspot.com/o/images%2FgroupPictures%2FdefaultGroupDp.png?alt=media&token=8cd72c91-ea44-478b-98a1-555150eb2586',
      newGroupImage: null,
      participants: participants,
      status: CreateGroupStatus.initial,
      error: '',
    );
  }

  @override
  List<Object> get props => [
        groupName,
        groupImageUrl,
        newGroupImage,
        participants,
        status,
        error,
      ];

  CreateGroupState copyWith({
    String groupName,
    String groupImageUrl,
    File newGroupImage,
    List<User> participants,
    CreateGroupStatus status,
    String error,
  }) {
    return CreateGroupState(
      groupName: groupName ?? this.groupName,
      groupImageUrl: groupImageUrl ?? this.groupImageUrl,
      newGroupImage: newGroupImage ?? this.newGroupImage,
      participants: participants ?? this.participants,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

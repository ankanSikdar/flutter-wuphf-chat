part of 'groupchatting_bloc.dart';

enum GroupChattingStatus {
  initial,
  loading,
  loaded,
  error,
}

class GroupChattingState extends Equatable {
  final String groupDbId;
  final List<Message> messagesList;
  final bool isSending;
  final GroupChattingStatus status;
  final String error;

  GroupChattingState({
    @required this.groupDbId,
    @required this.messagesList,
    @required this.isSending,
    @required this.status,
    @required this.error,
  });

  factory GroupChattingState.initial({@required String groupDbId}) {
    return GroupChattingState(
      groupDbId: groupDbId,
      messagesList: [],
      isSending: false,
      status: GroupChattingStatus.initial,
      error: '',
    );
  }

  @override
  List<Object> get props => [
        groupDbId,
        messagesList,
        isSending,
        status,
        error,
      ];

  GroupChattingState copyWith({
    String groupDbId,
    List<Message> messagesList,
    bool isSending,
    GroupChattingStatus status,
    String error,
  }) {
    return GroupChattingState(
      groupDbId: groupDbId ?? this.groupDbId,
      messagesList: messagesList ?? this.messagesList,
      isSending: isSending ?? this.isSending,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

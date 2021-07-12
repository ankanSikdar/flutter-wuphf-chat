part of 'chatting_bloc.dart';

enum ChattingStatus {
  intial,
  loading,
  loaded,
  error,
}

class ChattingState extends Equatable {
  final User user;
  final List<Message> messagesList;
  final DocumentReference messagesDbRef;
  final bool hasMessagedBefore;
  final ChattingStatus status;
  final String error;

  ChattingState({
    @required this.user,
    @required this.messagesList,
    @required this.messagesDbRef,
    @required this.hasMessagedBefore,
    @required this.status,
    @required this.error,
  });

  factory ChattingState.initial(
      {@required User user, DocumentReference messagesDbRef}) {
    return ChattingState(
      user: user,
      messagesList: [],
      messagesDbRef: messagesDbRef,
      hasMessagedBefore: null,
      status: ChattingStatus.intial,
      error: '',
    );
  }

  @override
  List<Object> get props => [
        user,
        messagesList,
        hasMessagedBefore,
        messagesDbRef,
        status,
        error,
      ];

  ChattingState copyWith({
    User user,
    List<Message> messagesList,
    DocumentReference messagesDbRef,
    bool hasMessagedBefore,
    ChattingStatus status,
    String error,
  }) {
    return ChattingState(
      user: user ?? this.user,
      messagesList: messagesList ?? this.messagesList,
      messagesDbRef: messagesDbRef ?? this.messagesDbRef,
      hasMessagedBefore: hasMessagedBefore ?? this.hasMessagedBefore,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

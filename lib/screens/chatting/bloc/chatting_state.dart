part of 'chatting_bloc.dart';

enum ChattingStatus {
  initial,
  loading,
  loaded,
  error,
}

class ChattingState extends Equatable {
  final String userId;
  final List<Message> messagesList;
  final DocumentReference messagesDbRef;
  final bool hasMessagedBefore;
  final bool isSending;
  final ChattingStatus status;
  final String error;

  ChattingState({
    @required this.userId,
    @required this.messagesList,
    @required this.messagesDbRef,
    @required this.hasMessagedBefore,
    @required this.isSending,
    @required this.status,
    @required this.error,
  });

  factory ChattingState.initial(
      {@required String userId, DocumentReference messagesDbRef}) {
    return ChattingState(
      userId: userId,
      messagesList: [],
      messagesDbRef: messagesDbRef,
      hasMessagedBefore: null,
      isSending: false,
      status: ChattingStatus.initial,
      error: '',
    );
  }

  @override
  List<Object> get props => [
        userId,
        messagesList,
        hasMessagedBefore,
        messagesDbRef,
        isSending,
        status,
        error,
      ];

  ChattingState copyWith({
    String userId,
    List<Message> messagesList,
    DocumentReference messagesDbRef,
    bool hasMessagedBefore,
    bool isSending,
    ChattingStatus status,
    String error,
  }) {
    return ChattingState(
      userId: userId ?? this.userId,
      messagesList: messagesList ?? this.messagesList,
      messagesDbRef: messagesDbRef ?? this.messagesDbRef,
      hasMessagedBefore: hasMessagedBefore ?? this.hasMessagedBefore,
      isSending: isSending ?? this.isSending,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

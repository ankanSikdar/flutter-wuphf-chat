part of 'chats_bloc.dart';

enum ChatsStatus { initial, loading, loaded, error }

class ChatsState extends Equatable {
  final List<ChatUser> chatUsers;
  final ChatsStatus status;
  final String error;

  const ChatsState({
    @required this.chatUsers,
    @required this.status,
    @required this.error,
  });

  factory ChatsState.initial() {
    return ChatsState(
      chatUsers: [],
      status: ChatsStatus.initial,
      error: '',
    );
  }

  @override
  List<Object> get props => [chatUsers, status, error];

  ChatsState copyWith({
    List<ChatUser> chatUsers,
    ChatsStatus status,
    String error,
  }) {
    return ChatsState(
      chatUsers: chatUsers ?? this.chatUsers,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

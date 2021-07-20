part of 'chats_bloc.dart';

enum ChatsStatus { initial, loading, loaded, searching, error }

class ChatsState extends Equatable {
  final List<ChatUser> chatUsers;
  final List<ChatUser> searchList;
  final ChatsStatus status;
  final String error;

  const ChatsState({
    @required this.chatUsers,
    @required this.searchList,
    @required this.status,
    @required this.error,
  });

  factory ChatsState.initial() {
    return ChatsState(
      chatUsers: [],
      searchList: [],
      status: ChatsStatus.initial,
      error: '',
    );
  }

  @override
  List<Object> get props => [chatUsers, searchList, status, error];

  ChatsState copyWith({
    List<ChatUser> chatUsers,
    List<ChatUser> searchList,
    ChatsStatus status,
    String error,
  }) {
    return ChatsState(
      chatUsers: chatUsers ?? this.chatUsers,
      searchList: searchList ?? this.searchList,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

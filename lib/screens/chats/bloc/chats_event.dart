part of 'chats_bloc.dart';

abstract class ChatsEvent extends Equatable {
  const ChatsEvent();

  @override
  List<Object> get props => [];
}

class FetchChats extends ChatsEvent {}

class UpdateChats extends ChatsEvent {
  final List<ChatUser> chatUsers;

  UpdateChats({
    @required this.chatUsers,
  });

  @override
  List<Object> get props => [chatUsers];
}

class SearchChats extends ChatsEvent {
  final String name;

  SearchChats({@required this.name});

  @override
  List<Object> get props => [name];
}

class StopSearch extends ChatsEvent {}

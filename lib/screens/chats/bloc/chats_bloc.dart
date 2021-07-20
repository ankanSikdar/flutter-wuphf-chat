import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/repositories.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final MessagesRepository _messagesRepository;

  ChatsBloc({@required MessagesRepository messagesRepository})
      : _messagesRepository = messagesRepository,
        super(ChatsState.initial());

  StreamSubscription<List<Future<ChatUser>>> _chatsSubscription;

  @override
  Stream<ChatsState> mapEventToState(
    ChatsEvent event,
  ) async* {
    if (event is FetchChats) {
      yield* _mapChatsFetchChatsToState();
    }
    if (event is UpdateChats) {
      yield* _mapChatsUpdateChatsToState(event);
    }
    if (event is SearchChats) {
      yield* _mapSearchChatsToState(event);
    }
    if (event is StopSearch) {
      yield* _mapStopSearchToState();
    }
  }

  Stream<ChatsState> _mapChatsFetchChatsToState() async* {
    yield (state.copyWith(status: ChatsStatus.loading));

    try {
      _chatsSubscription?.cancel();

      _chatsSubscription =
          _messagesRepository.getUserChatList().listen((chatUsersFuture) async {
        final chatUsers = await Future.wait(chatUsersFuture);
        add(UpdateChats(chatUsers: chatUsers));
      });
    } catch (e) {
      yield (state.copyWith(status: ChatsStatus.error, error: e.message));
    }
  }

  Stream<ChatsState> _mapChatsUpdateChatsToState(UpdateChats event) async* {
    yield (state.copyWith(
        chatUsers: event.chatUsers, status: ChatsStatus.loaded));
  }

  Stream<ChatsState> _mapSearchChatsToState(SearchChats event) async* {
    List<ChatUser> results = [];

    state.chatUsers.forEach((chatUser) {
      if (chatUser.user.displayName
          .toLowerCase()
          .contains(event.name.toLowerCase())) {
        results.add(chatUser);
      }
    });

    yield state.copyWith(
      searchList: results,
      status: ChatsStatus.searching,
    );
  }

  Stream<ChatsState> _mapStopSearchToState() async* {
    yield (state.copyWith(
      searchList: [],
      status: ChatsStatus.loaded,
    ));
  }

  @override
  Future<void> close() {
    _chatsSubscription.cancel();
    super.close();
  }
}

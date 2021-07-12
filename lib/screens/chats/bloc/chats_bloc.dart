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

      yield (state.copyWith(status: ChatsStatus.loaded));
    } catch (e) {
      yield (state.copyWith(status: ChatsStatus.error, error: e.message));
    }
  }

  Stream<ChatsState> _mapChatsUpdateChatsToState(UpdateChats event) async* {
    yield (state.copyWith(chatUsers: event.chatUsers));
  }

  @override
  Future<void> close() {
    _chatsSubscription.cancel();
    super.close();
  }
}

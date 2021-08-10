import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/repositories.dart';

part 'groupchatting_event.dart';
part 'groupchatting_state.dart';

class GroupChattingBloc extends Bloc<GroupChattingEvent, GroupChattingState> {
  final GroupsRepository _groupsRepository;
  StreamSubscription<List<Message>> _messagesSubscription;

  GroupChattingBloc({
    @required String groupDbId,
    @required GroupsRepository groupsRepository,
  })  : _groupsRepository = groupsRepository,
        super(GroupChattingState.initial(groupDbId: groupDbId)) {
    add(FetchMessages());
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    super.close();
  }

  @override
  Stream<GroupChattingState> mapEventToState(
    GroupChattingEvent event,
  ) async* {
    if (event is SendMessage) {
      yield* _mapSendMessageToState(event);
    }
    if (event is FetchMessages) {
      yield* _mapFetchMessagesToState();
    }
    if (event is UpdateMessages) {
      yield* _mapUpdateMessagesToState(event);
    }
  }

  Stream<GroupChattingState> _mapSendMessageToState(SendMessage event) async* {
    try {
      yield (state.copyWith(isSending: true));

      await _groupsRepository.sendMessage(
          groupId: state.groupDbId, text: event.message, image: event.image);

      yield (state.copyWith(isSending: false));
    } catch (e) {
      yield (state.copyWith(
          isSending: false,
          status: GroupChattingStatus.error,
          error: e.message));
    }
  }

  Stream<GroupChattingState> _mapFetchMessagesToState() async* {
    try {
      yield (state.copyWith(status: GroupChattingStatus.loading));

      _messagesSubscription?.cancel();
      _messagesSubscription = _groupsRepository
          .getGroupMessagesList(groupId: state.groupDbId)
          .listen((messagesList) {
        add(UpdateMessages(messagesList: messagesList));
      });
    } catch (e) {
      yield (state.copyWith(
          status: GroupChattingStatus.error, error: e.message));
    }
  }

  Stream<GroupChattingState> _mapUpdateMessagesToState(
      UpdateMessages event) async* {
    yield (state.copyWith(
        messagesList: event.messagesList, status: GroupChattingStatus.loaded));
  }
}

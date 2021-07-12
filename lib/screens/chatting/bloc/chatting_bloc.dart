import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/repositories.dart';

part 'chatting_event.dart';
part 'chatting_state.dart';

class ChattingBloc extends Bloc<ChattingEvent, ChattingState> {
  final MessagesRepository _messagesRepository;
  StreamSubscription<List<Message>> _messagesSubscription;

  ChattingBloc({
    @required MessagesRepository messagesRepository,
    @required User user,
    DocumentReference messagesRef,
  })  : _messagesRepository = messagesRepository,
        super(ChattingState.initial(user: user, messagesDbRef: messagesRef)) {
    add(ChattingCheckHasMessagedBefore());
  }

  @override
  Stream<ChattingState> mapEventToState(
    ChattingEvent event,
  ) async* {
    if (event is ChattingCheckHasMessagedBefore) {
      yield* _mapCheckHasMessagedBeforeToState();
    }
    if (event is ChattingSendMessage) {
      yield* _mapSendMessageToState(event);
    }
    if (event is ChattingFetchMessages) {
      yield* _mapFetchMessagesToState();
    }
    if (event is ChattingUpdateMessages) {
      yield* _mapUpdateMessagesToState(event);
    }
  }

  Stream<ChattingState> _mapCheckHasMessagedBeforeToState() async* {
    if (state.messagesDbRef != null) {
      // Navigated from chatScreen
      yield (state.copyWith(hasMessagedBefore: true));
      add(ChattingFetchMessages());
    } else {
      // Navigated from usersScreen
      final check =
          await _messagesRepository.checkMessagesExists(user: state.user);
      if (check == true) {
        final messagesDb = await _messagesRepository
            .getAlreadyPresentMessagesDb(user: state.user);
        yield (state.copyWith(
            messagesDbRef: messagesDb, hasMessagedBefore: true));
        add(ChattingFetchMessages());
      } else {
        yield (state.copyWith(hasMessagedBefore: false));
      }
    }
  }

  Stream<ChattingState> _mapSendMessageToState(
      ChattingSendMessage event) async* {
    if (state.hasMessagedBefore) {
      await _messagesRepository.sendMessage(
        recipientId: state.user.id,
        documentReference: state.messagesDbRef,
        message: event.message,
      );
    } else {
      final messagesDbRef = await _messagesRepository.sendFirstMessage(
          user: state.user, message: event.message);
      yield (state.copyWith(
          hasMessagedBefore: true, messagesDbRef: messagesDbRef));
      add(ChattingFetchMessages());
    }
  }

  Stream<ChattingState> _mapFetchMessagesToState() async* {
    yield (state.copyWith(status: ChattingStatus.loading));
    if (state.hasMessagedBefore == false) {
      yield (state.copyWith(status: ChattingStatus.loaded));
    } else {
      _messagesSubscription?.cancel();
      _messagesSubscription = _messagesRepository
          .getMessagesList(messagesDbRef: state.messagesDbRef)
          .listen((messages) {
        add(ChattingUpdateMessages(messagesList: messages));
      });
      yield (state.copyWith(status: ChattingStatus.loaded));
    }
  }

  Stream<ChattingState> _mapUpdateMessagesToState(
      ChattingUpdateMessages event) async* {
    yield (state.copyWith(messagesList: event.messagesList));
  }
}

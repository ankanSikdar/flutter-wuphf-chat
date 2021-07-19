import 'dart:async';
import 'dart:io';

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
  Future<void> close() {
    _messagesSubscription?.cancel();
    super.close();
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

  // Check if user has messaged this person before
  Stream<ChattingState> _mapCheckHasMessagedBeforeToState() async* {
    try {
      if (state.messagesDbRef != null) {
        // Navigated from chatScreen
        // Therefore user must have messaged this person before
        // And messagesDbRef is present so we can fetch all the messages
        yield (state.copyWith(hasMessagedBefore: true));
        add(ChattingFetchMessages());
      } else {
        // Navigated from usersScreen
        // Therefore we have to check to see if user has messaged this person before
        final check =
            await _messagesRepository.checkMessagesExists(user: state.user);
        if (check == true) {
          // User has messaged this person before
          final messagesDb = await _messagesRepository
              .getAlreadyPresentMessagesDb(user: state.user);
          yield (state.copyWith(
              messagesDbRef: messagesDb, hasMessagedBefore: true));
          add(ChattingFetchMessages());
        } else {
          // User has no messages with this person
          yield (state.copyWith(hasMessagedBefore: false));
        }
      }
    } catch (e) {
      yield (state.copyWith(status: ChattingStatus.error, error: e.message));
    }
  }

  // Sending a new message
  Stream<ChattingState> _mapSendMessageToState(
      ChattingSendMessage event) async* {
    yield (state.copyWith(
        isSending: true)); // To show the LinearProgressIndicator
    try {
      if (state.hasMessagedBefore) {
        // User already has a messageDb with this person therefore we just add the message to it
        await _messagesRepository.sendMessage(
          recipientId: state.user.id,
          documentReference: state.messagesDbRef,
          message: event.message,
          image: event.image,
        );
      } else {
        // User has no messageDb with this person
        // We create the db and send the first message
        final messagesDbRef = await _messagesRepository.sendFirstMessage(
          user: state.user,
          message: event.message,
          image: event.image,
        );

        // We add the messagesDb to state
        yield state.copyWith(messagesDbRef: messagesDbRef);
        // Now checking for has messaged before will be true and it will load the messages
        add(ChattingCheckHasMessagedBefore());
      }
      yield (state.copyWith(
          isSending: false)); // To hide the LinearProgressIndicator
    } catch (e) {
      yield (state.copyWith(
          status: ChattingStatus.error, error: e.message, isSending: false));
    }
  }

  // Getting the stream of messages
  Stream<ChattingState> _mapFetchMessagesToState() async* {
    try {
      yield (state.copyWith(status: ChattingStatus.loading));
      if (state.hasMessagedBefore == false) {
        // Double check to ensure user has messaged this person before and messageDb exists
        yield (state.copyWith(status: ChattingStatus.loaded));
      } else {
        // Creating a new messagesSubscription and canceling any old one present
        _messagesSubscription?.cancel();
        _messagesSubscription = _messagesRepository
            .getMessagesList(messagesDbRef: state.messagesDbRef)
            .listen((messages) {
          add(ChattingUpdateMessages(messagesList: messages));
        });
        // yield (state.copyWith(status: ChattingStatus.loaded, isSending: false));
      }
    } catch (e) {
      yield (state.copyWith(status: ChattingStatus.error, error: e.message));
    }
  }

  // Updating messagesList
  Stream<ChattingState> _mapUpdateMessagesToState(
      ChattingUpdateMessages event) async* {
    // Adding the messagesList with the new messageList
    yield (state.copyWith(
        messagesList: event.messagesList, status: ChattingStatus.loaded));
  }
}

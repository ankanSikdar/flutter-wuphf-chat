part of 'chatting_bloc.dart';

abstract class ChattingEvent extends Equatable {
  const ChattingEvent();

  @override
  List<Object> get props => [];
}

class ChattingCheckHasMessagedBefore extends ChattingEvent {}

class ChattingSendMessage extends ChattingEvent {
  final String message;
  ChattingSendMessage({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}

class ChattingFetchMessages extends ChattingEvent {}

class ChattingUpdateMessages extends ChattingEvent {
  final List<Message> messagesList;
  ChattingUpdateMessages({
    @required this.messagesList,
  });

  @override
  List<Object> get props => [messagesList];
}

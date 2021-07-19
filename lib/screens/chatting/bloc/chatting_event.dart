part of 'chatting_bloc.dart';

abstract class ChattingEvent extends Equatable {
  const ChattingEvent();

  @override
  List<Object> get props => [];
}

class ChattingCheckHasMessagedBefore extends ChattingEvent {}

class ChattingSendMessage extends ChattingEvent {
  final String message;
  final File image;

  ChattingSendMessage({
    @required this.message,
    this.image,
  });

  @override
  List<Object> get props => [message, image];
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

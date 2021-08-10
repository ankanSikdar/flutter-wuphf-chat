part of 'groupchatting_bloc.dart';

abstract class GroupChattingEvent extends Equatable {
  const GroupChattingEvent();

  @override
  List<Object> get props => [];
}

class SendMessage extends GroupChattingEvent {
  final String message;
  final File image;

  SendMessage({
    @required this.message,
    this.image,
  });

  @override
  List<Object> get props => [message, image];
}

class FetchMessages extends GroupChattingEvent {}

class UpdateMessages extends GroupChattingEvent {
  final List<Message> messagesList;

  UpdateMessages({
    @required this.messagesList,
  });

  @override
  List<Object> get props => [messagesList];
}

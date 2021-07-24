part of 'liveuser_bloc.dart';

abstract class LiveUserEvent extends Equatable {
  const LiveUserEvent();

  @override
  List<Object> get props => [];
}

class GetUser extends LiveUserEvent {}

class UpdateUser extends LiveUserEvent {
  final User user;

  UpdateUser({this.user});

  @override
  List<Object> get props => [user];
}

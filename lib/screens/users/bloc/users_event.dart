part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class UsersFetchUser extends UsersEvent {}

class UsersUpdateUser extends UsersEvent {
  final List<User> usersList;

  UsersUpdateUser({@required this.usersList});

  @override
  List<Object> get props => [usersList];
}

class UsersUpdateSearchList extends UsersEvent {
  final String name;

  UsersUpdateSearchList({this.name});

  @override
  List<Object> get props => [name];
}

class UsersStopSearching extends UsersEvent {}

class UsersUpdateSelectedList extends UsersEvent {
  final User user;

  UsersUpdateSelectedList({this.user});

  @override
  List<Object> get props => [user];
}

class UsersStopSelecting extends UsersEvent {}

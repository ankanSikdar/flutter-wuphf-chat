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

part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthUserChanged extends AuthEvent {
  final firebase_auth.User user;

  AuthUserChanged({
    @required this.user,
  });

  @override
  List<Object> get props => [user];
}

class AuthUserLogOut extends AuthEvent {}

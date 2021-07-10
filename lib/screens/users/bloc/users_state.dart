part of 'users_bloc.dart';

enum UsersStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class UsersState extends Equatable {
  final List<User> usersList;
  final UsersStateStatus status;
  final String error;

  const UsersState({
    @required this.usersList,
    @required this.status,
    @required this.error,
  });

  factory UsersState.inital() {
    return UsersState(
      usersList: [],
      status: UsersStateStatus.initial,
      error: '',
    );
  }

  @override
  List<Object> get props => [usersList, status, error];

  UsersState copyWith({
    List<User> usersList,
    UsersStateStatus status,
    String error,
  }) {
    return UsersState(
      usersList: usersList ?? this.usersList,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

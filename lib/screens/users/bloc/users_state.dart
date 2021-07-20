part of 'users_bloc.dart';

enum UsersStateStatus {
  initial,
  loading,
  loaded,
  searching,
  error,
}

class UsersState extends Equatable {
  final List<User> usersList;
  final List<User> searchList;
  final UsersStateStatus status;
  final String error;

  const UsersState({
    @required this.usersList,
    @required this.searchList,
    @required this.status,
    @required this.error,
  });

  factory UsersState.inital() {
    return UsersState(
      usersList: [],
      searchList: [],
      status: UsersStateStatus.initial,
      error: '',
    );
  }

  @override
  List<Object> get props => [usersList, status, searchList, error];

  UsersState copyWith({
    List<User> usersList,
    List<User> searchList,
    UsersStateStatus status,
    String error,
  }) {
    return UsersState(
      usersList: usersList ?? this.usersList,
      searchList: searchList ?? this.searchList,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

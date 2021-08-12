part of 'users_bloc.dart';

enum UsersStateStatus {
  initial,
  loading,
  loaded,
  searching,
  selecting,
  error,
}

class UsersState extends Equatable {
  final List<User> usersList;
  final List<User> searchList;
  final List<User> selectedList;
  final UsersStateStatus status;
  final String error;

  const UsersState({
    @required this.usersList,
    @required this.searchList,
    @required this.selectedList,
    @required this.status,
    @required this.error,
  });

  factory UsersState.initial() {
    return UsersState(
      usersList: [],
      searchList: [],
      selectedList: [],
      status: UsersStateStatus.initial,
      error: '',
    );
  }

  @override
  List<Object> get props => [
        usersList,
        status,
        searchList,
        selectedList,
        error,
      ];

  UsersState copyWith({
    List<User> usersList,
    List<User> searchList,
    List<User> selectedList,
    UsersStateStatus status,
    String error,
  }) {
    return UsersState(
      usersList: usersList ?? this.usersList,
      searchList: searchList ?? this.searchList,
      selectedList: selectedList ?? this.selectedList,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

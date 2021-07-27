part of 'groups_bloc.dart';

enum GroupsStatus {
  intial,
  loading,
  loaded,
  searching,
  error,
}

class GroupsState extends Equatable {
  final List<Group> groupsList;
  final List<Group> searchList;
  final GroupsStatus status;
  final String error;

  const GroupsState({
    @required this.groupsList,
    @required this.searchList,
    @required this.status,
    @required this.error,
  });

  factory GroupsState.initial() {
    return GroupsState(
      groupsList: [],
      searchList: [],
      status: GroupsStatus.intial,
      error: '',
    );
  }

  @override
  List<Object> get props => [
        groupsList,
        searchList,
        status,
        error,
      ];

  GroupsState copyWith({
    List<Group> groupsList,
    List<Group> searchList,
    GroupsStatus status,
    String error,
  }) {
    return GroupsState(
      groupsList: groupsList ?? this.groupsList,
      searchList: searchList ?? this.searchList,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

part of 'groups_bloc.dart';

abstract class GroupsEvent extends Equatable {
  const GroupsEvent();

  @override
  List<Object> get props => [];
}

class FetchGroups extends GroupsEvent {}

class UpdateGroups extends GroupsEvent {
  final List<Group> groupsList;

  UpdateGroups({@required this.groupsList});

  @override
  List<Object> get props => [groupsList];
}

class SearchGroups extends GroupsEvent {
  final String name;

  SearchGroups({@required this.name});

  @override
  List<Object> get props => [name];
}

class StopSearch extends GroupsEvent {}

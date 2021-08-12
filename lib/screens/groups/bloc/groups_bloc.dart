import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/repositories.dart';

part 'groups_event.dart';
part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  final GroupsRepository _groupsRepository;

  GroupsBloc({@required GroupsRepository groupsRepository})
      : _groupsRepository = groupsRepository,
        super(GroupsState.initial()) {
    add(FetchGroups());
  }

  StreamSubscription<List<Group>> _groupsSubscription;

  @override
  Stream<GroupsState> mapEventToState(
    GroupsEvent event,
  ) async* {
    if (event is FetchGroups) {
      yield* _mapFetchGroupsToState();
    }
    if (event is UpdateGroups) {
      yield* _mapUpdateGroupsToState(event);
    }
    if (event is SearchGroups) {
      yield* _mapSearchGroupsToState(event);
    }
    if (event is StopSearch) {
      yield* _mapStopSearchToState();
    }
  }

  Stream<GroupsState> _mapFetchGroupsToState() async* {
    yield state.copyWith(status: GroupsStatus.loading);
    try {
      _groupsSubscription?.cancel();

      _groupsSubscription =
          _groupsRepository.getGroupsList().listen((groupList) {
        add(UpdateGroups(groupsList: groupList));
      });
    } catch (e) {
      yield (state.copyWith(status: GroupsStatus.error, error: e.message));
    }
  }

  Stream<GroupsState> _mapUpdateGroupsToState(UpdateGroups event) async* {
    yield state.copyWith(
        groupsList: event.groupsList, status: GroupsStatus.loaded);
  }

  Stream<GroupsState> _mapSearchGroupsToState(SearchGroups event) async* {
    List<Group> results = [];

    state.groupsList.forEach((group) {
      if (group.groupName.toLowerCase().contains(event.name.toLowerCase())) {
        results.add(group);
      }
    });

    yield state.copyWith(
      searchList: results,
      status: GroupsStatus.searching,
    );
  }

  Stream<GroupsState> _mapStopSearchToState() async* {
    yield state.copyWith(searchList: [], status: GroupsStatus.loaded);
  }

  @override
  Future<void> close() async {
    _groupsSubscription.cancel();
    super.close();
  }
}

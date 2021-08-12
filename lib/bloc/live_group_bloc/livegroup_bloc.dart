import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:wuphf_chat/models/models.dart';
import 'package:wuphf_chat/repositories/repositories.dart';

part 'livegroup_event.dart';
part 'livegroup_state.dart';

class LiveGroupBloc extends Bloc<LiveGroupEvent, LiveGroupState> {
  final String _groupId;
  final GroupsRepository _groupsRepository;
  StreamSubscription _groupSubscription;

  LiveGroupBloc(
      {@required String groupId, @required GroupsRepository groupsRepository})
      : _groupId = groupId,
        _groupsRepository = groupsRepository,
        super(LiveGroupState.initial()) {
    add(GetGroup());
  }

  @override
  Future<void> close() async {
    _groupSubscription.cancel();
    super.close();
  }

  @override
  Stream<LiveGroupState> mapEventToState(
    LiveGroupEvent event,
  ) async* {
    if (event is GetGroup) {
      yield* _mapGetGroupToState();
    }
    if (event is UpdateGroup) {
      yield* _mapUpdateGroupToState(event);
    }
  }

  Stream<LiveGroupState> _mapGetGroupToState() async* {
    try {
      yield state.copyWith(status: LiveGroupStatus.loading);

      _groupSubscription?.cancel();

      _groupSubscription = _groupsRepository
          .getGroupDetailsStream(groupId: _groupId)
          .listen((group) {
        add(UpdateGroup(group: group));
      });
    } catch (e) {
      yield state.copyWith(status: LiveGroupStatus.error, error: e.message);
    }
  }

  Stream<LiveGroupState> _mapUpdateGroupToState(UpdateGroup event) async* {
    yield state.copyWith(group: event.group, status: LiveGroupStatus.loaded);
  }
}

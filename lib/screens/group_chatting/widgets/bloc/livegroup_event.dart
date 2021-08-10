part of 'livegroup_bloc.dart';

abstract class LiveGroupEvent extends Equatable {
  const LiveGroupEvent();

  @override
  List<Object> get props => [];
}

class GetGroup extends LiveGroupEvent {}

class UpdateGroup extends LiveGroupEvent {
  final Group group;

  UpdateGroup({this.group});

  @override
  List<Object> get props => [group];
}

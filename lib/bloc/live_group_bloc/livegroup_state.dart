part of 'livegroup_bloc.dart';

enum LiveGroupStatus {
  initial,
  loading,
  loaded,
  error,
}

class LiveGroupState extends Equatable {
  final Group group;
  final LiveGroupStatus status;
  final String error;

  LiveGroupState({
    @required this.group,
    @required this.status,
    @required this.error,
  });

  factory LiveGroupState.initial() {
    return LiveGroupState(
      group: null,
      status: LiveGroupStatus.initial,
      error: '',
    );
  }

  @override
  List<Object> get props => [group, status, error];

  LiveGroupState copyWith({
    Group group,
    LiveGroupStatus status,
    String error,
  }) {
    return LiveGroupState(
      group: group ?? this.group,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

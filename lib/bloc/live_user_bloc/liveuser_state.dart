part of 'liveuser_bloc.dart';

enum LiveUserStatus {
  initial,
  loading,
  loaded,
  error,
}

class LiveUserState extends Equatable {
  final User user;
  final LiveUserStatus status;
  final String error;

  LiveUserState({
    @required this.user,
    @required this.status,
    @required this.error,
  });

  factory LiveUserState.initial() {
    return LiveUserState(
      user: null,
      status: LiveUserStatus.initial,
      error: '',
    );
  }

  @override
  List<Object> get props => [user, status, error];

  LiveUserState copyWith({
    User user,
    LiveUserStatus status,
    String error,
  }) {
    return LiveUserState(
      user: user ?? this.user,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

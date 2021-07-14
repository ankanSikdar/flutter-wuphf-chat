part of 'userprofile_bloc.dart';

enum UserProfileStatus {
  intial,
  loading,
  loaded,
  error,
}

class UserProfileState extends Equatable {
  final User user;
  final UserProfileStatus status;
  final String error;

  UserProfileState({
    @required this.user,
    @required this.status,
    @required this.error,
  });

  factory UserProfileState.initial() {
    return UserProfileState(
      user: User.empty,
      status: UserProfileStatus.intial,
      error: '',
    );
  }

  @override
  List<Object> get props => [user, status, error];

  UserProfileState copyWith({
    User user,
    UserProfileStatus status,
    String error,
  }) {
    return UserProfileState(
      user: user ?? this.user,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

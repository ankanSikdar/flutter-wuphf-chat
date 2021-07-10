part of 'signup_cubit.dart';

enum SignUpStatus {
  initial,
  submitting,
  success,
  error,
}

class SignUpState extends Equatable {
  final String email;
  final String displayName;
  final String password;
  final SignUpStatus status;
  final String error;

  const SignUpState({
    @required this.email,
    @required this.displayName,
    @required this.password,
    @required this.status,
    @required this.error,
  });

  factory SignUpState.initial() {
    return SignUpState(
      email: '',
      displayName: '',
      password: '',
      status: SignUpStatus.initial,
      error: '',
    );
  }

  @override
  List<Object> get props => [
        email,
        displayName,
        password,
        status,
        error,
      ];

  SignUpState copyWith({
    String email,
    String displayName,
    String password,
    SignUpStatus status,
    String error,
  }) {
    return SignUpState(
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      password: password ?? this.password,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

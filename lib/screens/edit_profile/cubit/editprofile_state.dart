part of 'editprofile_cubit.dart';

enum EditProfileStatus {
  intial,
  submitting,
  success,
  error,
}

class EditProfileState extends Equatable {
  final String displayName;
  final String email;
  final String bio;
  final File profileImage;
  final EditProfileStatus status;
  final String error;

  const EditProfileState({
    @required this.displayName,
    @required this.email,
    @required this.bio,
    @required this.profileImage,
    @required this.status,
    @required this.error,
  });

  factory EditProfileState.inital() {
    return EditProfileState(
      displayName: '',
      email: '',
      bio: '',
      profileImage: null,
      status: EditProfileStatus.intial,
      error: '',
    );
  }

  @override
  List<Object> get props => [
        displayName,
        email,
        bio,
        profileImage,
        status,
        error,
      ];

  EditProfileState copyWith({
    String displayName,
    String email,
    String bio,
    File profileImage,
    EditProfileStatus status,
    String error,
  }) {
    return EditProfileState(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      profileImage: profileImage ?? this.profileImage,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

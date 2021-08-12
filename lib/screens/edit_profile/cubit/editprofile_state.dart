part of 'editprofile_cubit.dart';

enum EditProfileStatus {
  initial,
  submitting,
  success,
  error,
}

class EditProfileState extends Equatable {
  final String displayName;
  final String email;
  final String bio;
  final String profileImageUrl;
  final File newProfileImage;
  final EditProfileStatus status;
  final String error;

  const EditProfileState({
    @required this.displayName,
    @required this.email,
    @required this.bio,
    @required this.profileImageUrl,
    @required this.newProfileImage,
    @required this.status,
    @required this.error,
  });

  factory EditProfileState.initial() {
    return EditProfileState(
      displayName: '',
      email: '',
      bio: '',
      profileImageUrl: '',
      newProfileImage: null,
      status: EditProfileStatus.initial,
      error: '',
    );
  }

  @override
  List<Object> get props => [
        displayName,
        email,
        bio,
        profileImageUrl,
        newProfileImage,
        status,
        error,
      ];

  EditProfileState copyWith({
    String displayName,
    String email,
    String bio,
    String profileImageUrl,
    File newProfileImage,
    EditProfileStatus status,
    String error,
  }) {
    return EditProfileState(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      newProfileImage: newProfileImage ?? this.newProfileImage,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

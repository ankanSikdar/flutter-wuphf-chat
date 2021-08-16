part of 'appdetails_bloc.dart';

enum AppDetailsStatus {
  initial,
  loading,
  loaded,
  error,
}

class AppDetailsState extends Equatable {
  final String appName;
  final String packageName;
  final String version;
  final String buildNumber;
  final AppDetailsStatus status;
  final String error;

  AppDetailsState({
    @required this.appName,
    @required this.packageName,
    @required this.version,
    @required this.buildNumber,
    @required this.status,
    @required this.error,
  });

  factory AppDetailsState.initial() {
    return AppDetailsState(
      appName: '',
      packageName: '',
      version: '',
      buildNumber: '',
      status: AppDetailsStatus.initial,
      error: '',
    );
  }

  @override
  List<Object> get props => [
        appName,
        packageName,
        version,
        buildNumber,
        status,
        error,
      ];

  AppDetailsState copyWith({
    String appName,
    String packageName,
    String version,
    String buildNumber,
    AppDetailsStatus status,
    String error,
  }) {
    return AppDetailsState(
      appName: appName ?? this.appName,
      packageName: packageName ?? this.packageName,
      version: version ?? this.version,
      buildNumber: buildNumber ?? this.buildNumber,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

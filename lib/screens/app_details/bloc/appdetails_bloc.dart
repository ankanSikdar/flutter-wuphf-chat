import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info/package_info.dart';

part 'appdetails_event.dart';
part 'appdetails_state.dart';

class AppDetailsBloc extends Bloc<AppDetailsEvent, AppDetailsState> {
  PackageInfo _packageInfo;

  AppDetailsBloc() : super(AppDetailsState.initial()) {
    add(LoadAppDetails());
  }

  @override
  Stream<AppDetailsState> mapEventToState(
    AppDetailsEvent event,
  ) async* {
    if (event is LoadAppDetails) {
      yield* _mapLoadAppDetailsToState();
    }
  }

  Stream<AppDetailsState> _mapLoadAppDetailsToState() async* {
    yield state.copyWith(status: AppDetailsStatus.loading);

    try {
      _packageInfo = await PackageInfo.fromPlatform();

      yield state.copyWith(
        status: AppDetailsStatus.loaded,
        appName: _packageInfo.appName,
        packageName: _packageInfo.packageName,
        version: _packageInfo.version,
        buildNumber: _packageInfo.buildNumber,
      );
    } catch (e) {
      yield state.copyWith(status: AppDetailsStatus.error, error: e);
    }
  }
}

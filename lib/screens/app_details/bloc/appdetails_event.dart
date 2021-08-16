part of 'appdetails_bloc.dart';

abstract class AppDetailsEvent extends Equatable {
  const AppDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadAppDetails extends AppDetailsEvent {}

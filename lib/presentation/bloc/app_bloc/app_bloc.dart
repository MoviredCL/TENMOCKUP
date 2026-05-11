import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// State
abstract class AppState extends Equatable {
  const AppState();
  @override
  List<Object> get props => [];
}

class AppInitial extends AppState {}

// Events
abstract class AppEvent extends Equatable {
  const AppEvent();
  @override
  List<Object> get props => [];
}

// Bloc
class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial());
}

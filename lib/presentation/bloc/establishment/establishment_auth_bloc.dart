import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/auth_user.dart';
import '../../../models/api_exception.dart';
import '../../../services/auth_service.dart';

// Events
abstract class EstablishmentAuthEvent extends Equatable {
  const EstablishmentAuthEvent();
  @override
  List<Object?> get props => [];
}

class CheckAuthStatus extends EstablishmentAuthEvent {}

class LoginRequested extends EstablishmentAuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LogoutRequested extends EstablishmentAuthEvent {}

// States
abstract class EstablishmentAuthState extends Equatable {
  const EstablishmentAuthState();
  @override
  List<Object?> get props => [];
}

class EstablishmentAuthInitial extends EstablishmentAuthState {}

class EstablishmentAuthLoading extends EstablishmentAuthState {}

class EstablishmentAuthenticated extends EstablishmentAuthState {
  final AuthUser user;

  const EstablishmentAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class EstablishmentUnauthenticated extends EstablishmentAuthState {
  final String? errorMessage;

  const EstablishmentUnauthenticated({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

// Bloc
class EstablishmentAuthBloc extends Bloc<EstablishmentAuthEvent, EstablishmentAuthState> {
  final AuthService _authService;

  EstablishmentAuthBloc({AuthService? authService})
      : _authService = authService ?? AuthService(),
        super(EstablishmentAuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onCheckAuthStatus(
      CheckAuthStatus event, Emitter<EstablishmentAuthState> emit) async {
    emit(EstablishmentAuthLoading());
    try {
      final user = await _authService.getMe();
      if (user != null) {
        emit(EstablishmentAuthenticated(user));
      } else {
        emit(const EstablishmentUnauthenticated());
      }
    } catch (_) {
      emit(const EstablishmentUnauthenticated());
    }
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<EstablishmentAuthState> emit) async {
    emit(EstablishmentAuthLoading());
    try {
      final response = await _authService.login(event.email, event.password);
      emit(EstablishmentAuthenticated(response.user));
    } on ApiException catch (e) {
      emit(EstablishmentUnauthenticated(errorMessage: e.message));
    } catch (e) {
      emit(EstablishmentUnauthenticated(errorMessage: e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<EstablishmentAuthState> emit) async {
    emit(EstablishmentAuthLoading());
    await _authService.logout();
    emit(const EstablishmentUnauthenticated());
  }
}

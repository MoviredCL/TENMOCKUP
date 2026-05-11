import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState>{

    AppBloc() : super(const AppState()){
        on<CambiarEstadoTneDigital>(_onActivarTneQR);

        on<CambiarViewHome>(_onCambiarHomeView);

        on<SeleccionarSaldo>(_onSeleccionarSaldo);

        on<SetearSaldoActual>(_onSetearSaldoActual);

        on<CrearQr>(_onCrearQR);

        on<MostrarNotificaciones>(_onMostrarNotificaciones);

        on<CambiarMetodoLogin>(_onCambiarMetodoLogin);

        on<EnrolarTarjeta>(_onEnrolarTarjeta);
    }

    Future<void> _onEnrolarTarjeta(EnrolarTarjeta event, Emitter<AppState> emit) async {
        emit(state.copyWith(
            isTarjetaEnrolada: true,
            nombreTarjetaFisica: event.nombre,
            numeroTarjetaFisica: event.numero,
            saldoTarjetaFisica: 1500, // Saldo inicial mockup
        ));
    }

    Future<void> _onCambiarMetodoLogin(CambiarMetodoLogin event, Emitter<AppState> emit) async {
        emit(state.copyWith(loginClaveUnica: event.isClaveUnica));
    }

    Future<void> _onActivarTneQR(CambiarEstadoTneDigital cambiarEstado, Emitter<AppState> emit) async {
        emit(state.copyWith(estadoTneQr: cambiarEstado.estado));
    }

    Future<void> _onCambiarHomeView(CambiarViewHome cambiarView, Emitter<AppState> emit) async {
        emit(state.copyWith(viewHome: cambiarView.view));
    }  

    Future<void> _onSeleccionarSaldo(SeleccionarSaldo seleccionarSaldo, Emitter<AppState> emit) async {
        emit(state.copyWith(seleccionarSaldo: seleccionarSaldo.seleccionarSaldo));
    } 

    Future<void> _onSetearSaldoActual(SetearSaldoActual setearSaldoActual, Emitter<AppState> emit) async {
        emit(state.copyWith(saldoActual: setearSaldoActual.saldo));
    }

    Future<void> _onCrearQR(CrearQr crear, Emitter<AppState> emit) async {
        emit(state.copyWith(crearQR: crear.estado));
    }

    Future<void> _onMostrarNotificaciones(MostrarNotificaciones mostrar, Emitter<AppState> emit) async {
        emit(state.copyWith(mostrarNotificaciones: mostrar.estado));
    }
}


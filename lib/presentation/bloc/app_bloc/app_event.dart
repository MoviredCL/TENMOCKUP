part of 'app_bloc.dart';

class AppEvent extends Equatable{

    const AppEvent();

    @override
    List<Object> get props => [];
}

class CambiarEstadoTneDigital extends AppEvent{

    final bool estado;
    
    const CambiarEstadoTneDigital({required this.estado});
}

class CambiarViewHome extends AppEvent{
    final int view;

    const CambiarViewHome({required this.view});
}

class SeleccionarSaldo extends AppEvent{
    final int seleccionarSaldo;

    const SeleccionarSaldo({required this.seleccionarSaldo});
}

class SetearSaldoActual extends AppEvent{
    final int saldo;

    const SetearSaldoActual({required this.saldo});
}


class CrearQr extends AppEvent{
    final bool estado;

    const CrearQr({required this.estado});
}

class MostrarNotificaciones extends AppEvent{
    final bool estado;

    const MostrarNotificaciones({required this.estado});
}

class CambiarMetodoLogin extends AppEvent {
    final bool isClaveUnica;
    const CambiarMetodoLogin({required this.isClaveUnica});
}

class EnrolarTarjeta extends AppEvent {
    final String nombre;
    final String numero;
    const EnrolarTarjeta({required this.nombre, required this.numero});
}
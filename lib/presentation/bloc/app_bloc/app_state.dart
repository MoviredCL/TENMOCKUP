part of 'app_bloc.dart';

class AppState extends Equatable {

    final bool estadoTneQr;
    final int viewHome;
    final int seleccionarSaldo;
    final int saldoActual;
    final bool crearQR;
    final bool mostrarNotificaciones;
    final bool loginClaveUnica;
    final bool isTarjetaEnrolada;
    final String nombreTarjetaFisica;
    final String numeroTarjetaFisica;
    final int saldoTarjetaFisica;

    const AppState({
        this.estadoTneQr = true,
        this.viewHome = 1,
        this.seleccionarSaldo = 0,
        this.saldoActual = 0,
        this.crearQR = false,
        this.mostrarNotificaciones = false,
        this.loginClaveUnica = false,
        this.isTarjetaEnrolada = false,
        this.nombreTarjetaFisica = "",
        this.numeroTarjetaFisica = "",
        this.saldoTarjetaFisica = 0,
    });

    AppState copyWith({
        bool? estadoTneQr,
        int? viewHome,
        int? seleccionarSaldo,
        int? saldoActual,
        bool? crearQR,
        bool? mostrarNotificaciones,
        bool? loginClaveUnica,
        bool? isTarjetaEnrolada,
        String? nombreTarjetaFisica,
        String? numeroTarjetaFisica,
        int? saldoTarjetaFisica,
    }) => AppState(
        estadoTneQr: estadoTneQr ?? this.estadoTneQr,
        viewHome: viewHome ?? this.viewHome,
        seleccionarSaldo: seleccionarSaldo ?? this.seleccionarSaldo,
        saldoActual: saldoActual ?? this.saldoActual,
        crearQR: crearQR ?? this.crearQR,
        mostrarNotificaciones: mostrarNotificaciones ?? this.mostrarNotificaciones,
        loginClaveUnica: loginClaveUnica ?? this.loginClaveUnica,
        isTarjetaEnrolada: isTarjetaEnrolada ?? this.isTarjetaEnrolada,
        nombreTarjetaFisica: nombreTarjetaFisica ?? this.nombreTarjetaFisica,
        numeroTarjetaFisica: numeroTarjetaFisica ?? this.numeroTarjetaFisica,
        saldoTarjetaFisica: saldoTarjetaFisica ?? this.saldoTarjetaFisica,
    );

    @override 
    List<Object> get props => [
        estadoTneQr, 
        viewHome, 
        seleccionarSaldo, 
        saldoActual, 
        crearQR, 
        mostrarNotificaciones, 
        loginClaveUnica,
        isTarjetaEnrolada,
        nombreTarjetaFisica,
        numeroTarjetaFisica,
        saldoTarjetaFisica,
    ];

    @override
    String toString() {
        return  "";
    }
}
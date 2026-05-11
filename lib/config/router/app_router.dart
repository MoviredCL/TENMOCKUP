import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tneapp/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:tneapp/presentation/screen/screen.dart';
import 'package:go_router/go_router.dart';
import 'package:tneapp/presentation/views/views.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:tneapp/config/constants/colores.dart';


final appRouter = GoRouter(
	initialLocation: '/',
	routes: [
        ShellRoute(
            builder: (context, state, child){
                return BlocConsumer<AppBloc, AppState>(
                    listener: (ctx, stat) {
                    },
                    builder: (ctx, stat) {
                        bool activo = stat.loginClaveUnica && stat.estadoTneQr && stat.saldoActual > 0;
                        return Scaffold(
                            body: BodyCustom(child: child),
                            bottomNavigationBar: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.05),
                                            blurRadius: 20,
                                            offset: const Offset(0, -5),
                                        ),
                                    ],
                                ),
                                child: SafeArea(
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                                _buildNavItem(
                                                    context: context,
                                                    index: 0,
                                                    currentIndex: _calculateIndex(state.uri.toString(), stat),
                                                    icon: Icons.home_outlined,
                                                    activeIcon: Icons.home_rounded,
                                                    label: "Inicio",
                                                    onTap: () {
                                                        context.read<AppBloc>().add(const CambiarViewHome(view: 1));
                                                        context.go("/home");
                                                    },
                                                ),
                                                _buildNavItem(
                                                    context: context,
                                                    index: 1,
                                                    currentIndex: _calculateIndex(state.uri.toString(), stat),
                                                    icon: Icons.account_balance_wallet_outlined,
                                                    activeIcon: Icons.account_balance_wallet,
                                                    label: "Carga",
                                                    onTap: () {
                                                        context.read<AppBloc>().add(const CambiarViewHome(view: 3));
                                                        context.go("/home");
                                                    },
                                                ),
                                                _buildQRItem(
                                                    context: context,
                                                    activo: activo,
                                                    onTap: () async {
                                                        if(activo){
                                                            final LocalAuthentication auth = LocalAuthentication();
                                                            final appBloc = context.read<AppBloc>();
                                                            final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
                                                            final bool canAuthenticate = canAuthenticateWithBiometrics || await auth.isDeviceSupported();
                                                            
                                                            if(canAuthenticate){
                                                                try {
                                                                    final bool didAuthenticate = await auth.authenticate(
                                                                        authMessages: const <AuthMessages>[
                                                                            AndroidAuthMessages(
                                                                                signInTitle: "Autenticación requerida",
                                                                                cancelButton: "Cancelar",
                                                                                biometricHint: ""
                                                                            )
                                                                        ],
                                                                        localizedReason: 'Confirma que eres tú para crear pasaje QR', 
                                                                        options: const AuthenticationOptions(biometricOnly: false)
                                                                    );
                                                                    if(didAuthenticate){
                                                                        appBloc.add(CrearQr(estado: true));
                                                                    }
                                                                } catch(e) {
                                                                    debugPrint(e.toString());
                                                                }
                                                            }
                                                        } else {
                                                            // Feedback if inactive
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                SnackBar(
                                                                    content: Text(!stat.loginClaveUnica 
                                                                        ? "El pasaje digital requiere validación por ClaveÚnica."
                                                                        : "Debes tener saldo y tu TNE activa para generar un pasaje."),
                                                                    backgroundColor: Color(primaryColor),
                                                                    behavior: SnackBarBehavior.floating,
                                                                    duration: const Duration(seconds: 2),
                                                                ),
                                                            );
                                                        }
                                                    },
                                                ),
                                                _buildNavItem(
                                                    context: context,
                                                    index: 3,
                                                    currentIndex: _calculateIndex(state.uri.toString(), stat),
                                                    icon: Icons.history_rounded,
                                                    activeIcon: Icons.history_rounded,
                                                    label: "Historial",
                                                    onTap: () => context.go("/historial_viajes"),
                                                ),
                                                _buildNavItem(
                                                    context: context,
                                                    index: 4,
                                                    currentIndex: _calculateIndex(state.uri.toString(), stat),
                                                    icon: Icons.person_outline_rounded,
                                                    activeIcon: Icons.person_rounded,
                                                    label: "Perfil",
                                                    onTap: () => context.go("/perfil"),
                                                ),
                                            ],
                                        ),
                                    ),
                                ),
                            ),
                        );
                    },
                );
            },
            routes: [
                GoRoute(
                    path: '/home',
                    builder: (context, state) => HomeScreen()
                ),
                GoRoute(
                    path: '/historial_viajes',
                    builder: (context, state) => const HistorialViajesScreen()
                ),
                GoRoute(
                    path: '/perfil',
                    builder: (context, state) => const ProfileScreen()
                ),
                GoRoute(
                    path: '/enrolar',
                    builder: (context, state) => const EnrolarTarjetaScreen()
                )
            ]
        ),
		GoRoute(
			path: '/',
			builder: (context, state) => const LoginScreen()
		),
        GoRoute(
            path: '/clave_unica',
            builder: (context, state) => const ClaveUnicaScreen()
        ),
        GoRoute(
            path: '/crear_cuenta',
            builder: (context, state) => const CrearCuentaScreen()
        ),
        GoRoute(
            path: '/iniciar_sesion',
            builder: (context, state) => const IniciarSesionScreen()
        )
	]
);



Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required int currentIndex,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required VoidCallback onTap,
}) {
    final bool isSelected = index == currentIndex;
    final Color color = isSelected ? Color(primaryColor) : Colors.grey.withOpacity(0.5);

    return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                    Icon(isSelected ? activeIcon : icon, color: color, size: 26),
                    const SizedBox(height: 4),
                    Text(
                        label,
                        style: TextStyle(
                            color: color,
                            fontSize: 11,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        ),
                    ),
                ],
            ),
        ),
    );
}

Widget _buildQRItem({required BuildContext context, required bool activo, required VoidCallback onTap}) {
    return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                Container(
                    transform: Matrix4.translationValues(0, -10, 0),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: activo ? Color(primaryColor) : Colors.grey.shade300,
                        shape: BoxShape.circle,
                        boxShadow: [
                            BoxShadow(
                                color: (activo ? Color(primaryColor) : Colors.grey).withOpacity(0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                            ),
                        ],
                    ),
                    child: const Icon(
                        Icons.qr_code_scanner_rounded,
                        color: Colors.white,
                        size: 32,
                    ),
                ),
            ],
        ),
    );
}

int _calculateIndex(String location, AppState state) {
    if (location.startsWith('/home')) {
        if (state.viewHome == 3) return 1;
        return 0;
    }
    if (location.startsWith('/historial_viajes')) return 3;
    if (location.startsWith('/perfil')) return 4;
    return 0;
}
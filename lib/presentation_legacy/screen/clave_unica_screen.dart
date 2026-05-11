import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tneapp/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:tneapp/presentation/views/views.dart';
import 'package:tneapp/config/constants/colores.dart';

class ClaveUnicaScreen extends StatefulWidget {
  const ClaveUnicaScreen({super.key});

  @override
  State<ClaveUnicaScreen> createState() => _ClaveUnicaScreenState();
}

class _ClaveUnicaScreenState extends State<ClaveUnicaScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(primaryColor),
      appBar: AppBarCustom(),
      body: BodyCustom(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: !loading
              ? _buildLandingView()
              : _buildLoadingView(),
        ),
      ),
    );
  }

  Widget _buildLandingView() {
    return SingleChildScrollView(
      key: const ValueKey(1),
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            "Validación Identidad",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              fontFamily: 'Outfit',
              color: Color(neutralTextColor),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Accede de forma segura con tu ClaveÚnica para continuar.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 48),
          GestureDetector(
            onTap: () {
              setState(() => loading = true);
              Future.delayed(const Duration(seconds: 2), () {
                if (mounted) {
                  context.read<AppBloc>().add(const CambiarMetodoLogin(isClaveUnica: true));
                  context.go("/home");
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
                ],
              ),
              child: Image.asset("assets/images/imagen_clave_unica.png"),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            "Toca la imagen para simular el ingreso",
            style: TextStyle(fontSize: 12, color: Colors.grey.shade400, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingView() {
    return SizedBox(
      key: const ValueKey(2),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              strokeWidth: 6,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6929C4)),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            "Validando con ClaveÚnica",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(neutralTextColor)),
          ),
          const SizedBox(height: 8),
          Text(
            "Estamos confirmando tu identidad...",
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
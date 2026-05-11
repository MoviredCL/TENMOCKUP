import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tneapp/config/constants/colores.dart';
import 'package:tneapp/presentation/views/views.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tneapp/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:tneapp/presentation/widgets/boton_clave_unica.dart';
import 'package:tneapp/presentation/widgets/primary_custom_button.dart';

class IniciarSesionScreen extends StatelessWidget {
  const IniciarSesionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(primaryColor),
      appBar: AppBarCustom(),
      body: BodyCustom(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Inicia sesión",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Outfit',
                  color: Color(neutralTextColor),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Ingresa tus datos para continuar",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(neutralTextColor).withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 40),
              
              _buildTextField(
                label: "Email",
                hint: "emma@correo.cl",
                icon: Icons.alternate_email_rounded,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: "Contraseña",
                hint: "••••••••",
                icon: Icons.lock_outline_rounded,
                isPassword: true,
              ),
              
              const SizedBox(height: 48),
              
              PrimaryCustomButton(
                label: "Ingresar",
                onPressed: () {
                  context.read<AppBloc>().add(const CambiarMetodoLogin(isClaveUnica: false));
                  context.go("/home");
                },
                size: double.infinity,
              ),
              const SizedBox(height: 16),
              BotonClaveUnica(
                label: "Ingresar con ClaveÚnica",
                onPressed: () => context.push("/clave_unica"),
                size: double.infinity,
                rounded: true,
              ),
              
              const SizedBox(height: 60),
              Center(
                child: SizedBox(
                  width: 180,
                  child: Image.asset("assets/images/branding2.png", fit: BoxFit.contain),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            prefixIcon: Icon(icon, color: Color(primaryColor).withOpacity(0.5)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Color(primaryColor), width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

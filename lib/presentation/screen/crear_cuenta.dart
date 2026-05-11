import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tneapp/config/constants/colores.dart';
import 'package:tneapp/presentation/views/views.dart';
import 'package:tneapp/presentation/widgets/primary_custom_button.dart';

class CrearCuentaScreen extends StatelessWidget {
  const CrearCuentaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(primaryColor),
      appBar: AppBarCustom(),
      body: BodyCustom(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(Icons.arrow_back_ios_new_rounded, color: Color(neutralTextColor)),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 24),
              Text(
                "Crea tu cuenta",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Outfit',
                  color: Color(neutralTextColor),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Únete a la nueva era digital del transporte escolar",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(neutralTextColor).withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 32),
              
              _buildTextField(
                label: "Nombre completo",
                hint: "Emma Francisca Ibacache Espinoza",
                icon: Icons.person_outline_rounded,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: "RUT",
                hint: "12.345.678-9",
                icon: Icons.badge_outlined,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: "Email",
                hint: "emma@correo.cl",
                icon: Icons.alternate_email_rounded,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: "Celular",
                hint: "+56 9 8765 4321",
                icon: Icons.phone_android_rounded,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: "Comuna",
                hint: "Concepción",
                icon: Icons.location_on_outlined,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: "Contraseña",
                hint: "••••••••",
                icon: Icons.lock_outline_rounded,
                isPassword: true,
                helperText: "Mayúscula + número + símbolo",
              ),
              
              const SizedBox(height: 40),
              
              PrimaryCustomButton(
                label: "Crear mi cuenta",
                onPressed: () => context.go("/"),
                size: double.infinity,
              ),
              
              const SizedBox(height: 40),
              Center(
                child: SizedBox(
                  width: 180,
                  child: Image.asset("assets/images/branding2.png", fit: BoxFit.contain),
                ),
              ),
              const SizedBox(height: 20),
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
    String? helperText,
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
            helperText: helperText,
            helperStyle: TextStyle(fontSize: 11, color: Colors.grey.shade500),
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
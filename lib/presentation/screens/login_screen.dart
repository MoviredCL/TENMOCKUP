import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tneapp/config/constants/colores.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60),
              // Top Icon
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryBlue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.badge_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Branding
              Center(
                child: Image.asset(
                  'assets/images/logo-junaeb.webp',
                  height: 48,
                ),
              ),
              const SizedBox(height: 48),
              // Main Title
              const Text(
                'Selecciona tu Perfil',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textMain,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Indica cómo deseas ingresar para gestionar la Tarjeta Nacional Estudiantil.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 48),
              
              // Role Buttons
              ElevatedButton.icon(
                onPressed: () => context.push('/login-student'),
                icon: const Icon(Icons.school),
                label: const Text('Ingreso estudiante'),
              ),
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: () => context.push('/login-establishment'),
                icon: const Icon(Icons.business),
                label: const Text('Ingreso Establecimiento'),
              ),
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: () => context.push('/login-parent'),
                icon: const Icon(Icons.family_restroom),
                label: const Text('Ingreso Padres/Apoderados'),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

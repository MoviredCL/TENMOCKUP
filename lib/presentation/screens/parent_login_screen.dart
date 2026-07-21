import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tneapp/config/constants/colores.dart';

class ParentLoginScreen extends StatelessWidget {
  const ParentLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/login');
                    }
                  },
                  icon: const Icon(Icons.arrow_back, color: AppColors.primaryBlue),
                  label: const Text(
                    'Volver',
                    style: TextStyle(color: AppColors.primaryBlue, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Image.asset(
                  'assets/images/logo-junaeb.webp',
                  height: 48,
                ),
              ),
              const SizedBox(height: 48),
              const Text(
                'Acceso Padres y Apoderados',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textMain,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Ingresa tus datos para gestionar la TNE de tus pupilos.',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'RUT Apoderado',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.family_restroom_outlined, color: AppColors.textTertiary),
                  hintText: '12.345.678-9',
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Contraseña',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 8),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline, color: AppColors.textTertiary),
                  hintText: '••••••••',
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => context.go('/parent-home'),
                child: const Text('Ingresar'),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

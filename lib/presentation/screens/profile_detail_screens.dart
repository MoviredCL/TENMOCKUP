import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tneapp/config/constants/colores.dart';

class PersonalDataScreen extends StatelessWidget {
  const PersonalDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos Personales'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: const AssetImage('assets/images/user_profile.png'),
                    backgroundColor: AppColors.background,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.primaryBlue,
                      child: Icon(Icons.camera_alt, size: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildInfoField('Nombre Completo', 'Camila Fuentes Díaz'),
            _buildInfoField('RUT', '33333333-3'),
            _buildInfoField('Fecha de Nacimiento', '25 de Enero, 2013'),
            _buildInfoField('Correo Electrónico', 'camila.fuentes@correo.cl'),
            _buildInfoField('Teléfono', '+56 9 8765 4321'),
            _buildInfoField('Dirección', 'Av. Libertador Bernardo O\'Higgins 1315, Santiago'),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('GUARDAR CAMBIOS', style: TextStyle(fontWeight: FontWeight.w900)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textTertiary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: value,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
            ),
          ),
        ],
      ),
    );
  }
}

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seguridad'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSecurityOption(
            icon: Icons.fingerprint,
            title: 'Biometría',
            subtitle: 'Usa FaceID o Huella para entrar',
            value: true,
          ),
          const Divider(height: 32),
          _buildSecurityOption(
            icon: Icons.notifications_active_outlined,
            title: 'Alertas de Inicio',
            subtitle: 'Notificar cada vez que se inicie sesión',
            value: true,
          ),
          const Divider(height: 32),
          _buildSecurityOption(
            icon: Icons.devices_other,
            title: 'Dispositivos Vinculados',
            subtitle: 'Gestiona donde has iniciado sesión',
            onTap: () {},
          ),
          const Divider(height: 32),
          _buildSecurityOption(
            icon: Icons.password_rounded,
            title: 'Cambiar Contraseña',
            subtitle: 'Actualiza tu clave de acceso',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityOption({required IconData icon, required String title, required String subtitle, bool? value, VoidCallback? onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: AppColors.primaryBlue),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      subtitle: Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
      trailing: value != null 
        ? Switch(value: value, onChanged: (v) {}, activeColor: AppColors.primaryBlue)
        : const Icon(Icons.chevron_right, color: AppColors.textTertiary),
      onTap: onTap,
    );
  }
}

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String pin = "";

  void _onKeyTap(String key) {
    if (pin.length < 4) {
      setState(() => pin += key);
    }
  }

  void _onDelete() {
    if (pin.isNotEmpty) {
      setState(() => pin = pin.substring(0, pin.length - 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PIN de Seguridad'),
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 60),
          const Icon(Icons.lock_outline, size: 64, color: AppColors.primaryBlue),
          const SizedBox(height: 24),
          const Text('Ingresa tu PIN actual', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const Text('Este PIN es necesario para autorizar transacciones', style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: index < pin.length ? AppColors.primaryBlue : AppColors.border,
                shape: BoxShape.circle,
              ),
            )),
          ),
          const Spacer(),
          _buildNumpad(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildNumpad() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          for (var row in [['1', '2', '3'], ['4', '5', '6'], ['7', '8', '9']])
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: row.map((key) => _buildKey(key)).toList(),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 80),
              _buildKey('0'),
              _buildKey('DEL', isAction: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKey(String label, {bool isAction = false}) {
    return InkWell(
      onTap: label == 'DEL' ? _onDelete : () => _onKeyTap(label),
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 80,
        height: 80,
        alignment: Alignment.center,
        child: label == 'DEL' 
          ? const Icon(Icons.backspace_outlined, color: AppColors.textMain)
          : Text(label, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textMain)),
      ),
    );
  }
}

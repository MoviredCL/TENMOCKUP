import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tneapp/config/constants/colores.dart';
import 'package:tneapp/presentation/views/appbar_custom.dart';
import 'package:tneapp/presentation/views/body_custom.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(primaryColor),
      appBar: AppBarCustom(),
      body: BodyCustom(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Header
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Color(primaryColor).withOpacity(0.1), width: 2),
                          ),
                          child: CircleAvatar(
                            radius: 54,
                            backgroundColor: Color(primaryLightColor).withOpacity(0.5),
                            child: Icon(Icons.person_rounded, size: 60, color: Color(primaryColor)),
                          ),
                        ),
                        Positioned(
                          bottom: 4,
                          right: 4,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Color(secondaryColor),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(Icons.edit_rounded, size: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Emma Ibacache",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Outfit',
                        color: Color(neutralTextColor),
                      ),
                    ),
                    Text(
                      "emma@correo.cl",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(neutralTextColor).withOpacity(0.5),
                      ),
                    ),
                    Text(
                      "1ER AÑO MEDIO",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(neutralTextColor).withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),

              _buildSectionTitle("Cuenta y Seguridad"),
              _buildSettingsGroup([
                _buildSettingsTile(
                  icon: Icons.person_outline,
                  label: "Mi perfil",
                  onTap: () => _navigateToDetail(context, "Mi Perfil", _buildProfileDetail()),
                ),
                _buildSettingsTile(
                  icon: Icons.security_outlined,
                  label: "Seguridad",
                  onTap: () => _navigateToDetail(context, "Seguridad", _buildSecurityDetail()),
                ),
              ]),

              const SizedBox(height: 32),
              _buildSectionTitle("Información Académica y TNE"),
              _buildSettingsGroup([
                _buildInfoTile(icon: Icons.school_outlined, label: "Colegio", value: "Colegio Saint"),
                _buildInfoTile(icon: Icons.calendar_today_rounded, label: "Año cursado", value: "2026 - 1ero Medio"),
                _buildInfoTile(icon: Icons.verified_user_outlined, label: "Estado TNE", value: "Activa", isStatus: true),
              ]),

              const SizedBox(height: 32),
              _buildSectionTitle("Preferencias"),
              _buildSettingsGroup([
                _buildSettingsTile(
                  icon: Icons.settings_outlined,
                  label: "Configuración",
                  onTap: () => _navigateToDetail(context, "Configuración", _buildSettingsDetail()),
                ),
                _buildSettingsTile(
                  icon: Icons.notifications_none_outlined,
                  label: "Notificaciones",
                  onTap: () => _navigateToDetail(context, "Notificaciones", _buildNotificationsDetail()),
                ),
              ]),

              const SizedBox(height: 32),
              _buildSectionTitle("Soporte"),
              _buildSettingsGroup([
                _buildSettingsTile(
                  icon: Icons.help_outline,
                  label: "Ayuda y soporte",
                  onTap: () => _launchUrl("https://movired.cl/ayuda"),
                ),
                _buildSettingsTile(
                  icon: Icons.description_outlined,
                  label: "Legales",
                  onTap: () => _navigateToDetail(context, "Términos y Condiciones", _buildLegalsDetail()),
                ),
              ]),

              const SizedBox(height: 48),

              // Action Buttons
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  side: BorderSide(color: Color(primaryColor).withOpacity(0.5)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  foregroundColor: Color(primaryColor),
                ),
                onPressed: () => _showLogoutDialog(context),
                child: const Text("Cerrar sesión", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () => _showDeleteAccountDialog(context),
                  child: Text(
                    "Eliminar mi cuenta",
                    style: TextStyle(color: Color(redColor).withOpacity(0.7), fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, String title, Widget content) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Color(primaryColor),
          body: Column(
            children: [
              // Custom Header with Logo and Back Button
              Container(
                height: 140,
                color: Color(primaryColor),
                child: SafeArea(
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/appbar.png",
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: BodyCustom(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Outfit',
                            color: Color(neutralTextColor),
                          ),
                        ),
                        const SizedBox(height: 24),
                        content,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Sub-View Builders ---

  Widget _buildProfileDetail() {
    return Column(
      children: [
        _buildInputGroup("Nombre Completo", "Emma Ibacache"),
        const SizedBox(height: 20),
        _buildInputGroup("Correo Electrónico", "emma@correo.cl"),
        const SizedBox(height: 20),
        _buildInputGroup("Teléfono de contacto", "+56 9 1234 5678"),
        const SizedBox(height: 40),
        FilledButton(
          onPressed: () {},
          style: FilledButton.styleFrom(
            backgroundColor: Color(primaryColor),
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Text("Guardar cambios", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        ),
      ],
    );
  }

  Widget _buildSecurityDetail() {
    return Column(
      children: [
        _buildSettingsGroup([
          _buildSettingsTile(icon: Icons.alternate_email_rounded, label: "Cambiar Correo"),
          _buildSettingsTile(icon: Icons.emergency_share_rounded, label: "Contactos de Emergencia"),
          _buildSettingsTile(icon: Icons.lock_outline_rounded, label: "PIN de Seguridad"),
        ]),
        const SizedBox(height: 24),
        const Text(
          "El PIN de seguridad se solicitará cada vez que generes un pasaje QR.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildSettingsDetail() {
    return Column(
      children: [
        _buildSettingsGroup([
          SwitchListTile(
            secondary: Icon(Icons.dark_mode_outlined, color: Color(primaryColor)),
            title: const Text("Modo Oscuro", style: TextStyle(fontWeight: FontWeight.w600)),
            value: false,
            onChanged: (v) {},
            activeThumbColor: Color(primaryColor),
          ),
          _buildSettingsTile(icon: Icons.vpn_key_outlined, label: "Permisos de la App"),
        ]),
      ],
    );
  }

  Widget _buildNotificationsDetail() {
    return Column(
      children: [
        _buildSettingsGroup([
          SwitchListTile(
            secondary: Icon(Icons.notifications_active_outlined, color: Color(primaryColor)),
            title: const Text("Notificaciones Push", style: TextStyle(fontWeight: FontWeight.w600)),
            subtitle: const Text("Avisos de carga y saldo bajo"),
            value: true,
            onChanged: (v) {},
            activeThumbColor: Color(primaryColor),
          ),
          SwitchListTile(
            secondary: Icon(Icons.email_outlined, color: Color(primaryColor)),
            title: const Text("Alertas por Correo", style: TextStyle(fontWeight: FontWeight.w600)),
            value: false,
            onChanged: (v) {},
            activeThumbColor: Color(primaryColor),
          ),
        ]),
      ],
    );
  }

  Widget _buildLegalsDetail() {
    return Text(
      "Al utilizar la aplicación TNE Digital, aceptas que tus datos académicos sean consultados para validar tu condición de estudiante regular. \n\n"
      "1. Uso del Pasaje: El pasaje QR es personal e intransferible. \n"
      "2. Privacidad: Protegemos tus datos bajo la ley 19.628 de protección de la vida privada. \n"
      "3. Recargas: Las recargas digitales pueden tardar hasta 15 minutos en verse reflejadas en el saldo offline de la tarjeta física, pero son inmediatas para la TNE Digital.",
      style: TextStyle(fontSize: 15, height: 1.6, color: Color(neutralTextColor)),
    );
  }

  Widget _buildInputGroup(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey)),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: value),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.all(20),
          ),
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    // Aquí iría la lógica de url_launcher
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: Color(neutralTextColor).withOpacity(0.4),
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingsTile({required IconData icon, required String label, VoidCallback? onTap}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(primaryColor).withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Color(primaryColor), size: 20),
      ),
      title: Text(
        label,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(neutralTextColor)),
      ),
      trailing: Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400, size: 20),
      onTap: onTap ?? () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
    bool isStatus = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(primaryColor).withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Color(primaryColor), size: 20),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(neutralTextColor).withOpacity(0.5)),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: isStatus ? Colors.green.shade600 : Color(neutralTextColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text("¿Cerrar sesión?", style: TextStyle(fontWeight: FontWeight.w800)),
        content: const Text("Deberás ingresar tus credenciales nuevamente la próxima vez."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/');
            },
            child: Text("Cerrar Sesión", style: TextStyle(color: Color(redColor), fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text("Eliminar cuenta", style: TextStyle(color: Color(redColor), fontWeight: FontWeight.w800)),
        content: const Text("Esta acción es irreversible. Perderás tu saldo y acceso digital."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Color(redColor),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Navigator.pop(context);
              context.go('/');
            },
            child: const Text("Eliminar", style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

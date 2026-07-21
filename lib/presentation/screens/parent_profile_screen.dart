import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tneapp/config/constants/colores.dart';

class ParentProfileScreen extends StatelessWidget {
  const ParentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/parent-home');
              }
            },
          ),
          title: const Text('Mi Perfil (Apoderado)'),
          elevation: 0,
          bottom: TabBar(
            indicatorColor: AppColors.primaryBlue,
            indicatorWeight: 3,
            labelColor: AppColors.primaryBlue,
            unselectedLabelColor: AppColors.textTertiary,
            labelStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 0.5),
            tabs: [
              const Tab(text: "MI INFORMACIÓN", icon: Icon(Icons.person_outline, size: 20)),
              Tab(
                text: "NOTIFICACIONES", 
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.notifications_none_rounded, size: 20),
                    Positioned(
                      right: -8,
                      top: -2,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(color: AppColors.secondaryRed, shape: BoxShape.circle),
                        child: const Text('1', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: Mi Información
            _buildInfoTab(context),
            
            // Tab 2: Notificaciones
            _buildNotificationsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTab(BuildContext context) {
    return SingleChildScrollView(
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
                        border: Border.all(
                          color: AppColors.primaryBlue.withOpacity(0.1),
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 54,
                        backgroundColor: Colors.grey[200],
                        child: const Icon(Icons.person, size: 50, color: AppColors.primaryBlue),
                      ),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryRed,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.edit_rounded,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Margarita Alfaro",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textMain,
                  ),
                ),
                const Text(
                  "margarita.alfaro@correo.cl",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          _buildSectionTitle("Cuenta y Seguridad"),
          _buildSettingsGroup([
            _buildSettingsTile(
              icon: Icons.person_outline,
              label: "Mis Datos Personales",
              onTap: () {},
            ),
            _buildSettingsTile(
              icon: Icons.lock_outline,
              label: "PIN de Seguridad",
              onTap: () {},
            ),
          ]),

          const SizedBox(height: 24),
          _buildSectionTitle("Mis Pupilos"),
          _buildSettingsGroup([
            _buildInfoTile(
              icon: Icons.face,
              label: "Camila Espinoza",
              value: "Liceo Bicentenario de Excelencia",
            ),
            _buildInfoTile(
              icon: Icons.face,
              label: "Javier Espinoza",
              value: "Escuela Básica Municipal",
            ),
          ]),

          const SizedBox(height: 24),
          _buildSectionTitle("Programas JUNAEB"),
          _buildSettingsGroup([
            _buildSettingsTile(
              icon: Icons.card_giftcard_outlined,
              label: "Beneficios Estudiantiles",
              onTap: () => context.push('/applications'),
            ),
            _buildSettingsTile(
              icon: Icons.handshake_outlined,
              label: "Convenios JUNAEB",
              onTap: () {},
            ),
          ]),

          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => _showLogoutDialog(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.secondaryRed,
              side: const BorderSide(color: AppColors.secondaryRed),
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text("Cerrar sesión", style: TextStyle(fontWeight: FontWeight.w900)),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildNotificationsTab() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildNotificationItem(
          title: "Recarga TNE Exitosa",
          message: "Se ha recargado exitosamente el monto de \$2.000 en la TNE de Camila.",
          time: "Hace 1 hora",
          icon: Icons.payment,
          color: Colors.blue[50]!,
          iconColor: Colors.blue[800]!,
          isNew: true,
        ),
        _buildNotificationItem(
          title: "Postulación Abierta",
          message: "Se ha abierto el proceso de renovación para la Beca BAES de Javier.",
          time: "Ayer, 12:30",
          icon: Icons.school_outlined,
          color: Colors.green[50]!,
          iconColor: Colors.green[800]!,
          isNew: false,
        ),
        _buildNotificationItem(
          title: "Reunión de Apoderados",
          message: "Recordatorio: Mañana a las 18:30 hrs es la reunión en el Liceo Bicentenario.",
          time: "20 de Mayo",
          icon: Icons.calendar_today,
          color: Colors.purple[50]!,
          iconColor: Colors.purple[800]!,
          isNew: false,
        ),
      ],
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String message,
    required String time,
    required IconData icon,
    required Color color,
    required Color iconColor,
    bool isNew = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isNew ? AppColors.primaryBlue.withOpacity(0.3) : AppColors.border, width: isNew ? 1.5 : 1),
        boxShadow: isNew ? [BoxShadow(color: AppColors.primaryBlue.withOpacity(0.05), blurRadius: 10)] : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: AppColors.textMain)),
                        if (isNew)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(color: AppColors.secondaryRed, shape: BoxShape.circle),
                          ),
                      ],
                    ),
                    Text(time, style: const TextStyle(fontSize: 11, color: AppColors.textTertiary)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(message, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w900,
          color: AppColors.textTertiary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryBlue.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primaryBlue, size: 20),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppColors.textMain,
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary, size: 20),
      onTap: onTap,
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primaryBlue, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textTertiary, fontWeight: FontWeight.bold)),
                Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: AppColors.textMain)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("¿Cerrar sesión?", style: TextStyle(fontWeight: FontWeight.w900)),
        content: const Text("Deberás ingresar tus credenciales nuevamente la próxima vez."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar", style: TextStyle(color: AppColors.textTertiary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/login');
            },
            child: const Text("Cerrar Sesión", style: TextStyle(color: AppColors.secondaryRed, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

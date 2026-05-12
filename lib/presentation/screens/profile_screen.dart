import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tneapp/config/constants/colores.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          title: const Text('Mi Perfil'),
          elevation: 0,
          bottom: TabBar(
            indicatorColor: AppColors.primaryBlue,
            indicatorWeight: 3,
            labelColor: AppColors.primaryBlue,
            unselectedLabelColor: AppColors.textTertiary,
            labelStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 0.5),
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
                        child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
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
                          backgroundImage: const AssetImage('assets/images/user_profile.png'),
                          backgroundColor: AppColors.background,
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
                  "Camila Andrea Espinoza Alfaro",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textMain,
                  ),
                ),
                const Text(
                  "camila.espinoza@correo.cl",
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
              onTap: () => context.push('/profile/personal-data'),
            ),
            _buildSettingsTile(
              icon: Icons.security_outlined,
              label: "Seguridad",
              onTap: () => context.push('/profile/security'),
            ),
            _buildSettingsTile(
              icon: Icons.lock_outline,
              label: "PIN de Seguridad",
              onTap: () => context.push('/profile/pin'),
            ),
          ]),

          const SizedBox(height: 24),
          _buildSectionTitle("Información Académica"),
          _buildSettingsGroup([
            _buildInfoTile(
              icon: Icons.school_outlined,
              label: "Establecimiento",
              value: "Liceo Bicentenario de Excelencia",
            ),
            _buildInfoTile(
              icon: Icons.verified_user_outlined,
              label: "Estado TNE",
              value: "Vigente",
              isStatus: true,
            ),
          ]),

          const SizedBox(height: 24),
          _buildSectionTitle("Programas JUNAEB"),
          _buildSettingsGroup([
            _buildSettingsTile(
              icon: Icons.card_giftcard_outlined,
              label: "Beneficios JUNAEB",
              onTap: () => context.push('/benefits'),
            ),
            _buildSettingsTile(
              icon: Icons.handshake_outlined,
              label: "Convenios JUNAEB",
              onTap: () => _showConveniosModal(context),
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
          title: "Carga BAES Disponible",
          message: "Tu saldo de \$48.000 para el mes de Mayo ya ha sido depositado en tu cuenta.",
          time: "Hace 2 horas",
          icon: Icons.restaurant,
          color: Colors.orange[50]!,
          iconColor: Colors.orange[800]!,
          isNew: true,
        ),
        _buildNotificationItem(
          title: "Beca Aprobada",
          message: "¡Felicitaciones! Tu postulación a la Beca de Integración Territorial ha sido aceptada.",
          time: "Ayer, 10:45",
          icon: Icons.check_circle_outline,
          color: Colors.green[50]!,
          iconColor: Colors.green[800]!,
          isNew: true,
        ),
        _buildNotificationItem(
          title: "Recordatorio TNE",
          message: "Recuerda que tienes hasta el 31 de mayo para revalidar tu tarjeta física en los puntos habilitados.",
          time: "10 de Mayo",
          icon: Icons.timer_outlined,
          color: Colors.blue[50]!,
          iconColor: Colors.blue[800]!,
          isNew: true,
        ),
        _buildNotificationItem(
          title: "Nuevo Convenio",
          message: "Ahora puedes usar tu BAES en todas las sucursales de 'Foodie Express'. Revisa el mapa de comercios.",
          time: "8 de Mayo",
          icon: Icons.storefront,
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
    bool isStatus = false,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textTertiary, fontWeight: FontWeight.bold)),
              Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: isStatus ? Colors.green[700] : AppColors.textMain)),
            ],
          ),
        ],
      ),
    );
  }

  void _showConveniosModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 24),
            const Text("Convenios y Ofertas", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.textMain)),
            const Text("Descuentos exclusivos para estudiantes", style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  _buildConvenioCard(
                    title: "Cine Hoyts / Cinemark",
                    category: "CINE",
                    imagePath: "assets/images/cinema_banner.png",
                    description: "2x1 en entradas y combos seleccionados",
                  ),
                  _buildConvenioCard(
                    title: "Librerías Nacional",
                    category: "CULTURA",
                    imagePath: "assets/images/library_banner.png",
                    description: "15% de dcto en toda la tienda",
                  ),
                  _buildConvenioCard(
                    title: "Teatro Municipal",
                    category: "ARTE",
                    imagePath: "assets/images/culture_banner.png",
                    description: "Entrada gratuita a museos nacionales y galerías de arte adheridas.",
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConvenioCard({required String title, required String category, required String imagePath, required String description}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              imagePath,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 160,
                color: AppColors.background,
                child: const Icon(Icons.image_outlined, color: AppColors.textTertiary, size: 40),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                  child: Text(category, style: const TextStyle(color: AppColors.primaryBlue, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 12),
                Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: AppColors.textMain)),
                const SizedBox(height: 6),
                Text(description, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.4)),
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

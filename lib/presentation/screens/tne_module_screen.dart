import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tneapp/config/constants/colores.dart';

class TneModuleScreen extends StatelessWidget {
  const TneModuleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/appbar.png', height: 32),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              onTap: () => context.push('/profile'),
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.background,
                child: Icon(Icons.person, color: AppColors.primaryBlue, size: 20),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tarjeta Nacional Estudiantil',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppColors.textMain),
            ),
            const Text('Gestiona tu Pase Escolar Digital', style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 24),

            // Red Warning Banner
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(8),
                border: const Border(left: BorderSide(color: AppColors.secondaryRed, width: 4)),
              ),
              padding: const EdgeInsets.all(16),
              child: const Row(
                children: [
                  Icon(Icons.warning_rounded, color: AppColors.secondaryRed),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Tu TNE actual requiere revalidación antes del 31 de mayo.',
                      style: TextStyle(fontSize: 13, color: Color(0xFFB71C1C)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // TNE Card (Enhanced with Balance and Recharge)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0038A8), Color(0xFF001D4A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [BoxShadow(color: AppColors.primaryBlue.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(20)),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(radius: 4, backgroundColor: Colors.green),
                                SizedBox(width: 6),
                                Text('ACTIVA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text('Pase Escolar Digital', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Container(
                        width: 50,
                        height: 60,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white, width: 2)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network('https://i.pravatar.cc/150?u=camila', fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // NEW: Balance & Recharge Integrated
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('SALDO ACTUAL', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                            const Text('\$4.520', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () => context.push('/recharge'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primaryBlue,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('CARGAR', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        Image.asset('assets/images/qr.png', height: 130),
                        const SizedBox(height: 12),
                        const Text('ESCANEA EN EL VALIDADOR', style: TextStyle(fontWeight: FontWeight.w900, color: AppColors.primaryBlue, fontSize: 11, letterSpacing: 1.0)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Physical Card Item
            _buildInfoRow(Icons.credit_card, 'Tarjeta Física', 'Estado: Entregada'),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.history, 'Últimos Movimientos', 'Ver actividad reciente'),

            const SizedBox(height: 32),
            
            // Movements List
            const Text('Movimientos Recientes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textMain)),
            const SizedBox(height: 16),
            _MovementItem(icon: Icons.directions_bus, title: 'Viaje Bus (Red)', subtitle: 'Hoy, 08:30 hrs', amount: '-\$260', color: Colors.red[50]!),
            _MovementItem(icon: Icons.directions_subway, title: 'Viaje Metro (L1)', subtitle: 'Ayer, 18:15 hrs', amount: '-\$260', color: Colors.red[50]!),
            _MovementItem(icon: Icons.account_balance_wallet, title: 'Carga Web', subtitle: '12 May, 10:00 hrs', amount: '+\$5.000', color: Colors.blue[50]!, isPositive: true),

            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _CustomBottomNav(),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFFF1F5F9), shape: BoxShape.circle), child: Icon(icon, color: AppColors.textSecondary, size: 20)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textTertiary),
        ],
      ),
    );
  }
}

class _MovementItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;
  final Color color;
  final bool isPositive;

  const _MovementItem({required this.icon, required this.title, required this.subtitle, required this.amount, required this.color, this.isPositive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color, shape: BoxShape.circle), child: Icon(icon, color: isPositive ? Colors.blue : Colors.red, size: 20)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12))]),
          ),
          Text(amount, style: TextStyle(fontWeight: FontWeight.w900, color: isPositive ? Colors.blue[800] : Colors.red[800])),
        ],
      ),
    );
  }
}

class _CustomBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: AppColors.border.withOpacity(0.5)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(icon: Icons.home_filled, label: 'Inicio', isActive: false, onTap: () => context.go('/home')),
          _NavItem(icon: Icons.qr_code_scanner, label: 'TNE', isActive: true),
          _NavItem(icon: Icons.restaurant_menu, label: 'BAES', isActive: false, onTap: () => context.push('/baes-qr')),
          _NavItem(icon: Icons.school, label: 'Becas', isActive: false, onTap: () => context.push('/applications')),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const _NavItem({required this.icon, required this.label, required this.isActive, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(color: isActive ? AppColors.primaryBlue : Colors.transparent, borderRadius: BorderRadius.circular(16)),
            child: Icon(icon, color: isActive ? Colors.white : AppColors.textTertiary),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? AppColors.primaryBlue : AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

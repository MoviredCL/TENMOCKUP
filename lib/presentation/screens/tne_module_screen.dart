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
              child: CircleAvatar(
                radius: 18,
                backgroundImage: const NetworkImage(
                  'https://i.pravatar.cc/150?u=camila',
                ),
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
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: AppColors.textMain,
              ),
            ),
            const Text(
              'Gestiona tu Pase Escolar Digital',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),

            // Red Warning Banner
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(8),
                border: const Border(
                  left: BorderSide(color: AppColors.secondaryRed, width: 4),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: const Row(
                children: [
                  Icon(Icons.warning_rounded, color: AppColors.secondaryRed),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Tu TNE actual requiere revalidación antes del 31 de mayo para mantener el beneficio.',
                      style: TextStyle(fontSize: 13, color: Color(0xFFB71C1C)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // TNE Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF002271),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            CircleAvatar(
                              radius: 4,
                              backgroundColor: Colors.green,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'ACTIVA',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 45,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://i.pravatar.cc/150?u=camila',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pase Escolar Digital',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Tarifa Rebajada: \$260',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Image.asset('assets/images/qr.png', height: 140),
                        const SizedBox(height: 12),
                        const Text(
                          'Escanea en validador',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Balance Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  const Text(
                    'SALDO ACTUAL',
                    style: TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 12,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '\$4.520',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => context.push('/recharge'),
                    icon: const Icon(Icons.account_balance_wallet_outlined),
                    label: const Text('Carga Electrónica'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF002271),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Physical Card Item
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Icon(Icons.credit_card, color: AppColors.textSecondary),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tarjeta Física',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Estado: Entregada',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: AppColors.textTertiary),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Movements Section
            const Text(
              'Últimos Movimientos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textMain,
              ),
            ),
            const SizedBox(height: 16),
            _MovementItem(
              icon: Icons.directions_bus,
              title: 'Viaje Bus (Red)',
              subtitle: 'Hoy, 08:30 hrs',
              amount: '-\$260',
              color: Colors.red[50]!,
            ),
            _MovementItem(
              icon: Icons.directions_subway,
              title: 'Viaje Metro (L1)',
              subtitle: 'Ayer, 18:15 hrs',
              amount: '-\$260',
              color: Colors.red[50]!,
            ),
            _MovementItem(
              icon: Icons.account_balance_wallet,
              title: 'Carga Web',
              subtitle: '12 May, 10:00 hrs',
              amount: '+\$5.000',
              color: Colors.blue[50]!,
              isPositive: true,
            ),

            const SizedBox(height: 32),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Ver historial completo',
                      style: TextStyle(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: AppColors.primaryBlue,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _CustomBottomNav(),
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

  const _MovementItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.color,
    this.isPositive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(
              icon,
              color: isPositive ? Colors.blue : Colors.red,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: isPositive ? Colors.blue[800] : Colors.red[800],
            ),
          ),
        ],
      ),
    );
  }
}

// Reuse bottom nav from home for consistency
class _CustomBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColors.border.withOpacity(0.5)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.home_filled,
            label: 'Inicio',
            isActive: false,
            onTap: () => context.go('/home'),
          ),
          _NavItem(icon: Icons.qr_code_scanner, label: 'TNE', isActive: true),
          _NavItem(
            icon: Icons.restaurant_menu,
            label: 'BAES',
            isActive: false,
            onTap: () => context.push('/baes-qr'),
          ),
          _NavItem(
            icon: Icons.school,
            label: 'Becas',
            isActive: false,
            onTap: () => context.push('/applications'),
          ),
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

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primaryBlue : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : AppColors.textTertiary,
            ),
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

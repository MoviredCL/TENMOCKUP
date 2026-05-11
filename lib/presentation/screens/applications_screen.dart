import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tneapp/config/constants/colores.dart';

class ApplicationsScreen extends StatelessWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo-junaeb.webp', height: 32),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              onTap: () => context.push('/profile'),
              child: const CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=camila'),
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
              'Postulación y Resultados',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppColors.textMain),
            ),
            const Text(
              'Revisa el estado de tus beneficios y las fechas clave del proceso.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),

            // Warning Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.tertiaryYellow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.campaign, color: Colors.black, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'AVISO IMPORTANTE',
                          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 11),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'El periodo principal de postulación para el próximo año académico se encuentra activo durante los meses de Diciembre y Enero. Asegúrate de completar tus antecedentes a tiempo.',
                          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.8), height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Current Status Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Estado Actual',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.textMain),
                  ),
                  const Text('Beca Bicentenario', style: TextStyle(color: AppColors.textSecondary)),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0038A8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(radius: 3, backgroundColor: Colors.white),
                        SizedBox(width: 8),
                        Text('En Evaluación', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tu postulación ha sido recibida y se encuentra actualmente en proceso de revisión socioeconómica por el ministerio. Te notificaremos si requerimos información adicional.',
                          style: TextStyle(fontSize: 13, height: 1.5, color: AppColors.textMain.withOpacity(0.8)),
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Icon(Icons.history, size: 14, color: AppColors.textTertiary),
                            SizedBox(width: 8),
                            Text('Última actualización: 15 Dic, 14:30 hrs', style: TextStyle(fontSize: 11, color: AppColors.textTertiary)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Help Banner
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF002271),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Icon(Icons.headset_mic_outlined, color: Colors.white, size: 32),
                  const SizedBox(height: 12),
                  const Text(
                    '¿Necesitas ayuda?',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Contacta a nuestro Call Center para resolver tus dudas de postulación.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.phone_outlined, size: 18),
                    label: const Text('600 6600 400'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF002271),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Results Dates Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.calendar_month_outlined, color: Color(0xFF002271)),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Fechas de Publicación de Resultados',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.textMain),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  _DateItem(day: '06', month: 'Marzo', label: 'Primera Asignación', isFirst: true),
                  _DateItem(day: '08', month: 'Abril', label: 'Segunda Asignación'),
                  _DateItem(day: '08', month: 'Mayo', label: 'Apelaciones I'),
                  _DateItem(day: '05', month: 'Junio', label: 'Tercera Asignación'),
                  _DateItem(day: '07', month: 'Julio', label: 'Apelaciones II'),
                ],
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

class _DateItem extends StatelessWidget {
  final String day;
  final String month;
  final String label;
  final bool isFirst;

  const _DateItem({required this.day, required this.month, required this.label, this.isFirst = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textTertiary)),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isFirst ? const Color(0xFF002271) : const Color(0xFFF1F5F9),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    day,
                    style: TextStyle(
                      color: isFirst ? Colors.white : AppColors.textMain,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                month,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isFirst ? const Color(0xFF002271) : AppColors.textMain,
                ),
              ),
            ],
          ),
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
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border.withOpacity(0.5))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(icon: Icons.home_filled, label: 'Inicio', isActive: false, onTap: () => context.go('/home')),
          _NavItem(icon: Icons.qr_code_scanner, label: 'TNE', isActive: false, onTap: () => context.push('/recharge')),
          _NavItem(icon: Icons.restaurant_menu, label: 'BAES', isActive: false, onTap: () => context.push('/baes-qr')),
          _NavItem(icon: Icons.school, label: 'Becas', isActive: true),
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
            decoration: BoxDecoration(
              color: isActive ? AppColors.primaryBlue : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
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

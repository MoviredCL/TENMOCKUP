import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tneapp/config/constants/colores.dart';

class BenefitsScreen extends StatelessWidget {
  const BenefitsScreen({super.key});

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
            // Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: NetworkImage('https://www.transparenttextures.com/patterns/cubes.png'), // Mock pattern
                  opacity: 0.1,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Catálogo de Becas e Información',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Descubre las oportunidades de financiamiento y apoyo que JUNAEB tiene para ti. Simula tus opciones y postula a las becas que mejor se adapten a tu perfil académico y socioeconómico.',
                    style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Sync Profile Card
            _InfoCard(
              icon: Icons.verified_user,
              title: 'Perfil Sincronizado',
              description: 'Hemos analizado tu información socioeconómica y académica de forma segura. El listado de becas a continuación se ha filtrado automáticamente según tu perfil para mostrarte las opciones disponibles para ti.',
              footer: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E7FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.check_circle, color: AppColors.primaryBlue, size: 20),
                    SizedBox(width: 12),
                    Text('Resultados personalizados listos', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold, fontSize: 13)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // CONADI Card
            _InfoCard(
              icon: Icons.info,
              iconColor: AppColors.tertiaryYellow,
              backgroundColor: const Color(0xFFFEF9C3).withOpacity(0.3),
              title: 'Acreditación CONADI',
              description: 'Requisito exclusivo para la Beca Indígena. Debes contar con el certificado emitido por CONADI que acredite tu calidad indígena.',
              actionLabel: 'Saber más ->',
            ),
            const SizedBox(height: 20),
            
            // Postulación Card
            _InfoCard(
              icon: Icons.calendar_month,
              iconColor: AppColors.secondaryRed,
              title: 'Fechas de Postulación',
              description: 'Revisa el calendario oficial para no quedar fuera del proceso de renovación o postulación a beneficios de mantención.',
              actionLabel: 'Ver Calendario',
              onActionTap: () => context.push('/applications'),
              isActionCentered: true,
            ),
            const SizedBox(height: 32),
            
            // List Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Listado de Becas',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.textMain),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
                  child: Text('4 disponibles', style: TextStyle(fontSize: 11, color: Colors.grey[700], fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Beca Items
            _BecaItem(
              title: 'Beca Indígena',
              description: 'Aporte monetario de libre disposición para estudiantes de ascendencia...',
              tags: const ['Nota min. 5.0', 'RSH hasta 60%', 'Reg. CONADI'],
              isRenewable: true,
              leftBorderColor: AppColors.primaryBlue,
            ),
            _BecaItem(
              title: 'Beca Vocación de Profesor',
              description: 'Financia la matrícula y arancel por la duración formal de la carrera para...',
              tags: const ['PAES requerida', 'Arancel completo'],
              leftBorderColor: AppColors.secondaryRed,
            ),
            _BecaItem(
              title: 'Beca Integración Territorial',
              description: 'Aporte económico mensual y asignación para traslado para estudiantes de zonas...',
              tags: const ['Nota min. 5.0', 'RSH hasta 60%', 'Residencia específica'],
              isRenewable: true,
              leftBorderColor: AppColors.primaryBlue,
            ),
            _BecaItem(
              title: 'Beca de Reparación',
              description: 'Beneficio para personas individualizadas como víctimas en el...',
              tags: const ['Informe Valech', 'Sin requisito RSH'],
              leftBorderColor: const Color(0xFF854D0E),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _CustomBottomNav(),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final String title;
  final String description;
  final Widget? footer;
  final String? actionLabel;
  final VoidCallback? onActionTap;
  final bool isActionCentered;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.description,
    this.iconColor,
    this.backgroundColor,
    this.footer,
    this.actionLabel,
    this.onActionTap,
    this.isActionCentered = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor ?? AppColors.primaryBlue),
              const SizedBox(width: 12),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 12),
          Text(description, style: TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.4)),
          if (footer != null) ...[
            const SizedBox(height: 20),
            footer!,
          ],
          if (actionLabel != null) ...[
            const SizedBox(height: 12),
            Align(
              alignment: isActionCentered ? Alignment.center : Alignment.centerLeft,
              child: TextButton(
                onPressed: onActionTap ?? () {},
                style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
                child: Text(actionLabel!, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _BecaItem extends StatelessWidget {
  final String title;
  final String description;
  final List<String> tags;
  final bool isRenewable;
  final Color leftBorderColor;

  const _BecaItem({
    required this.title,
    required this.description,
    required this.tags,
    this.isRenewable = false,
    required this.leftBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Stack(
        children: [
          // Left accent border
          Positioned(
            left: 0, top: 0, bottom: 0,
            child: Container(
              width: 6,
              decoration: BoxDecoration(
                color: leftBorderColor,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.background,
                      child: Icon(_getIconForBeca(title), color: AppColors.primaryBlue, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    if (isRenewable)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: const Color(0xFFCA8A04), borderRadius: BorderRadius.circular(20)),
                        child: const Text('Renovable', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(description, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: tags.map((tag) => _Tag(label: tag)).toList(),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Ver detalles >', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForBeca(String title) {
    if (title.contains('Indígena')) return Icons.people_outline;
    if (title.contains('Profesor')) return Icons.volunteer_activism_outlined;
    if (title.contains('Territorial')) return Icons.map_outlined;
    return Icons.favorite_outline;
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
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
          _NavItem(icon: Icons.qr_code_scanner, label: 'TNE', isActive: false, onTap: () => context.push('/tne-module')),
          _NavItem(icon: Icons.restaurant_menu, label: 'BAES', isActive: false, onTap: () => context.push('/baes-qr')),
          _NavItem(icon: Icons.school, label: 'Becas', isActive: true, onTap: () => context.push('/applications')),
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

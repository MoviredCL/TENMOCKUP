import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tneapp/config/constants/colores.dart';

class ApplicationsScreen extends StatelessWidget {
  const ApplicationsScreen({super.key});

  void _showBenefitDetails(
    BuildContext context,
    String title,
    String status,
    Color statusColor,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.textMain,
                                    ),
                                  ),
                                  const Text(
                                    'Detalles del beneficio otorgado',
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                status,
                                style: TextStyle(
                                  color: statusColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        _buildDetailSection(
                          icon: Icons.payments_outlined,
                          title: 'Monto y Cobertura',
                          content:
                              title == 'Beca Bicentenario'
                                  ? 'Financia el 100% del arancel de referencia anual de la carrera. Se renueva anualmente según rendimiento académico.'
                                  : (title == 'Beca de alimentación'
                                      ? 'Asignación mensual de \$48.000 para compra de alimentos en comercios asociados.'
                                      : 'Asignación mensual de \$123.000 (pagado en 10 cuotas anuales) para libre disposición del estudiante.'),
                        ),
                        const SizedBox(height: 24),
                        _buildDetailSection(
                          icon: Icons.calendar_today_outlined,
                          title: 'Calendario de Pagos',
                          content:
                              title == 'Beca Bicentenario'
                                  ? 'Transferencia directa a la Universidad en dos cuotas (Semestre 1: Mayo, Semestre 2: Octubre).'
                                  : (title == 'Beca de alimentación'
                                      ? 'Carga automática el primer día de cada mes. El saldo vence el día 05 del mes siguiente.'
                                      : 'Depósito en CuentaRUT el día 05 de cada mes, entre los meses de Marzo y Diciembre.'),
                        ),
                        const SizedBox(height: 24),
                        _buildDetailSection(
                          icon: Icons.assignment_turned_in_outlined,
                          title: 'Requisitos de Mantención',
                          content:
                              title == 'Beca de alimentación'
                                  ? '• Mantener calidad de alumno regular.\n• Pertenecer al 60% más vulnerable (RSH).\n• Utilizar el saldo antes de su vencimiento mensual.'
                                  : '• Mantener calidad de alumno regular.\n• Promedio de notas superior a 5.0.\n• No exceder la duración formal de la carrera.',
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'ENTENDIDO',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildDetailSection({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: AppColors.primaryBlue),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            content,
            style: const TextStyle(
              color: AppColors.textMain,
              height: 1.5,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

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
              child: CircleAvatar(
                radius: 18,
                backgroundImage: const AssetImage(
                  'assets/images/user_profile.png',
                ),
                backgroundColor: AppColors.background,
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
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: AppColors.textMain,
                letterSpacing: -0.5,
              ),
            ),
            const Text(
              'Gestiona tus beneficios y revisa fechas clave.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),

            // Catalogue Button Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0038A8), Color(0xFF001D4A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0038A8).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.auto_stories_outlined,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Text(
                          'Catálogo de Becas',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '¿No sabes a qué beca postular? Explora todos los beneficios disponibles para tu nivel académico.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context.push('/benefits'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primaryBlue,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'VER CATÁLOGO',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Scholarships Status Section
            const Text(
              'Mis Beneficios Activos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppColors.textMain,
              ),
            ),
            const SizedBox(height: 16),

            // Scholarship 1: In Process
            _ScholarshipCard(
              title: 'Beca Bicentenario',
              folio: '#458293',
              status: 'EN PROCESO',
              statusColor: Colors.blue,
              progress: 0.6,
              onTap:
                  () => _showBenefitDetails(
                    context,
                    'Beca Bicentenario',
                    'EN PROCESO',
                    Colors.blue,
                  ),
            ),

            const SizedBox(height: 16),

            // Scholarship 3: BAES
            _ScholarshipCard(
              title: 'Beca de alimentación',
              folio: '#460221',
              status: 'APROBADA',
              statusColor: Colors.green,
              progress: 1.0,
              onTap:
                  () => _showBenefitDetails(
                    context,
                    'Beca de alimentación',
                    'APROBADA',
                    Colors.green,
                  ),
            ),

            const SizedBox(height: 32),

            // Fechas de Postulación Section
            const Text(
              'Fechas de Postulación',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppColors.textMain,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Proceso oficial de postulación y renovación 2025.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
            const SizedBox(height: 16),
            const _CalendarSection(),

            const SizedBox(height: 32),

            // Illustrated Timeline
            const Text(
              'Cronograma de Resultados',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppColors.textMain,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Fechas clave para la asignación de beneficios 2024.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: const Column(
                children: [
                  _TimelineItem(
                    day: '06',
                    month: 'MAR',
                    title: '1ª Asignación',
                    subtitle:
                        'Resultados alumnos renovantes y primer grupo nuevos.',
                    isLast: false,
                    isCompleted: true,
                  ),
                  _TimelineItem(
                    day: '08',
                    month: 'ABR',
                    title: '2ª Asignación',
                    subtitle: 'Publicación segundo grupo de pre-seleccionados.',
                    isLast: false,
                    isActive: true,
                  ),
                  _TimelineItem(
                    day: '08',
                    month: 'MAY',
                    title: 'Período Apelaciones',
                    subtitle: 'Inicio de proceso para rectificar antecedentes.',
                    isLast: false,
                  ),
                  _TimelineItem(
                    day: '05',
                    month: 'JUN',
                    title: 'Resultados Finales',
                    subtitle: 'Cierre de proceso de asignación 2026.',
                    isLast: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: const _CustomBottomNav(),
    );
  }
}

class _ScholarshipCard extends StatelessWidget {
  final String title;
  final String folio;
  final String status;
  final Color statusColor;
  final double progress;
  final VoidCallback onTap;

  const _ScholarshipCard({
    required this.title,
    required this.folio,
    required this.status,
    required this.statusColor,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Folio: $folio',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFFF1F5F9),
              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              minHeight: 8,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Ver detalles del beneficio',
                  style: TextStyle(fontSize: 11, color: AppColors.textTertiary),
                ),
                Icon(Icons.arrow_forward_ios, size: 12, color: statusColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String day;
  final String month;
  final String title;
  final String subtitle;
  final bool isLast;
  final bool isCompleted;
  final bool isActive;

  const _TimelineItem({
    required this.day,
    required this.month,
    required this.title,
    required this.subtitle,
    this.isLast = false,
    this.isCompleted = false,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50,
            child: Column(
              children: [
                Text(
                  day,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color:
                        isActive ? AppColors.primaryBlue : AppColors.textMain,
                  ),
                ),
                Text(
                  month,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color:
                      isCompleted
                          ? Colors.green
                          : (isActive ? AppColors.primaryBlue : Colors.white),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        isCompleted
                            ? Colors.green
                            : (isActive
                                ? AppColors.primaryBlue
                                : AppColors.border),
                    width: 2,
                  ),
                ),
                child:
                    isCompleted
                        ? const Icon(Icons.check, size: 10, color: Colors.white)
                        : null,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color:
                        isCompleted
                            ? Colors.green.withOpacity(0.5)
                            : AppColors.border,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color:
                          isActive ? AppColors.primaryBlue : AppColors.textMain,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomBottomNav extends StatelessWidget {
  const _CustomBottomNav();

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
          _NavItem(
            icon: Icons.qr_code_scanner,
            label: 'TNE',
            isActive: false,
            onTap: () => context.go('/tne-module'),
          ),
          _NavItem(
            icon: Icons.restaurant_menu,
            label: 'BAES',
            isActive: false,
            onTap: () => context.go('/baes-qr'),
          ),
          _NavItem(icon: Icons.school, label: 'Becas', isActive: true),
        ],
      ),
    );
  }
}

class _CalendarSection extends StatelessWidget {
  const _CalendarSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.calendar_month_rounded,
                  color: AppColors.primaryBlue,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Período 2026',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                  ),
                  Text(
                    'Postulación y Renovación',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildMonthCalendar('Diciembre', 5, 31, 3)),
              const SizedBox(width: 24),
              Expanded(child: _buildMonthCalendar('Enero', 1, 31, 2)),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border.withOpacity(0.5)),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 14,
                  color: AppColors.primaryBlue,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Trámite 100% online en portalbecas.junaeb.cl',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthCalendar(
    String monthName,
    int startRange,
    int endRange,
    int startDayOfWeek,
  ) {
    return Column(
      children: [
        Text(
          monthName,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              ['L', 'M', 'M', 'J', 'V', 'S', 'D']
                  .map(
                    (d) => SizedBox(
                      width: 16,
                      child: Text(
                        d,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 2,
          runSpacing: 2,
          children: List.generate(35, (index) {
            final day = index - startDayOfWeek + 1;
            final isVisible = day > 0 && day <= 31;
            final inRange = isVisible && day >= startRange && day <= endRange;

            return Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: inRange ? AppColors.primaryBlue : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  isVisible ? day.toString() : '',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: inRange ? FontWeight.bold : FontWeight.normal,
                    color:
                        isVisible
                            ? (inRange ? Colors.white : AppColors.textSecondary)
                            : Colors.transparent,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
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

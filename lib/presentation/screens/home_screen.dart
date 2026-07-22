import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tneapp/config/constants/colores.dart';
import 'package:tneapp/presentation/widgets/student_qr_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _benefitStage = 0; // 0: Desayuno disponible, 1: Desayuno cobrado, 2: Almuerzo disponible, 3: Almuerzo cobrado
  Timer? _lunchTimer;

  @override
  void dispose() {
    _lunchTimer?.cancel();
    super.dispose();
  }

  void _showBreakfastModalSheet(BuildContext context) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    StudentQrDialog.show(
      context,
      nombre: 'Camila Fuentes Díaz',
      rut: '33333333-3',
      codigoQr: 'PGQP4XYU',
      confirmText: 'Imprimir',
      onConfirm: () {
        if (mounted) {
          setState(() {
            _benefitStage = 1;
          });
        }
        messenger?.showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle_rounded, color: Colors.white),
                SizedBox(width: 12),
                Text('Desayuno cobrado', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ],
            ),
            backgroundColor: Colors.green.shade600,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.all(16),
            duration: const Duration(seconds: 4),
          ),
        );

        _lunchTimer?.cancel();
        _lunchTimer = Timer(const Duration(seconds: 30), () {
          if (mounted) {
            setState(() {
              _benefitStage = 2;
            });
            messenger?.showSnackBar(
              SnackBar(
                content: const Row(
                  children: [
                    Icon(Icons.restaurant_rounded, color: Colors.white),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '¡Almuerzo disponible! Ya puedes retirar tu beneficio.',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ],
                ),
                backgroundColor: const Color(0xFF4F46E5),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.all(16),
                duration: const Duration(seconds: 5),
              ),
            );
          }
        });
      },
    );
  }

  void _showLunchModalSheet(BuildContext context) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    StudentQrDialog.show(
      context,
      nombre: 'Camila Fuentes Díaz',
      rut: '33333333-3',
      codigoQr: 'PGQP4XYU',
      confirmText: 'Imprimir',
      onConfirm: () {
        if (mounted) {
          setState(() {
            _benefitStage = 3;
          });
        }
        messenger?.showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle_rounded, color: Colors.white),
                SizedBox(width: 12),
                Text('Almuerzo cobrado', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ],
            ),
            backgroundColor: Colors.green.shade600,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.all(16),
            duration: const Duration(seconds: 4),
          ),
        );
      },
    );
  }

  void _showFoodHistoryModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            height: MediaQuery.of(context).size.height * 0.88,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.analytics_rounded,
                            color: AppColors.primaryBlue,
                            size: 26,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Historial y Seguimiento',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: AppColors.textMain,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Registro mensual del Programa de Alimentación Escolar (PAE)',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // KPI Summary Cards Row
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEFF6FF),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color(0xFFBFDBFE),
                                  ),
                                ),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Asistencia PAE',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1E40AF),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '92%',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFF1E3A8A),
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      '22 de 24 días',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFF3B82F6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFECFDF5),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color(0xFFA7F3D0),
                                  ),
                                ),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Desayunos',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF065F46),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '11 / 12',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFF047857),
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      '91.6% retirados',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFF10B981),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEEF2FF),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color(0xFFC7D2FE),
                                  ),
                                ),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Almuerzos',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF3730A3),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '11 / 12',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFF4338CA),
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      '91.6% retirados',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFF6366F1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Weekly Attendance Chart Title
                        const Text(
                          'Asistencia Semanal (Esta Semana)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textMain,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Chart Card
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  _buildDayBar(
                                    'Lun 20',
                                    breakfast: true,
                                    lunch: true,
                                    height: 90,
                                  ),
                                  _buildDayBar(
                                    'Mar 21',
                                    breakfast: _benefitStage >= 1,
                                    lunch: _benefitStage >= 3,
                                    isToday: true,
                                    height: 100,
                                  ),
                                  _buildDayBar(
                                    'Mié 22',
                                    breakfast: false,
                                    lunch: false,
                                    isFuture: true,
                                    height: 40,
                                  ),
                                  _buildDayBar(
                                    'Jue 23',
                                    breakfast: false,
                                    lunch: false,
                                    isFuture: true,
                                    height: 40,
                                  ),
                                  _buildDayBar(
                                    'Vie 24',
                                    breakfast: false,
                                    lunch: false,
                                    isFuture: true,
                                    height: 40,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Divider(),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildLegendDot(
                                    Colors.green.shade600,
                                    'Cobrado',
                                  ),
                                  const SizedBox(width: 16),
                                  _buildLegendDot(
                                    Colors.orange.shade600,
                                    'Disponible',
                                  ),
                                  const SizedBox(width: 16),
                                  _buildLegendDot(
                                    Colors.grey.shade400,
                                    'Pendiente',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Detailed Daily Log Title
                        const Text(
                          'Registro de Días Anteriores',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textMain,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Daily Log List
                        _buildHistoryDayCard(
                          date: 'Hoy (Martes 21 de Julio)',
                          breakfastStatus:
                              _benefitStage >= 1
                                  ? 'Cobrado • 08:30 hrs'
                                  : 'Disponible',
                          breakfastSuccess: _benefitStage >= 1,
                          lunchStatus:
                              _benefitStage >= 3
                                  ? 'Cobrado • 13:15 hrs'
                                  : (_benefitStage == 2
                                      ? 'Disponible'
                                      : 'Pendiente (12:30 hrs)'),
                          lunchSuccess: _benefitStage >= 3,
                        ),
                        const SizedBox(height: 10),
                        _buildHistoryDayCard(
                          date: 'Lunes 20 de Julio',
                          breakfastStatus: 'Cobrado • 08:22 hrs',
                          breakfastSuccess: true,
                          lunchStatus: 'Cobrado • 13:10 hrs',
                          lunchSuccess: true,
                        ),
                        const SizedBox(height: 10),
                        _buildHistoryDayCard(
                          date: 'Viernes 17 de Julio',
                          breakfastStatus: 'Cobrado • 08:45 hrs',
                          breakfastSuccess: true,
                          lunchStatus: 'Cobrado • 13:30 hrs',
                          lunchSuccess: true,
                        ),
                        const SizedBox(height: 10),
                        _buildHistoryDayCard(
                          date: 'Jueves 16 de Julio',
                          breakfastStatus: 'No registrado',
                          breakfastSuccess: false,
                          lunchStatus: 'Cobrado • 12:55 hrs',
                          lunchSuccess: true,
                        ),
                        const SizedBox(height: 10),
                        _buildHistoryDayCard(
                          date: 'Miércoles 15 de Julio',
                          breakfastStatus: 'Cobrado • 08:15 hrs',
                          breakfastSuccess: true,
                          lunchStatus: 'Cobrado • 13:20 hrs',
                          lunchSuccess: true,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildDayBar(
    String dayLabel, {
    required bool breakfast,
    required bool lunch,
    bool isToday = false,
    bool isFuture = false,
    double height = 80,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: height * 0.45,
              decoration: BoxDecoration(
                color:
                    isFuture
                        ? Colors.grey.shade300
                        : (breakfast
                            ? Colors.green.shade500
                            : Colors.orange.shade400),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(width: 4),
            Container(
              width: 10,
              height: height * 0.45,
              decoration: BoxDecoration(
                color:
                    isFuture
                        ? Colors.grey.shade300
                        : (lunch
                            ? Colors.indigo.shade600
                            : Colors.grey.shade400),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          dayLabel,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isToday ? FontWeight.w900 : FontWeight.w600,
            color: isToday ? AppColors.primaryBlue : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildLegendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryDayCard({
    required String date,
    required String breakfastStatus,
    required bool breakfastSuccess,
    required String lunchStatus,
    required bool lunchSuccess,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 13,
              color: AppColors.textMain,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      breakfastSuccess ? Icons.check_circle : Icons.schedule,
                      size: 16,
                      color:
                          breakfastSuccess
                              ? Colors.green.shade600
                              : Colors.orange.shade700,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Desayuno: $breakfastStatus',
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              breakfastSuccess
                                  ? Colors.green.shade900
                                  : AppColors.textSecondary,
                          fontWeight:
                              breakfastSuccess
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      lunchSuccess ? Icons.check_circle : Icons.schedule,
                      size: 16,
                      color:
                          lunchSuccess
                              ? Colors.indigo.shade600
                              : Colors.grey.shade500,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Almuerzo: $lunchStatus',
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              lunchSuccess
                                  ? Colors.indigo.shade900
                                  : AppColors.textSecondary,
                          fontWeight:
                              lunchSuccess
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AppBar(
              backgroundColor: Colors.white.withOpacity(0.7),
              elevation: 0,
              scrolledUnderElevation: 0,
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
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, kToolbarHeight + 80, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hola, Camila',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: AppColors.primaryBlue,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Aquí tienes el resumen de tus beneficios vigentes.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Sequential Benefit Alerts (Desayuno / Almuerzo)
            if (_benefitStage == 0)
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _showBreakfastModalSheet(context),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF7E5F), Color(0xFFFF9966)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF7E5F).withOpacity(0.35),
                            blurRadius: 12,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.free_breakfast_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '¡Beneficio Disponible!',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Ve por tu desayuno',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            if (_benefitStage == 1)
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFA7F3D0)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xFF059669),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Desayuno cobrado',
                            style: TextStyle(
                              color: Color(0xFF065F46),
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Has retirado con éxito tu beneficio de hoy. En 30 seg estará disponible tu almuerzo.',
                            style: TextStyle(
                              color: Color(0xFF047857),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            if (_benefitStage == 2)
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _showLunchModalSheet(context),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4F46E5).withOpacity(0.35),
                            blurRadius: 12,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.lunch_dining_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '¡Beneficio Disponible!',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Ve por tu almuerzo',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            if (_benefitStage == 3)
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFA7F3D0)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xFF059669),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Almuerzo cobrado',
                            style: TextStyle(
                              color: Color(0xFF065F46),
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Has retirado con éxito tu almuerzo de hoy.',
                            style: TextStyle(
                              color: Color(0xFF047857),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),



            // TNE Digital Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2E58A6), Color(0xFF1E3A8A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryBlue.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tu TNE Digital',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(
                        Icons.qr_code_2,
                        color: Colors.white70,
                        size: 28,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(radius: 4, backgroundColor: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Estado: Activa',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Saldo TNE',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '\$2.450',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () => context.push('/tne-module'),
                        icon: const Icon(Icons.qr_code_scanner, size: 20),
                        label: const Text('Mostrar QR'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primaryBlue,
                          minimumSize: const Size(120, 44),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // BAES Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: DecorationImage(
                  image: const AssetImage('assets/images/baes_card_bg.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Beca BAES',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.restaurant,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Saldo disponible Mayo',
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    '\$48.000',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => context.push('/baes-qr'),
                    icon: const Icon(Icons.qr_code_scanner),
                    label: const Text(
                      'PAGAR',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primaryBlue,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Applications Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Mis Postulaciones',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain,
                  ),
                ),
                TextButton(
                  onPressed: () => context.push('/applications'),
                  child: const Text(
                    'Ver historial',
                    style: TextStyle(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _ApplicationItem(
              icon: Icons.school_outlined,
              title: 'Beca Bicentenario',
              subtitle: 'Renovación 2026',
              status: 'En Evaluación',
              statusColor: Colors.grey[200]!,
              textColor: AppColors.textSecondary,
              onTap: () => context.push('/applications'),
            ),
            const SizedBox(height: 12),
            _ApplicationItem(
              icon: Icons.medical_services_outlined,
              title: 'Servicios Médicos',
              subtitle: 'Atención Oftalmológica',
              status: 'Agendado',
              statusColor: const Color(0xFFE0E7FF),
              textColor: const Color(0xFF4338CA),
            ),
            const SizedBox(height: 32),

            // Alimentación Panel Section (below Mis Postulaciones)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Alimentación',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _showFoodHistoryModalSheet(context),
                  icon: const Icon(Icons.bar_chart_rounded, size: 18),
                  label: const Text(
                    'Historial y Seguimiento',
                    style: TextStyle(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _FoodLogItem(
              title: 'Desayuno Estudiantil',
              subtitle: 'Casino Principal • 08:00 - 10:00 hrs',
              icon: Icons.free_breakfast_rounded,
              status: _benefitStage >= 1 ? 'Cobrado (08:30 hrs)' : 'Disponible',
              statusColor: _benefitStage >= 1 ? Colors.green.shade100 : Colors.orange.shade100,
              textColor: _benefitStage >= 1 ? Colors.green.shade900 : Colors.orange.shade900,
              isCompleted: _benefitStage >= 1,
            ),
            const SizedBox(height: 10),
            _FoodLogItem(
              title: 'Almuerzo Estudiantil',
              subtitle: 'Casino Principal • 12:30 - 14:30 hrs',
              icon: Icons.lunch_dining_rounded,
              status: _benefitStage >= 3
                  ? 'Cobrado (13:15 hrs)'
                  : (_benefitStage == 2 ? 'Disponible' : 'Próximo (12:30)'),
              statusColor: _benefitStage >= 3
                  ? Colors.green.shade100
                  : (_benefitStage == 2 ? Colors.indigo.shade100 : Colors.grey.shade200),
              textColor: _benefitStage >= 3
                  ? Colors.green.shade900
                  : (_benefitStage == 2 ? Colors.indigo.shade900 : AppColors.textSecondary),
              isCompleted: _benefitStage >= 3,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _CustomBottomNav(),
    );
  }
}

class _ApplicationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String status;
  final Color statusColor;
  final Color textColor;
  final VoidCallback? onTap;

  const _ApplicationItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.statusColor,
    required this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.background,
              child: Icon(icon, color: AppColors.primaryBlue),
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: AppColors.textTertiary),
          ],
        ),
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
        border: Border(
          top: BorderSide(color: AppColors.border.withOpacity(0.5)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(icon: Icons.home_filled, label: 'Inicio', isActive: true),
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
          _NavItem(
            icon: Icons.school,
            label: 'Becas',
            isActive: false,
            onTap: () => context.go('/applications'),
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

class _FoodLogItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String status;
  final Color statusColor;
  final Color textColor;
  final bool isCompleted;

  const _FoodLogItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.status,
    required this.statusColor,
    required this.textColor,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isCompleted
                ? Colors.green.shade50
                : AppColors.primaryBlue.withOpacity(0.08),
            child: Icon(
              icon,
              color: isCompleted ? Colors.green.shade700 : AppColors.primaryBlue,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppColors.textMain,
                  ),
                ),
                const SizedBox(height: 2),
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isCompleted) ...[
                  Icon(Icons.check_circle, size: 12, color: textColor),
                  const SizedBox(width: 4),
                ],
                Text(
                  status,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

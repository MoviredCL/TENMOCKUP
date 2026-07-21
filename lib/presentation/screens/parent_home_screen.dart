import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tneapp/config/constants/colores.dart';
import 'package:tneapp/models/parent_child_data.dart';

class ParentHomeScreen extends StatefulWidget {
  const ParentHomeScreen({super.key});

  @override
  State<ParentHomeScreen> createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends State<ParentHomeScreen> {
  final ParentDataStore _store = ParentDataStore.instance;

  @override
  void initState() {
    super.initState();
    _store.addListener(_onStoreUpdate);
  }

  @override
  void dispose() {
    _store.removeListener(_onStoreUpdate);
    super.dispose();
  }

  void _onStoreUpdate() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final selectedChild = _store.activeChild;


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
                    onTap: () => context.push('/parent-profile'),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey[200],
                      child: const Icon(
                        Icons.person,
                        color: AppColors.primaryBlue,
                      ),
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
            // Children Selector Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Mis Pupilos',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _showAddChildModal(context),
                  icon: const Icon(Icons.add_circle_outline, size: 18),
                  label: const Text(
                    'Vincular Pupilo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              child: Row(
                children: [
                  ...List.generate(_store.children.length, (index) {
                    final isSelected = index == _store.selectedChildIndex;
                    final child = _store.children[index];
                    return GestureDetector(
                      onTap: () {
                        _store.setSelectedChildIndex(index);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? AppColors.primaryBlue
                                  : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color:
                                isSelected
                                    ? AppColors.primaryBlue
                                    : AppColors.border,
                            width: 2,
                          ),
                          boxShadow:
                              isSelected
                                  ? [
                                    BoxShadow(
                                      color: AppColors.primaryBlue.withOpacity(
                                        0.3,
                                      ),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                  : [],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundImage: AssetImage(
                                child.image,
                              ),
                              backgroundColor: Colors.grey[300],
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  child.name,
                                  style: TextStyle(
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : AppColors.textMain,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${child.curso} • ${child.rut}',
                                  style: TextStyle(
                                    color:
                                        isSelected
                                            ? Colors.white70
                                            : AppColors.textTertiary,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Pupilo Tracking Title
            Row(
              children: [
                const Icon(
                  Icons.shield_outlined,
                  color: AppColors.primaryBlue,
                  size: 22,
                ),
                const SizedBox(width: 8),
                Text(
                  'Seguimiento de ${selectedChild.name}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // TNE Digital Card (Pupilo)
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'TNE Digital Pupilo',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            selectedChild.name,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
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
                            CircleAvatar(
                              radius: 4,
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Activa',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Saldo Transporte',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            selectedChild.formattedTneBalance,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () => context.push('/parent-recharge'),
                        icon: const Icon(Icons.payment, size: 18),
                        label: const Text('Cargar Saldo'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primaryBlue,
                          minimumSize: const Size(130, 44),
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

            // BAES Card (Pupilo)
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Beca BAES',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            'Saldo disponible ${selectedChild.name}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
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
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        selectedChild.formattedBaesBalance,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => context.push('/parent-movements'),
                        icon: const Icon(Icons.list_alt, size: 18),
                        label: const Text('Ver Movs'),
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
            const SizedBox(height: 32),

            // Alimentación PAE Section (Pupilo Tracking)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    'Alimentación PAE',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMain,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed:
                      () => _showFoodHistoryModalSheet(
                        context,
                        selectedChild.name,
                      ),
                  icon: const Icon(Icons.bar_chart_rounded, size: 16),
                  label: const Text(
                    'Historial',
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
              subtitle: 'Casino Principal • Hoy 08:30 hrs',
              icon: Icons.free_breakfast_rounded,
              status: 'Cobrado (08:30 hrs)',
              statusColor: Colors.green.shade100,
              textColor: Colors.green.shade900,
              isCompleted: true,
            ),
            const SizedBox(height: 10),
            _FoodLogItem(
              title: 'Almuerzo Estudiantil',
              subtitle: 'Casino Principal • Hoy 13:15 hrs',
              icon: Icons.lunch_dining_rounded,
              status: 'Cobrado (13:15 hrs)',
              statusColor: Colors.green.shade100,
              textColor: Colors.green.shade900,
              isCompleted: true,
            ),
            const SizedBox(height: 32),

            // Postulaciones & Becas Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    'Becas y Postulaciones',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMain,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () => context.push('/parent-scholarships'),
                  icon: const Icon(Icons.edit_document, size: 16),
                  label: const Text(
                    'Ver Becas',
                    style: TextStyle(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _ApplicationItem(
              icon: Icons.school_outlined,
              title: selectedChild.scholarships.isNotEmpty ? selectedChild.scholarships.first.title : 'Beca Bicentenario',
              subtitle: 'Renovación 2026 • ${selectedChild.name}',
              status: selectedChild.scholarships.isNotEmpty ? selectedChild.scholarships.first.status : 'En Evaluación',
              statusColor: Colors.grey[200]!,
              textColor: AppColors.textSecondary,
              onTap: () => context.push('/parent-scholarships'),
            ),
            const SizedBox(height: 10),
            _ApplicationItem(
              icon: Icons.medical_services_outlined,
              title: 'Servicios Médicos JUNAEB',
              subtitle: 'Atención Oftalmológica • Agendado',
              status: 'Agendado',
              statusColor: const Color(0xFFE0E7FF),
              textColor: const Color(0xFF4338CA),
              onTap: () => context.push('/parent-scholarships'),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _ParentBottomNav(),
    );
  }

  void _showFoodHistoryModalSheet(BuildContext context, String childName) {
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
                      Row(
                        children: [
                          const Icon(
                            Icons.analytics_rounded,
                            color: AppColors.primaryBlue,
                            size: 26,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Seguimiento: $childName',
                            style: const TextStyle(
                              fontSize: 18,
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
                      'Seguimiento de alimentación en casino escolar (PAE)',
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
                                    breakfast: true,
                                    lunch: true,
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
                          breakfastStatus: 'Cobrado • 08:30 hrs',
                          breakfastSuccess: true,
                          lunchStatus: 'Cobrado • 13:15 hrs',
                          lunchSuccess: true,
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

  void _showAddChildModal(BuildContext context) {
    final rutController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Vincular Pupilo',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Ingresa el RUT de tu hijo para realizarle seguimiento en tiempo real.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: rutController,
                    decoration: InputDecoration(
                      labelText: 'RUT del alumno',
                      hintText: 'Ej: 12.345.678-9',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (rutController.text.isNotEmpty) {
                        _store.addChild('Nuevo Pupilo', rutController.text, '1° Medio A', 'Liceo de Aplicación');
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                    ),
                    child: const Text('Vincular'),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
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
            backgroundColor:
                isCompleted
                    ? Colors.green.shade50
                    : AppColors.primaryBlue.withOpacity(0.08),
            child: Icon(
              icon,
              color:
                  isCompleted ? Colors.green.shade700 : AppColors.primaryBlue,
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

class _ParentBottomNav extends StatelessWidget {
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
            icon: Icons.payment,
            label: 'Recarga TNE',
            isActive: false,
            onTap: () => context.push('/parent-recharge'),
          ),
          _NavItem(
            icon: Icons.list_alt,
            label: 'Movimientos',
            isActive: false,
            onTap: () => context.push('/parent-movements'),
          ),
          _NavItem(
            icon: Icons.school,
            label: 'Becas',
            isActive: false,
            onTap: () => context.push('/parent-scholarships'),
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

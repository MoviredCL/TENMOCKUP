import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tneapp/config/constants/colores.dart';
import '../../models/beneficio.dart';
import '../bloc/establishment/establishment_auth_bloc.dart';
import '../bloc/establishment/establishment_delivery_bloc.dart';

class EstablishmentHomeScreen extends StatefulWidget {
  const EstablishmentHomeScreen({super.key});

  @override
  State<EstablishmentHomeScreen> createState() => _EstablishmentHomeScreenState();
}

class _EstablishmentHomeScreenState extends State<EstablishmentHomeScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EstablishmentDeliveryBloc>().add(LoadBeneficios());
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EstablishmentAuthBloc, EstablishmentAuthState>(
      listener: (context, state) {
        if (state is EstablishmentUnauthenticated) {
          context.go('/login-establishment');
        }
      },
      builder: (context, authState) {
        final user = authState is EstablishmentAuthenticated ? authState.user : null;
        final est = user?.establecimiento;

        return Scaffold(
          backgroundColor: AppColors.background,
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: AppBar(
                  backgroundColor: Colors.white.withOpacity(0.85),
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  title: Image.asset('assets/images/logo-junaeb.webp', height: 32),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.redAccent),
                      tooltip: 'Cerrar Sesión',
                      onPressed: () {
                        context.read<EstablishmentAuthBloc>().add(LogoutRequested());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: BlocBuilder<EstablishmentDeliveryBloc, EstablishmentDeliveryState>(
            builder: (context, deliveryState) {
              return IndexedStack(
                index: _currentIndex,
                children: [
                  // Tab 0: Inicio / Perfil Establecimiento
                  _buildInicioTab(context, user, est, deliveryState),

                  // Tab 1: Stock Alimentación
                  _buildStockCategoryTab(
                    context: context,
                    deliveryState: deliveryState,
                    areaKeyword: 'aliment',
                    categoryTitle: 'Stock de Alimentación',
                    categorySubtitle: 'Selecciona un beneficio alimentario para asignar a un alumno',
                    categoryIcon: Icons.restaurant,
                    themeColor: const Color(0xFF10B981),
                  ),

                  // Tab 2: Stock Salud
                  _buildStockCategoryTab(
                    context: context,
                    deliveryState: deliveryState,
                    areaKeyword: 'salud',
                    categoryTitle: 'Stock de Salud',
                    categorySubtitle: 'Selecciona un beneficio de salud para asignar a un alumno',
                    categoryIcon: Icons.health_and_safety,
                    themeColor: const Color(0xFFEF4444),
                  ),

                  // Tab 3: Stock Útiles
                  _buildStockCategoryTab(
                    context: context,
                    deliveryState: deliveryState,
                    areaKeyword: 'util',
                    categoryTitle: 'Stock de Útiles Escolares',
                    categorySubtitle: 'Selecciona un beneficio de útiles para asignar a un alumno',
                    categoryIcon: Icons.backpack,
                    themeColor: AppColors.primaryBlue,
                  ),
                ],
              );
            },
          ),
          bottomNavigationBar: _buildBottomNavigationBar(),
        );
      },
    );
  }

  // TAB 0: INICIO
  Widget _buildInicioTab(
    BuildContext context,
    dynamic user,
    dynamic est,
    EstablishmentDeliveryState deliveryState,
  ) {
    return RefreshIndicator(
      color: AppColors.primaryBlue,
      onRefresh: () async {
        context.read<EstablishmentDeliveryBloc>().add(LoadBeneficios());
        await Future.delayed(const Duration(milliseconds: 600));
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, kToolbarHeight + 70, 20, 30),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.school,
                        color: AppColors.primaryBlue,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            est?.nombre ?? 'Establecimiento Educacional',
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textMain,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            est?.rut.isNotEmpty == true
                                ? 'RUT: ${est!.rut}'
                                : 'ID Establecimiento: ${user?.establecimientoId ?? "-"}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(color: AppColors.border),
                ),
                Row(
                  children: [
                    const Icon(Icons.person_outline, size: 20, color: AppColors.textSecondary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        user?.name ?? 'Usuario Autenticado',
                        style: const TextStyle(
                          color: AppColors.textMain,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        (user?.rol ?? 'operario').toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          const Text(
            'Categorías de Stock y Entrega',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textMain,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Selecciona una categoría de la barra inferior o accede rápidamente desde aquí:',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),

          const SizedBox(height: 16),

          // Quick Category Shortcuts
          _CategoryShortcutCard(
            title: 'Alimentación',
            subtitle: 'Colaciones, almuerzo y apoyos alimentarios',
            icon: Icons.restaurant,
            iconColor: const Color(0xFF10B981),
            bgColor: const Color(0xFFECFDF5),
            onTap: () => _onTabTapped(1),
          ),
          const SizedBox(height: 12),
          _CategoryShortcutCard(
            title: 'Salud',
            subtitle: 'Lentes, programas médicos y órtesis',
            icon: Icons.health_and_safety,
            iconColor: const Color(0xFFEF4444),
            bgColor: const Color(0xFFFEF2F2),
            onTap: () => _onTabTapped(2),
          ),
          const SizedBox(height: 12),
          _CategoryShortcutCard(
            title: 'Útiles Escolares',
            subtitle: 'Sets de útiles por nivel educativo',
            icon: Icons.backpack,
            iconColor: AppColors.primaryBlue,
            bgColor: const Color(0xFFEFF6FF),
            onTap: () => _onTabTapped(3),
          ),

          const SizedBox(height: 24),
        ],
      ),
    ),
  );
}

  // TABS 1, 2, 3: CATEGORY STOCK PAGES
  Widget _buildStockCategoryTab({
    required BuildContext context,
    required EstablishmentDeliveryState deliveryState,
    required String areaKeyword,
    required String categoryTitle,
    required String categorySubtitle,
    required IconData categoryIcon,
    required Color themeColor,
  }) {
    if (deliveryState.isLoadingBeneficios) {
      return const Center(child: CircularProgressIndicator());
    }

    // Find area matching keyword
    BeneficioArea? area;
    for (final a in deliveryState.areas) {
      if (a.nombre.toLowerCase().contains(areaKeyword.toLowerCase())) {
        area = a;
        break;
      }
    }

    // Fallback if not matched strictly by keyword but index matches available areas
    if (area == null && deliveryState.areas.isNotEmpty) {
      if (areaKeyword == 'aliment' && deliveryState.areas.isNotEmpty) {
        area = deliveryState.areas[0];
      } else if (areaKeyword == 'salud' && deliveryState.areas.length > 1) {
        area = deliveryState.areas[1];
      } else if (areaKeyword == 'util' && deliveryState.areas.length > 2) {
        area = deliveryState.areas[2];
      }
    }

    final beneficios = area?.beneficios ?? [];

    return RefreshIndicator(
      color: themeColor,
      onRefresh: () async {
        context.read<EstablishmentDeliveryBloc>().add(LoadBeneficios());
        await Future.delayed(const Duration(milliseconds: 600));
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, kToolbarHeight + 70, 20, 30),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Banner Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [themeColor, themeColor.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: themeColor.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(categoryIcon, color: Colors.white, size: 30),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        categoryTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        categorySubtitle,
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Beneficios en Stock',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMain,
                ),
              ),
              Text(
                '${beneficios.length} disponible(s)',
                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 14),

          if (beneficios.isEmpty)
            Container(
              padding: const EdgeInsets.all(32),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  Icon(Icons.inventory_2_outlined, size: 48, color: Colors.grey.shade400),
                  const SizedBox(height: 12),
                  const Text(
                    'No hay beneficios cargados en esta categoría.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          for (final b in beneficios)
            _buildStockCard(context, b, themeColor),
        ],
      ),
    ),
  );
}

  Widget _buildStockCard(BuildContext context, Beneficio beneficio, Color themeColor) {
    final canBeSelected = beneficio.canBeDelivered;
    final isOutOfStock = beneficio.isOutOfStock;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: canBeSelected ? Colors.white : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: canBeSelected ? AppColors.border : Colors.grey.shade300,
        ),
        boxShadow: canBeSelected
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: canBeSelected
              ? () {
                  context.push('/establishment-assign-benefit', extra: beneficio);
                }
              : null,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: canBeSelected
                        ? themeColor.withOpacity(0.1)
                        : Colors.red.shade50,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    canBeSelected ? Icons.inventory_2 : Icons.block,
                    color: canBeSelected ? themeColor : Colors.red.shade400,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        beneficio.nombre,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: canBeSelected ? AppColors.textMain : Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: canBeSelected
                                  ? Colors.green.shade50
                                  : Colors.red.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              beneficio.stockActual == null
                                  ? 'Stock ilimitado'
                                  : (isOutOfStock
                                      ? 'SIN STOCK'
                                      : 'Stock: ${beneficio.stockActual}'),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: canBeSelected
                                    ? Colors.green.shade800
                                    : Colors.red.shade800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (canBeSelected)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: AppColors.primaryBlue,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // BOTTOM NAV BAR
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColors.border.withOpacity(0.6)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primaryBlue,
          unselectedItemColor: AppColors.textTertiary,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 11),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant),
              label: 'Alimentación',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.health_and_safety),
              label: 'Salud',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.backpack),
              label: 'Útiles',
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryShortcutCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final VoidCallback onTap;

  const _CategoryShortcutCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.onTap,
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
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: iconColor, size: 24),
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
                      fontSize: 16,
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
            const Icon(Icons.chevron_right, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}

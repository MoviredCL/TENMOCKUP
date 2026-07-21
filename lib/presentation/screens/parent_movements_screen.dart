import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tneapp/config/constants/colores.dart';
import 'package:tneapp/models/parent_child_data.dart';

class ParentMovementsScreen extends StatefulWidget {
  const ParentMovementsScreen({super.key});

  @override
  State<ParentMovementsScreen> createState() => _ParentMovementsScreenState();
}

class _ParentMovementsScreenState extends State<ParentMovementsScreen> with SingleTickerProviderStateMixin {
  final ParentDataStore _store = ParentDataStore.instance;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _store.addListener(_onStoreUpdate);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _store.removeListener(_onStoreUpdate);
    super.dispose();
  }

  void _onStoreUpdate() {
    if (mounted) setState(() {});
  }

  void _showMovementDetail(ChildMovement movement, ChildProfile child) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: movement.isCredit ? Colors.green.shade50 : AppColors.primaryBlue.withOpacity(0.1),
                  child: Icon(
                    movement.icon,
                    color: movement.isCredit ? Colors.green.shade700 : AppColors.primaryBlue,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movement.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textMain,
                        ),
                      ),
                      Text(
                        'Pupilo: ${child.name} • ${child.curso}',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 12),
            _detailRow('Monto:', movement.amount, isBold: true, amountColor: movement.isCredit ? Colors.green.shade800 : AppColors.textMain),
            _detailRow('Ubicación:', movement.location),
            _detailRow('Fecha y hora:', movement.date),
            _detailRow('Categoría:', movement.category),
            _detailRow('N° Tarjeta:', movement.category == 'Transporte' ? child.tneCardNumber : child.baesCardNumber),
            _detailRow('Estado:', movement.status ?? 'Aprobado'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Cerrar Comprobante'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String title, String value, {bool isBold = false, Color? amountColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              fontSize: isBold ? 16 : 13,
              color: amountColor ?? AppColors.textMain,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeChild = _store.activeChild;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movimientos Pupilo',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              context.go('/parent-home');
            }
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              onTap: () => context.push('/parent-profile'),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey[200],
                child: const Icon(Icons.person, color: AppColors.primaryBlue),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Children Selector Header
                const Text(
                  'Seleccionar Pupilo',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain,
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  child: Row(
                    children: List.generate(_store.children.length, (index) {
                      final isSelected = index == _store.selectedChildIndex;
                      final child = _store.children[index];
                      return GestureDetector(
                        onTap: () {
                          _store.setSelectedChildIndex(index);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primaryBlue : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected ? AppColors.primaryBlue : AppColors.border,
                              width: 2,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: AppColors.primaryBlue.withOpacity(0.25),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    )
                                  ]
                                : [],
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundImage: AssetImage(child.image),
                                backgroundColor: Colors.grey[300],
                              ),
                              const SizedBox(width: 8),
                              Text(
                                child.name,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : AppColors.textMain,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 16),

                // KPI Overview cards per child
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFBFDBFE)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Saldo TNE',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1E40AF)),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              activeChild.formattedTneBalance,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF1E3A8A)),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${activeChild.tneMovements.length} movs registrados',
                              style: const TextStyle(fontSize: 10, color: Color(0xFF3B82F6)),
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
                          border: Border.all(color: const Color(0xFFA7F3D0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Saldo BAES',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF065F46)),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              activeChild.formattedBaesBalance,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF047857)),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Alimentación activa',
                              style: const TextStyle(fontSize: 10, color: Color(0xFF10B981)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Tab Bar
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: AppColors.primaryBlue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: AppColors.textSecondary,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    tabs: const [
                      Tab(text: 'Transporte (TNE)'),
                      Tab(text: 'Alimentación (BAES/PAE)'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Movements Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // TNE Movements
                _buildMovementsList(activeChild.tneMovements, activeChild),
                // BAES Movements
                _buildMovementsList(activeChild.baesMovements, activeChild),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const _ParentBottomNav(currentIndex: 2),
    );
  }

  Widget _buildMovementsList(List<ChildMovement> movements, ChildProfile activeChild) {
    if (movements.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 12),
            const Text(
              'No hay movimientos registrados para este pupilo.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: movements.length,
      itemBuilder: (context, index) {
        final movement = movements[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () => _showMovementDetail(movement, activeChild),
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
                    radius: 20,
                    backgroundColor: movement.isCredit ? Colors.green.shade50 : AppColors.primaryBlue.withOpacity(0.08),
                    child: Icon(
                      movement.icon,
                      color: movement.isCredit ? Colors.green.shade700 : AppColors.primaryBlue,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movement.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppColors.textMain,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${movement.location} • ${movement.date}',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        movement.amount,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          color: movement.isCredit ? Colors.green.shade700 : AppColors.textMain,
                        ),
                      ),
                      if (movement.status != null)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            movement.status!,
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade800,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ParentBottomNav extends StatelessWidget {
  final int currentIndex;
  const _ParentBottomNav({required this.currentIndex});

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
          _NavItem(
            icon: Icons.home_filled,
            label: 'Inicio',
            isActive: currentIndex == 0,
            onTap: () => context.go('/parent-home'),
          ),
          _NavItem(
            icon: Icons.payment,
            label: 'Recarga TNE',
            isActive: currentIndex == 1,
            onTap: () => context.go('/parent-recharge'),
          ),
          _NavItem(
            icon: Icons.list_alt,
            label: 'Movimientos',
            isActive: currentIndex == 2,
            onTap: () => context.go('/parent-movements'),
          ),
          _NavItem(
            icon: Icons.school,
            label: 'Becas',
            isActive: currentIndex == 3,
            onTap: () => context.go('/parent-scholarships'),
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

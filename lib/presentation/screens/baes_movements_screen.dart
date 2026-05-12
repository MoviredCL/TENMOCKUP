import 'package:flutter/material.dart';
import 'package:tneapp/config/constants/colores.dart';

class BaesMovementsScreen extends StatefulWidget {
  const BaesMovementsScreen({super.key});

  @override
  State<BaesMovementsScreen> createState() => _BaesMovementsScreenState();
}

class _BaesMovementsScreenState extends State<BaesMovementsScreen> {
  String selectedFilter = 'Todos';
  final List<String> filters = ['Todos', 'Supermercados', 'Casinos', 'Restaurantes'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movimientos BAES'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Chips
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  final isSelected = selectedFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(filter),
                      selected: isSelected,
                      onSelected: (val) => setState(() => selectedFilter = filter),
                      selectedColor: AppColors.primaryBlue.withOpacity(0.1),
                      labelStyle: TextStyle(
                        color: isSelected ? AppColors.primaryBlue : AppColors.textSecondary,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      side: BorderSide(color: isSelected ? AppColors.primaryBlue : AppColors.border),
                      showCheckmark: false,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // BAES Balance Chart (Monthly Recharge)
            const Text(
              'Historial de Saldo (Abril - Mayo)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textMain),
            ),
            const SizedBox(height: 12),
            Container(
              height: 240,
              padding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        // Y-Axis Labels
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('48k', style: TextStyle(fontSize: 9, color: AppColors.textTertiary)),
                            Text('30k', style: TextStyle(fontSize: 9, color: AppColors.textTertiary)),
                            Text('15k', style: TextStyle(fontSize: 9, color: AppColors.textTertiary)),
                            Text('0', style: TextStyle(fontSize: 9, color: AppColors.textTertiary)),
                          ],
                        ),
                        const SizedBox(width: 8),
                        // Chart Area
                        Expanded(
                          child: CustomPaint(
                            painter: _BaesChartPainter(),
                            child: Container(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // X-Axis Labels (Two Months)
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('01 Abr', style: TextStyle(fontSize: 9, color: AppColors.textTertiary)),
                        Text('15 Abr', style: TextStyle(fontSize: 9, color: AppColors.textTertiary)),
                        Text('01 May', style: TextStyle(fontSize: 9, color: AppColors.textTertiary)),
                        Text('15 May', style: TextStyle(fontSize: 9, color: AppColors.textTertiary)),
                        Text('Hoy', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ChartLegend(color: Colors.green, label: 'Carga Mensual'),
                SizedBox(width: 24),
                _ChartLegend(color: AppColors.primaryBlue, label: 'Saldo Restante'),
              ],
            ),

            const SizedBox(height: 32),

            // Category Breakdown
            const Text(
              'Distribución de Gasto',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textMain),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _CategoryProgress(label: 'Super', percentage: 0.6, color: Colors.blue),
                _CategoryProgress(label: 'Casino', percentage: 0.25, color: Colors.orange),
                _CategoryProgress(label: 'Otros', percentage: 0.15, color: Colors.grey),
              ],
            ),

            const SizedBox(height: 32),

            // Movements List
            const Text(
              'Últimos Movimientos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textMain),
            ),
            const SizedBox(height: 16),
            _buildMovementList(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMovementList() {
    final List<Map<String, dynamic>> allMovements = [
      {'title': 'Supermercado Lider', 'subtitle': 'Hoy, 14:20 hrs', 'amount': r'-$12.450', 'category': 'Supermercados', 'icon': Icons.shopping_basket_outlined},
      {'title': 'Casino Central', 'subtitle': 'Ayer, 13:15 hrs', 'amount': r'-$3.200', 'category': 'Casinos', 'icon': Icons.restaurant},
      {'title': 'Carga Mensual BAES', 'subtitle': '01 May, 09:00 hrs', 'amount': r'+$48.000', 'category': 'Carga', 'icon': Icons.add_circle_outline, 'isCharge': true},
      {'title': 'Unimarc Express', 'subtitle': '10 May, 18:45 hrs', 'amount': r'-$5.600', 'category': 'Supermercados', 'icon': Icons.shopping_cart_outlined},
      {'title': 'Pizza Hut', 'subtitle': '08 May, 20:30 hrs', 'amount': r'-$8.990', 'category': 'Restaurantes', 'icon': Icons.fastfood_outlined},
    ];

    final filtered = selectedFilter == 'Todos'
        ? allMovements
        : allMovements.where((m) => m['category'] == selectedFilter || m['isCharge'] == true).toList();

    return Column(
      children: filtered.map((m) => _BaesMovementItem(
        title: m['title'],
        subtitle: m['subtitle'],
        amount: m['amount'],
        category: m['category'],
        icon: m['icon'],
        isCharge: m['isCharge'] ?? false,
      )).toList(),
    );
  }
}

class _BaesChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = AppColors.primaryBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final paintRecharge = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    // Grid Lines
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.05)
      ..strokeWidth = 1;
    for (int i = 0; i <= 3; i++) {
      double y = size.height * (i / 3);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // --- MONTH 1 (ABRIL) ---
    // Recharge Peak
    canvas.drawCircle(Offset(0, size.height * 0.1), 4, paintRecharge);
    
    final pathAbril = Path();
    pathAbril.moveTo(0, size.height * 0.1);
    pathAbril.cubicTo(
      size.width * 0.15, size.height * 0.15, 
      size.width * 0.35, size.height * 0.6, 
      size.width * 0.5, size.height * 0.95 // Ends near zero
    );

    // --- MONTH 2 (MAYO) ---
    // Recharge Peak (Step up)
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.1), 4, paintRecharge);
    
    final pathMayo = Path();
    pathMayo.moveTo(size.width * 0.5, size.height * 0.1);
    pathMayo.cubicTo(
      size.width * 0.65, size.height * 0.2, 
      size.width * 0.85, size.height * 0.4, 
      size.width, size.height * 0.45 // Current balance
    );

    canvas.drawPath(pathAbril, paintLine);
    canvas.drawPath(pathMayo, paintLine);
    
    // Fill Area for better visualization
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AppColors.primaryBlue.withOpacity(0.1), Colors.transparent],
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height));
      
    final fillPath = Path.from(pathAbril);
    fillPath.lineTo(size.width * 0.5, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();
    canvas.drawPath(fillPath, fillPaint);

    final fillPath2 = Path.from(pathMayo);
    fillPath2.lineTo(size.width, size.height);
    fillPath2.lineTo(size.width * 0.5, size.height);
    fillPath2.close();
    canvas.drawPath(fillPath2, fillPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _ChartLegend extends StatelessWidget {
  final Color color;
  final String label;
  const _ChartLegend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
      ],
    );
  }
}

class _CategoryProgress extends StatelessWidget {
  final String label;
  final double percentage;
  final Color color;
  const _CategoryProgress({required this.label, required this.percentage, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                value: percentage,
                backgroundColor: color.withOpacity(0.1),
                color: color,
                strokeWidth: 6,
              ),
            ),
            Text('${(percentage * 100).toInt()}%', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
      ],
    );
  }
}

class _BaesMovementItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final String category;
  final IconData icon;
  final bool isCharge;

  const _BaesMovementItem({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.category,
    required this.icon,
    this.isCharge = false,
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
            decoration: BoxDecoration(
              color: isCharge ? Colors.green[50] : Colors.blue[50],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: isCharge ? Colors.green : AppColors.primaryBlue, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: isCharge ? Colors.green[800] : AppColors.textMain,
            ),
          ),
        ],
      ),
    );
  }
}

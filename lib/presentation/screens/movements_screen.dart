import 'package:flutter/material.dart';
import 'package:tneapp/config/constants/colores.dart';

class MovementsScreen extends StatefulWidget {
  const MovementsScreen({super.key});

  @override
  State<MovementsScreen> createState() => _MovementsScreenState();
}

class _MovementsScreenState extends State<MovementsScreen> {
  String selectedFilter = 'Todos';
  final List<String> filters = ['Todos', 'TNE QR', 'Física'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Movimientos'),
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

            // Main Usage Chart (Usage vs Recharge)
            const Text(
              'Uso vs Carga',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textMain),
            ),
            const SizedBox(height: 12),
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOutQuart,
              tween: Tween<double>(begin: 0, end: 1),
              key: ValueKey(selectedFilter),
              builder: (context, value, child) {
                return Container(
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
                                Text('10k', style: TextStyle(fontSize: 9, color: AppColors.textTertiary)),
                                Text('5k', style: TextStyle(fontSize: 9, color: AppColors.textTertiary)),
                                Text('2k', style: TextStyle(fontSize: 9, color: AppColors.textTertiary)),
                                Text('0', style: TextStyle(fontSize: 9, color: AppColors.textTertiary)),
                              ],
                            ),
                            const SizedBox(width: 8),
                            // Chart Area
                            Expanded(
                              child: CustomPaint(
                                painter: _UsageRechargePainter(
                                  filter: selectedFilter,
                                  animationValue: value,
                                ),
                                child: Container(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // X-Axis Labels
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('01 May', style: TextStyle(fontSize: 9, color: AppColors.textTertiary)),
                            Text('08 May', style: TextStyle(fontSize: 9, color: AppColors.textTertiary)),
                            Text('15 May', style: TextStyle(fontSize: 9, color: AppColors.textTertiary)),
                            Text('22 May', style: TextStyle(fontSize: 9, color: AppColors.textTertiary)),
                            Text('30 May', style: TextStyle(fontSize: 9, color: AppColors.textTertiary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ChartLegend(color: AppColors.primaryBlue, label: 'Cargas'),
                const SizedBox(width: 24),
                _ChartLegend(color: Colors.redAccent, label: 'Uso'),
              ],
            ),

            const SizedBox(height: 32),

            // Hourly Usage Stats
            const Text(
              'Horarios de Uso Frecuente',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textMain),
            ),
            const SizedBox(height: 12),
            Container(
              height: 180,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _BarItem(heightFactor: 0.2, label: '06-09'),
                  _BarItem(heightFactor: 0.8, label: '09-13', isHighlight: true),
                  _BarItem(heightFactor: 0.4, label: '13-17'),
                  _BarItem(heightFactor: 0.9, label: '17-20', isHighlight: true),
                  _BarItem(heightFactor: 0.3, label: '20-00'),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Movements List
            const Text(
              'Movimientos del Mes',
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
      {'title': 'Viaje Bus', 'subtitle': 'Hoy, 08:30 hrs', 'amount': r'-$260', 'method': 'TNE QR', 'isCharge': false},
      {'title': 'Viaje Metro', 'subtitle': 'Ayer, 18:15 hrs', 'amount': r'-$260', 'method': 'Física', 'isCharge': false},
      {'title': 'Carga Web', 'subtitle': '12 May, 10:00 hrs', 'amount': r'+$5.000', 'method': 'Movired', 'isCharge': true},
      {'title': 'Viaje Bus', 'subtitle': '11 May, 09:12 hrs', 'amount': r'-$260', 'method': 'TNE QR', 'isCharge': false},
      {'title': 'Viaje Metro', 'subtitle': '10 May, 13:20 hrs', 'amount': r'-$260', 'method': 'TNE QR', 'isCharge': false},
      {'title': 'Viaje Bus', 'subtitle': '09 May, 17:45 hrs', 'amount': r'-$260', 'method': 'Física', 'isCharge': false},
    ];

    final filtered = selectedFilter == 'Todos'
        ? allMovements
        : allMovements.where((m) => m['method'] == selectedFilter || m['isCharge'] == true).toList();

    return Column(
      children: filtered.map((m) => _MovementItem(
        title: m['title'],
        subtitle: m['subtitle'],
        amount: m['amount'],
        method: m['method'],
        isCharge: m['isCharge'],
      )).toList(),
    );
  }
}

class _UsageRechargePainter extends CustomPainter {
  final String filter;
  final double animationValue;

  _UsageRechargePainter({required this.filter, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paintRecharge = Paint()
      ..color = AppColors.primaryBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final paintUsage = Paint()
      ..color = Colors.redAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Grid Lines
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.05)
      ..strokeWidth = 1;
    for (int i = 0; i <= 3; i++) {
      double y = size.height * (i / 3);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Define data points based on filter
    double rechargePeak1 = 0.1;
    double rechargePeak2 = 0.2;
    double usagePeak1 = 0.85;
    double usagePeak2 = 0.65;

    if (filter == 'TNE QR') {
      rechargePeak1 = 0.3; // Lower recharges
      rechargePeak2 = 0.4;
      usagePeak1 = 0.95; // Less usage
      usagePeak2 = 0.8;
    } else if (filter == 'Física') {
      rechargePeak1 = 0.05; // High single recharge
      rechargePeak2 = 0.6;
      usagePeak1 = 0.75; // Heavy usage
      usagePeak2 = 0.5;
    }

    // Animate points (Interpolate from a base state)
    double curRechargePeak1 = (rechargePeak1 * animationValue) + (0.2 * (1 - animationValue));
    double curUsagePeak1 = (usagePeak1 * animationValue) + (0.8 * (1 - animationValue));

    // Recharge Path (Smooth)
    final pathRecharge = Path();
    pathRecharge.moveTo(0, size.height * 0.9);
    
    pathRecharge.cubicTo(
      size.width * 0.2, size.height * 0.9, 
      size.width * 0.3, size.height * curRechargePeak1, 
      size.width * 0.5, size.height * 0.4
    );
    pathRecharge.cubicTo(
      size.width * 0.7, size.height * 0.7, 
      size.width * 0.8, size.height * rechargePeak2, 
      size.width, size.height * 0.5
    );

    // Usage Path (Smooth)
    final pathUsage = Path();
    pathUsage.moveTo(0, size.height * 0.8);
    
    pathUsage.cubicTo(
      size.width * 0.25, size.height * 0.75, 
      size.width * 0.5, size.height * curUsagePeak1, 
      size.width * 0.75, size.height * 0.7
    );
    pathUsage.cubicTo(
      size.width * 0.85, size.height * usagePeak2, 
      size.width * 0.95, size.height * 0.65, 
      size.width, size.height * 0.6
    );

    canvas.drawPath(pathRecharge, paintRecharge);
    canvas.drawPath(pathUsage, paintUsage);
    
    // Fill Usage Area
    final fillUsage = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.redAccent.withOpacity(0.1 * animationValue), Colors.transparent],
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height));
      
    final fillPath = Path.from(pathUsage);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();
    canvas.drawPath(fillPath, fillUsage);
  }

  @override
  bool shouldRepaint(_UsageRechargePainter oldDelegate) => 
    oldDelegate.filter != filter || oldDelegate.animationValue != animationValue;
}

class _ChartLegend extends StatelessWidget {
  final Color color;
  final String label;
  const _ChartLegend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }
}

class _BarItem extends StatelessWidget {
  final double heightFactor;
  final String label;
  final bool isHighlight;
  const _BarItem({required this.heightFactor, required this.label, this.isHighlight = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 32,
          height: 120 * heightFactor,
          decoration: BoxDecoration(
            color: isHighlight ? AppColors.primaryBlue : AppColors.primaryBlue.withOpacity(0.2),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
      ],
    );
  }
}

class _MovementItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final String method;
  final bool isCharge;

  const _MovementItem({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.method,
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
              color: isCharge ? Colors.blue[50] : Colors.red[50],
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCharge ? Icons.account_balance_wallet : Icons.directions_bus,
              color: isCharge ? Colors.blue : Colors.red,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: method == 'TNE QR' ? Colors.blue[50] : (method == 'Física' ? Colors.orange[50] : Colors.grey[100]),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        method,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: method == 'TNE QR' ? Colors.blue[700] : (method == 'Física' ? Colors.orange[800] : Colors.grey[600]),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: isCharge ? Colors.blue[800] : Colors.red[800],
            ),
          ),
        ],
      ),
    );
  }
}

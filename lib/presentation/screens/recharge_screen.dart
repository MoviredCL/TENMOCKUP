import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tneapp/config/constants/colores.dart';

class RechargeScreen extends StatefulWidget {
  final bool isPhysical;
  const RechargeScreen({super.key, this.isPhysical = false});

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  String selectedAmount = r'$ 5.000';
  final List<String> amounts = [r'$ 2.000', r'$ 5.000', r'$ 10.000', r'$ 20.000'];

  @override
  Widget build(BuildContext context) {
    final String initialBalance = widget.isPhysical ? r'$ 1.000' : r'$ 4.500';
    final String cardType = widget.isPhysical ? 'Tarjeta Física' : 'Pase Digital';
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Cargar $cardType'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              onTap: () => context.push('/profile'),
              child: const CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('assets/images/user_profile.png'),
                backgroundColor: AppColors.background,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Balance Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.isPhysical 
                    ? [const Color(0xFF475569), const Color(0xFF1E293B)] // Grey/Slate for physical
                    : [const Color(0xFF2E58A6), const Color(0xFF1E3A8A)], // Blue for digital
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: (widget.isPhysical ? Colors.black : AppColors.primaryBlue).withOpacity(0.2),
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
                      const Text('Saldo Actual', style: TextStyle(color: Colors.white70, fontSize: 16)),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                        child: Icon(
                          widget.isPhysical ? Icons.credit_card : Icons.qr_code_2_rounded, 
                          color: Colors.white, 
                          size: 24
                        ),
                      ),
                    ],
                  ),
                  Text(
                    initialBalance,
                    style: const TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    children: [
                      Icon(Icons.history, color: Colors.white70, size: 16),
                      SizedBox(width: 8),
                      Text('Actualizado hoy, 09:41 hrs', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),

            // Warning for Physical Card Activation
            if (widget.isPhysical)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.tertiaryYellow.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.tertiaryYellow.withOpacity(0.3)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline_rounded, color: AppColors.tertiaryYellow),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Importante: El saldo cargado en tu tarjeta física debe ser activado en un tótem Infobip antes de ser usado.',
                        style: TextStyle(
                          fontSize: 13, 
                          color: Color(0xFF856404),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 24),
            
            const Text(
              'SELECCIONA EL MONTO A CARGAR',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textSecondary, letterSpacing: 1.1),
            ),
            const SizedBox(height: 16),
            
            // Amount Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2.2,
              ),
              itemCount: amounts.length,
              itemBuilder: (context, index) {
                final amount = amounts[index];
                final isSelected = selectedAmount == amount;
                return InkWell(
                  onTap: () => setState(() => selectedAmount = amount),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryBlue : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: isSelected ? AppColors.primaryBlue : AppColors.border),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            amount,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: isSelected ? Colors.white : AppColors.textMain,
                            ),
                          ),
                        ),
                        if (isSelected)
                          const Positioned(
                            top: 8,
                            right: 8,
                            child: Icon(Icons.check_circle, color: Colors.white, size: 20),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Custom Amount Button
            Container(
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border, style: BorderStyle.solid),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit_outlined, size: 20, color: AppColors.textSecondary),
                  SizedBox(width: 12),
                  Text('Otro monto', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Payment Methods
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Medios de pago disponibles', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                  const SizedBox(height: 12),
                  const Row(
                    children: [
                      Icon(Icons.account_balance_wallet, color: AppColors.primaryBlue),
                      SizedBox(width: 12),
                      Text('Movired', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textMain)),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            ElevatedButton(
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Continuar al pago'),
                  SizedBox(width: 12),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: _CustomBottomNav(),
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
          _NavItem(icon: Icons.qr_code_scanner, label: 'TNE', isActive: true, onTap: () => context.go('/tne-module')),
          _NavItem(icon: Icons.restaurant_menu, label: 'BAES', isActive: false, onTap: () => context.go('/baes-qr')),
          _NavItem(icon: Icons.school, label: 'Becas', isActive: false, onTap: () => context.go('/applications')),
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

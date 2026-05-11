import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tneapp/config/constants/colores.dart';
import 'package:tneapp/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:tneapp/presentation/views/views.dart';

class EnrolarTarjetaScreen extends StatefulWidget {
  const EnrolarTarjetaScreen({super.key});

  @override
  State<EnrolarTarjetaScreen> createState() => _EnrolarTarjetaScreenState();
}

class _EnrolarTarjetaScreenState extends State<EnrolarTarjetaScreen> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();

  @override
  void dispose() {
    nombreController.dispose();
    numeroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(primaryColor),
      appBar: AppBarCustom(),
      body: BodyCustom(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(Icons.arrow_back_ios_new_rounded, color: Color(neutralTextColor)),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 24),
              Text(
                "Enrolar Tarjeta TNE",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Outfit',
                  color: Color(neutralTextColor),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Vincula tu tarjeta física para gestionarla desde la app",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(neutralTextColor).withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 40),
              
              _buildTextField(
                label: "Nombre o Alias",
                hint: "Ej: Mi TNE, TNE de Emma",
                controller: nombreController,
                icon: Icons.label_outline_rounded,
              ),
              const SizedBox(height: 24),
              _buildTextField(
                label: "Número de Tarjeta",
                hint: "Ingresa los 10 dígitos traseros",
                controller: numeroController,
                icon: Icons.credit_card_rounded,
                keyboardType: TextInputType.number,
              ),
              
              const SizedBox(height: 48),
              
              FilledButton(
                onPressed: () {
                  if (nombreController.text.isNotEmpty && numeroController.text.isNotEmpty) {
                    context.read<AppBloc>().add(EnrolarTarjeta(
                      nombre: nombreController.text,
                      numero: numeroController.text,
                    ));
                    context.pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Tarjeta enrolada con éxito"),
                        backgroundColor: Color(primaryColor),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Color(primaryColor),
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text(
                  "Enrolar mi tarjeta",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ),
              
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline_rounded, color: Colors.amber.shade800),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        "Una vez enrolada, podrás cargar saldo y ver tus movimientos en tiempo real.",
                        style: TextStyle(color: Colors.amber.shade900, fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            prefixIcon: Icon(icon, color: Color(primaryColor).withOpacity(0.5)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Color(primaryColor), width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

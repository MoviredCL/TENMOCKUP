import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tneapp/config/constants/colores.dart';
import 'package:tneapp/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:tneapp/presentation/views/views.dart';

class HistorialViajesScreen extends StatelessWidget {
  const HistorialViajesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(primaryColor),
      appBar: AppBarCustom(),
      body: BodyCustom(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Movimientos",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 28,
                      fontFamily: 'Outfit',
                      color: Color(neutralTextColor),
                    ),
                  ),
                  _buildHeaderButton(
                    imagePath: "assets/images/boton_icono.png",
                    onPressed: () => context.read<AppBloc>().add(MostrarNotificaciones(estado: true)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Historial detallado de tu cuenta",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(neutralTextColor).withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildMovementTile(
                      title: "Paradero Sta. Camila",
                      subtitle: "Bus LHJK33",
                      amount: -250,
                      icon: Icons.directions_bus_rounded,
                      date: "Hoy, 07:45 hrs",
                    ),
                    const SizedBox(height: 16),
                    _buildMovementTile(
                      title: "Paradero San Luca",
                      subtitle: "Bus KRZZ10",
                      amount: -250,
                      icon: Icons.directions_bus_rounded,
                      date: "Hoy, 06:36 hrs",
                    ),
                    const SizedBox(height: 16),
                    _buildMovementTile(
                      title: "Carga de Saldo",
                      subtitle: "Webpay Plus",
                      amount: 20000,
                      icon: Icons.add_card_rounded,
                      date: "Ayer, 22:00 hrs",
                      isCarga: true,
                    ),
                    const SizedBox(height: 16),
                    _buildMovementTile(
                      title: "Estación El Golf",
                      subtitle: "Línea 1",
                      amount: -250,
                      icon: Icons.subway_rounded,
                      date: "Sábado 19 de abril, 14:02 hrs",
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderButton({required String imagePath, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Center(child: Image.asset(imagePath, scale: 1.5)),
      ),
    );
  }

  Widget _buildMovementTile({
    required String title,
    required String subtitle,
    required int amount,
    required IconData icon,
    required String date,
    bool isCarga = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isCarga ? Color(successColor).withOpacity(0.1) : Color(primaryColor).withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: isCarga ? Color(successColor) : Color(primaryColor), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Color(neutralTextColor)),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 13, color: Color(neutralTextColor).withOpacity(0.5)),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(fontSize: 12, color: Color(neutralTextColor).withOpacity(0.4), fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Text(
            "${amount > 0 ? "+" : ""}\$${formatearMiles(amount.abs())}",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 17,
              fontFamily: 'Outfit',
              color: isCarga ? Color(successColor) : Color(redColor),
            ),
          ),
        ],
      ),
    );
  }

  String formatearMiles(int numero) {
    String numeroStr = numero.toString();
    String resultado = '';
    int contador = 0;
    for (int i = numeroStr.length - 1; i >= 0; i--) {
      resultado = numeroStr[i] + resultado;
      contador++;
      if (contador % 3 == 0 && i != 0) {
        resultado = '.$resultado';
      }
    }
    return resultado;
  }
}

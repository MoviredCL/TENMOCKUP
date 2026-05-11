import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tneapp/config/constants/colores.dart';
import 'package:tneapp/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificacionView extends StatelessWidget {
  const NotificacionView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.7;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        context.read<AppBloc>().add(const MostrarNotificaciones(estado: false));
      },
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: Color(primaryColor),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Image.asset("assets/images/appbar.png", width: imageWidth),
                  ),
                ),

                // Content
                Expanded(
                  child: Container(
                    color: Color(primaryColor),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                        color: Color(neutralBgColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildCircleButton(
                                  icon: Icons.close_rounded,
                                  onPressed: () {
                                    context.read<AppBloc>().add(const MostrarNotificaciones(estado: false));
                                    Navigator.pop(context);
                                  },
                                ),
                                const Text(
                                  "Notificaciones",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, fontFamily: 'Outfit'),
                                ),
                                const SizedBox(width: 48), // Spacer
                              ],
                            ),
                            const SizedBox(height: 40),
                            const Text(
                              "Mensajes Recientes",
                              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24, fontFamily: 'Outfit'),
                            ),
                            const SizedBox(height: 24),
                            _buildNotificacionItem(
                              icon: Icons.info_outline_rounded,
                              text: "No olvides revalidar tu tarjeta para el 2025. Conoce donde hacerlo aquí.",
                              onTap: () {},
                            ),
                            const SizedBox(height: 16),
                            _buildNotificacionItem(
                              icon: Icons.menu_book_rounded,
                              text: "Descarga aquí el Decálogo de la Seguridad Vial.",
                              url: "https://www.junaeb.cl/wp-content/uploads/2024/02/Decalogo-seguridad-vial-Conaset-y-Junaeb.pdf",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCircleButton({required IconData icon, required VoidCallback onPressed}) {
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
        child: Icon(icon, color: Color(primaryColor), size: 24),
      ),
    );
  }

  Widget _buildNotificacionItem({required IconData icon, required String text, String? url, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: url != null
          ? () async {
              try {
                final Uri uri = Uri.parse(url);
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              } catch (e) {
                debugPrint(e.toString());
              }
            }
          : onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 5)),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(primaryColor).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Color(primaryColor), size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, height: 1.4),
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class StudentQrDialog extends StatelessWidget {
  final String nombre;
  final String rut;
  final String codigoQr;
  final String? qrImagePath;
  final String confirmText;
  final VoidCallback? onConfirm;

  const StudentQrDialog({
    super.key,
    this.nombre = 'Camila Fuentes Díaz',
    this.rut = '33333333-3',
    this.codigoQr = 'PGQP4XYU',
    this.qrImagePath = 'assets/images/qr.png',
    this.confirmText = 'Imprimir',
    this.onConfirm,
  });

  static Future<void> show(
    BuildContext context, {
    String nombre = 'Camila Fuentes Díaz',
    String rut = '33333333-3',
    String codigoQr = 'PGQP4XYU',
    String? qrImagePath = 'assets/images/qr.png',
    String confirmText = 'Imprimir',
    VoidCallback? onConfirm,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StudentQrDialog(
          nombre: nombre,
          rut: rut,
          codigoQr: codigoQr,
          qrImagePath: qrImagePath,
          confirmText: confirmText,
          onConfirm: onConfirm,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 6,
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
        constraints: const BoxConstraints(maxWidth: 340),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Student Name
              Text(
                nombre,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 4),

              // Student RUT
              Text(
                rut,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[500],
                ),
              ),
              const SizedBox(height: 20),

              // QR Code Image
              GestureDetector(
                onTap: () {
                  if (onConfirm != null) {
                    Navigator.of(context).pop();
                    onConfirm!();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    qrImagePath ?? 'assets/images/qr.png',
                    height: 180,
                    width: 180,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Code Text
              Text(
                codigoQr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3.0,
                  color: Color(0xFF475569),
                ),
              ),
              const SizedBox(height: 10),

              // Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  'Este código identifica al alumno al escanearlo en la app de entrega.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[500],
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Actions Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      foregroundColor: Colors.grey[700],
                    ),
                    child: const Text(
                      'Cerrar',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final messenger = ScaffoldMessenger.maybeOf(context);
                      Navigator.of(context).pop();
                      if (onConfirm != null) {
                        onConfirm!();
                      } else {
                        messenger?.showSnackBar(
                          SnackBar(
                            content: const Text('Enviando a imprimir código QR...'),
                            backgroundColor: const Color(0xFF6B21A8),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6B21A8),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      confirmText,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
  }
}

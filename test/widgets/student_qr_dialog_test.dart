import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tneapp/presentation/widgets/student_qr_dialog.dart';

void main() {
  testWidgets('StudentQrDialog renders student info, QR code, and buttons correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: StudentQrDialog(
            nombre: 'Camila Fuentes Díaz',
            rut: '33333333-3',
            codigoQr: 'PGQP4XYU',
          ),
        ),
      ),
    );

    expect(find.text('Camila Fuentes Díaz'), findsOneWidget);
    expect(find.text('33333333-3'), findsOneWidget);
    expect(find.text('PGQP4XYU'), findsOneWidget);
    expect(find.text('Este código identifica al alumno al escanearlo en la app de entrega.'), findsOneWidget);
    expect(find.text('Cerrar'), findsOneWidget);
    expect(find.text('Imprimir'), findsOneWidget);
  });
}

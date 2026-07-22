import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tneapp/services/api_config.dart';
import 'package:tneapp/services/simulated_http_client.dart';
import 'package:tneapp/services/auth_service.dart';
import 'package:tneapp/services/beneficios_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({
      'establishment_access_token': 'fake_token',
    });
    ApiConfig.isSimulationMode = true;
  });

  test('SimulatedHttpClient intercepts /api/auth/login and returns simulated token and user', () async {
    final authService = AuthService();
    final response = await authService.login('encargado@escuela.cl', '123456');

    expect(response.accessToken, isNotEmpty);
    expect(response.user.email, isNotEmpty);
    expect(response.user.establecimiento, isNotNull);
  });

  test('SimulatedHttpClient intercepts /api/beneficios and returns areas', () async {
    final beneficiosService = BeneficiosService();
    final areas = await beneficiosService.getBeneficios();

    expect(areas, isNotEmpty);
    expect(areas.first.beneficios, isNotEmpty);
  });

  test('SimulatedHttpClient intercepts /api/alumnos and returns search results', () async {
    final beneficiosService = BeneficiosService();
    final alumnos = await beneficiosService.searchAlumnos('ana');

    // Responses in simulaciones.json have 3 options (one with 1 student, one with 2, one empty)
    expect(alumnos, isA<List>());
  });

  test('SimulatedHttpClient intercepts POST /api/beneficios/entrega and returns 201 response', () async {
    final beneficiosService = BeneficiosService();
    final entrega = await beneficiosService.registrarEntrega(
      beneficioId: 1,
      alumnoRut: '11111111-1',
    );

    expect(entrega.id, greaterThan(0));
    expect(entrega.beneficio, isNotNull);
    expect(entrega.alumno, isNotNull);
  });
}

import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'api_config.dart';

/// Cliente HTTP que intercepta peticiones cuando [ApiConfig.isSimulationMode] es true,
/// devolviendo respuestas aleatorias registradas en `assets/simulaciones.json`.
class SimulatedHttpClient extends http.BaseClient {
  final http.Client _innerClient;
  Map<String, dynamic>? _simulationsData;
  final Random _random = Random();

  /// Instancia global compartida para usar en toda la aplicación.
  static final SimulatedHttpClient instance = SimulatedHttpClient();

  SimulatedHttpClient({http.Client? innerClient})
      : _innerClient = innerClient ?? http.Client();

  Future<void> _loadSimulations() async {
    if (_simulationsData != null) return;
    try {
      final jsonString = await rootBundle.loadString('assets/simulaciones.json');
      _simulationsData = jsonDecode(jsonString) as Map<String, dynamic>;
      debugPrint('[ModoSimulacion] assets/simulaciones.json cargado exitosamente.');
    } catch (e) {
      debugPrint('[ModoSimulacion] Error al cargar assets/simulaciones.json: $e');
    }
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (!ApiConfig.isSimulationMode) {
      return _innerClient.send(request);
    }

    await _loadSimulations();

    final path = request.url.path;
    final method = request.method.toUpperCase();

    debugPrint('[ModoSimulacion] Interceptando request: $method $path');

    if (_simulationsData != null && _simulationsData!['endpoints'] is List) {
      final endpoints = _simulationsData!['endpoints'] as List;
      for (final ep in endpoints) {
        final epMethod = (ep['method'] as String? ?? '').toUpperCase();
        final epUrl = ep['url'] as String? ?? '';

        if (epMethod == method && epUrl == path) {
          final responses = ep['responses'] as List? ?? [];
          if (responses.isNotEmpty) {
            final selectedIndex = _random.nextInt(responses.length);
            final selectedBody = responses[selectedIndex];
            final responseString = jsonEncode(selectedBody);

            int statusCode = 200;
            if (method == 'POST' && (path == '/api/alumnos' || path == '/api/beneficios/entrega')) {
              statusCode = 201;
            }

            debugPrint('[ModoSimulacion] Match para $method $path -> Respuesta #${selectedIndex + 1} (Status $statusCode)');

            // Simular retardo breve de red (200ms) para respuesta realista
            await Future.delayed(const Duration(milliseconds: 200));

            final bodyBytes = utf8.encode(responseString);
            return http.StreamedResponse(
              Stream.value(bodyBytes),
              statusCode,
              headers: {'content-type': 'application/json; charset=utf-8'},
              contentLength: bodyBytes.length,
              request: request,
            );
          }
        }
      }
    }

    debugPrint('[ModoSimulacion] Endpoint $method $path no hallado en simulaciones.json. Ejecutando llamado real.');
    return _innerClient.send(request);
  }
}

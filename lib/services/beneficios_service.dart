import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/beneficio.dart';
import '../models/alumno.dart';
import '../models/entrega.dart';
import '../models/api_exception.dart';
import 'api_config.dart';
import 'auth_service.dart';

class BeneficiosService {
  final AuthService _authService = AuthService();

  Future<Map<String, String>> _getHeaders() async {
    final token = await _authService.getToken();
    if (token == null) {
      throw ApiException(statusCode: 401, message: 'Sesión no iniciada.');
    }
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<BeneficioArea>> getBeneficios() async {
    final headers = await _getHeaders();
    final url = Uri.parse('${ApiConfig.baseUrl}/beneficios');

    final response = await http.get(url, headers: headers);
    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final areasJson = body['areas'] as List? ?? [];
      return areasJson
          .map((a) => BeneficioArea.fromJson(a as Map<String, dynamic>))
          .toList();
    } else {
      throw ApiException(
        statusCode: response.statusCode,
        message: body['message'] ?? 'Error al obtener la lista de beneficios.',
      );
    }
  }

  Future<List<Alumno>> searchAlumnos(String query) async {
    final headers = await _getHeaders();
    final url = Uri.parse('${ApiConfig.baseUrl}/alumnos?q=${Uri.encodeComponent(query)}');

    final response = await http.get(url, headers: headers);
    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final list = body as List? ?? [];
      return list.map((a) => Alumno.fromJson(a as Map<String, dynamic>)).toList();
    } else {
      throw ApiException(
        statusCode: response.statusCode,
        message: body['message'] ?? 'Error al buscar alumnos.',
      );
    }
  }

  Future<Alumno> registrarAlumnoManual({
    required String rut,
    required String nombre,
    String? nacimiento,
    String? curso,
  }) async {
    final headers = await _getHeaders();
    final url = Uri.parse('${ApiConfig.baseUrl}/alumnos');

    final payload = <String, dynamic>{
      'rut': rut.trim(),
      'nombre': nombre.trim(),
      if (nacimiento != null && nacimiento.isNotEmpty) 'nacimiento': nacimiento.trim(),
      if (curso != null && curso.isNotEmpty) 'curso': curso.trim(),
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(payload),
    );

    final body = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return Alumno.fromJson(body as Map<String, dynamic>);
    } else if (response.statusCode == 422) {
      // If student already exists, API returns {"message": "...", "alumno": {...}}
      if (body['alumno'] != null) {
        return Alumno.fromJson(body['alumno'] as Map<String, dynamic>);
      }
      final message = body['message'] ?? 'Error de validación al registrar alumno.';
      final errors = body['errors'] as Map<String, dynamic>?;
      throw ApiException(
        statusCode: 422,
        message: message,
        errors: errors,
      );
    } else {
      throw ApiException(
        statusCode: response.statusCode,
        message: body['message'] ?? 'Error al registrar el alumno.',
      );
    }
  }

  Future<EntregaResponse> registrarEntrega({
    required int beneficioId,
    required String alumnoRut,
    String? codigo,
  }) async {
    final headers = await _getHeaders();
    final url = Uri.parse('${ApiConfig.baseUrl}/beneficios/entrega');

    final request = EntregaRequest(
      beneficioId: beneficioId,
      alumnoRut: alumnoRut,
      codigo: codigo,
    );

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(request.toJson()),
    );

    final body = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return EntregaResponse.fromJson(body as Map<String, dynamic>);
    } else {
      final message = body['message'] ?? 'Error al registrar la entrega del beneficio.';
      final errors = body['errors'] as Map<String, dynamic>?;
      throw ApiException(
        statusCode: response.statusCode,
        message: message,
        errors: errors,
      );
    }
  }
}

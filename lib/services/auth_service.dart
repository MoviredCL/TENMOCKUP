import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth_user.dart';
import '../models/api_exception.dart';
import 'api_config.dart';

class AuthService {
  static const String _tokenKey = 'establishment_access_token';
  static const String _userKey = 'establishment_user_json';

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> saveSession(AuthResponse authResponse) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, authResponse.accessToken);
    await prefs.setString(_userKey, jsonEncode(authResponse.user.toJson()));
  }

  Future<AuthUser?> getSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userStr = prefs.getString(_userKey);
    if (userStr == null) return null;
    try {
      return AuthUser.fromJson(jsonDecode(userStr));
    } catch (_) {
      return null;
    }
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }

  Future<AuthResponse> login(String email, String password) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email.trim(),
          'password': password,
        }),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final authResp = AuthResponse.fromJson(body);
        await saveSession(authResp);
        return authResp;
      } else {
        final message = body['message'] ?? 'Error en el inicio de sesión.';
        final errors = body['errors'] as Map<String, dynamic>?;
        throw ApiException(
          statusCode: response.statusCode,
          message: message,
          errors: errors,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        statusCode: 500,
        message: 'No se pudo conectar con el servidor (${ApiConfig.baseUrl}). Revisa la conexión de red.',
      );
    }
  }

  Future<AuthUser?> getMe() async {
    final token = await getToken();
    if (token == null) return null;

    final url = Uri.parse('${ApiConfig.baseUrl}/auth/me');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final user = AuthUser.fromJson(body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_userKey, jsonEncode(user.toJson()));
        return user;
      } else {
        await clearSession();
        return null;
      }
    } catch (_) {
      // Fallback to local saved user if network is temporarily unreachable
      return getSavedUser();
    }
  }

  Future<void> logout() async {
    final token = await getToken();
    if (token != null) {
      final url = Uri.parse('${ApiConfig.baseUrl}/auth/logout');
      try {
        await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
      } catch (_) {}
    }
    await clearSession();
  }
}

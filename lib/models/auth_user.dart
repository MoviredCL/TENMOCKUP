import 'establecimiento.dart';

class AuthUser {
  final int id;
  final int establecimientoId;
  final String name;
  final String email;
  final String rol;
  final bool activo;
  final Establecimiento? establecimiento;

  AuthUser({
    required this.id,
    required this.establecimientoId,
    required this.name,
    required this.email,
    required this.rol,
    required this.activo,
    this.establecimiento,
  });

  bool get isEncargadoOrOperario => rol == 'encargado' || rol == 'operario';
  bool get isAdministrador => rol == 'administrador';

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id'] as int,
      establecimientoId: json['establecimiento_id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      rol: json['rol'] as String? ?? 'operario',
      activo: json['activo'] as bool? ?? true,
      establecimiento: json['establecimiento'] != null
          ? Establecimiento.fromJson(json['establecimiento'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'establecimiento_id': establecimientoId,
        'name': name,
        'email': email,
        'rol': rol,
        'activo': activo,
        if (establecimiento != null) 'establecimiento': establecimiento!.toJson(),
      };
}

class AuthResponse {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final AuthUser user;

  AuthResponse({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String? ?? 'bearer',
      expiresIn: json['expires_in'] as int? ?? 28800,
      user: AuthUser.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

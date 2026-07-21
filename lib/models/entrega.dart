import 'beneficio.dart';
import 'alumno.dart';

class EntregaRequest {
  final int beneficioId;
  final String? codigo;
  final String alumnoRut;

  EntregaRequest({
    required this.beneficioId,
    this.codigo,
    required this.alumnoRut,
  });

  Map<String, dynamic> toJson() => {
        'beneficio': beneficioId,
        if (codigo != null && codigo!.isNotEmpty) 'codigo': codigo,
        'alumno': alumnoRut,
      };
}

class EntregaResponse {
  final int id;
  final int establecimientoId;
  final int beneficioId;
  final int alumnoId;
  final int userId;
  final String? codigo;
  final String createdAt;
  final Beneficio? beneficio;
  final Alumno? alumno;

  EntregaResponse({
    required this.id,
    required this.establecimientoId,
    required this.beneficioId,
    required this.alumnoId,
    required this.userId,
    this.codigo,
    required this.createdAt,
    this.beneficio,
    this.alumno,
  });

  factory EntregaResponse.fromJson(Map<String, dynamic> json) {
    return EntregaResponse(
      id: json['id'] as int,
      establecimientoId: json['establecimiento_id'] as int? ?? 0,
      beneficioId: json['beneficio_id'] as int? ?? 0,
      alumnoId: json['alumno_id'] as int? ?? 0,
      userId: json['user_id'] as int? ?? 0,
      codigo: json['codigo'] as String?,
      createdAt: json['created_at'] as String? ?? '',
      beneficio: json['beneficio'] != null
          ? Beneficio.fromJson(json['beneficio'] as Map<String, dynamic>)
          : null,
      alumno: json['alumno'] != null
          ? Alumno.fromJson(json['alumno'] as Map<String, dynamic>)
          : null,
    );
  }
}

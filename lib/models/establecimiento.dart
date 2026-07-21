class Establecimiento {
  final int id;
  final String nombre;
  final String rut;
  final bool activo;

  Establecimiento({
    required this.id,
    required this.nombre,
    required this.rut,
    required this.activo,
  });

  factory Establecimiento.fromJson(Map<String, dynamic> json) {
    return Establecimiento(
      id: json['id'] as int,
      nombre: json['nombre'] as String? ?? '',
      rut: json['rut'] as String? ?? '',
      activo: json['activo'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'rut': rut,
        'activo': activo,
      };
}

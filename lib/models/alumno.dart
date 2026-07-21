class Alumno {
  final int id;
  final String rut;
  final String nombre;
  final String? nacimiento;
  final String? curso;
  final bool validado;
  final bool verificado;

  Alumno({
    required this.id,
    required this.rut,
    required this.nombre,
    this.nacimiento,
    this.curso,
    required this.validado,
    required this.verificado,
  });

  factory Alumno.fromJson(Map<String, dynamic> json) {
    return Alumno(
      id: json['id'] as int? ?? 0,
      rut: json['rut'] as String? ?? '',
      nombre: json['nombre'] as String? ?? '',
      nacimiento: json['nacimiento'] as String?,
      curso: json['curso'] as String?,
      validado: json['validado'] as bool? ?? false,
      verificado: json['verificado'] as bool? ?? false,
    );
  }
}

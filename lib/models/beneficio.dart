class Beneficio {
  final int id;
  final String nombre;
  final bool stockeable;
  final int? stockActual;

  Beneficio({
    required this.id,
    required this.nombre,
    required this.stockeable,
    this.stockActual,
  });

  /// Si stockActual es 0, no tiene stock.
  bool get isOutOfStock => stockActual != null && stockActual! <= 0;

  /// Si stockActual es null, es stock ilimitado/indicado. Si es null o > 0, se puede entregar.
  bool get canBeDelivered => stockActual == null || stockActual! > 0;

  factory Beneficio.fromJson(Map<String, dynamic> json) {
    return Beneficio(
      id: json['id'] as int,
      nombre: json['nombre'] as String? ?? '',
      stockeable: json['stockeable'] as bool? ?? false,
      stockActual: json['stock_actual'] as int?,
    );
  }
}

class BeneficioArea {
  final int id;
  final String nombre;
  final List<Beneficio> beneficios;

  BeneficioArea({
    required this.id,
    required this.nombre,
    required this.beneficios,
  });

  factory BeneficioArea.fromJson(Map<String, dynamic> json) {
    var list = json['beneficios'] as List? ?? [];
    List<Beneficio> items =
        list.map((i) => Beneficio.fromJson(i as Map<String, dynamic>)).toList();
    return BeneficioArea(
      id: json['id'] as int,
      nombre: json['nombre'] as String? ?? '',
      beneficios: items,
    );
  }
}

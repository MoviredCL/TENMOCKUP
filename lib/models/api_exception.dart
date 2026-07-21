class ApiException implements Exception {
  final int statusCode;
  final String message;
  final Map<String, dynamic>? errors;
  final Map<String, dynamic>? extraData;

  ApiException({
    required this.statusCode,
    required this.message,
    this.errors,
    this.extraData,
  });

  @override
  String toString() => message;
}

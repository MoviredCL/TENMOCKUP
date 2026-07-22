class ApiConfig {
  static const String defaultBaseUrl = 'http://192.168.11.141:8541/api';
  static const String fallbackBaseUrl = 'http://localhost:8541/api';

  static String baseUrl = defaultBaseUrl;

  /// Flag para activar o desactivar el modo simulación (demo sin conexión backend).
  static bool isSimulationMode = true;
}

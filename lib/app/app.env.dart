import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AppEnv {
  dev,
  production,
}

class AppFromEnv {
  // Public Envs.
  static const _selectedEnv = String.fromEnvironment('ENV');
  static AppEnv get appEnv {
    switch (_selectedEnv) {
      case 'dev':
        return AppEnv.dev;
      case 'production':
        return AppEnv.production;
      default:
        throw Exception('Unknown environment: $_selectedEnv');
    }
  }

  // Private Envs.
  static String get baseUrl => dotenv.get('BASE_URL');
}

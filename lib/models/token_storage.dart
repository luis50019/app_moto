import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  static const _storage = FlutterSecureStorage();
  static const _keyToken = 'auth_token';
  static const _keyRefreshToken = 'refresh_token'; // Opcional

  // Guardar token de acceso
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  // Obtener token almacenado
  static Future<String?> getToken() async {
    return await _storage.read(key: _keyToken);
  }

  // Eliminar token (para logout)
  static Future<void> deleteToken() async {
    await _storage.delete(key: _keyToken);
  }

  // Verificar si existe un token
  static Future<bool> hasToken() async {
    return await _storage.containsKey(key: _keyToken);
  }

  // Opcional: Manejo de refresh token
  static Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _keyRefreshToken, value: token);
  }

  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _keyRefreshToken);
  }
}
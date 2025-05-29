import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  static const _storage = FlutterSecureStorage();
  static const _keyToken = 'auth_token';
  static const _keyRefreshToken = 'refresh_token'; // Opcional
  static const _keyUserId = 'user_id';
  static const _keyTypeUser = 'type_user';

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

  // Nuevos métodos para el user_id
  static Future<void> saveUserId(String userId) async {
    await _storage.write(key: _keyUserId, value: userId);
  }

  static Future<String?> getUserId() async {
    return await _storage.read(key: _keyUserId);
  }

  static Future<void> deleteUserId() async {
    await _storage.delete(key: _keyUserId);
  }

  //metodos para el type_user
  static Future<void> saveTypeUser(String userId) async {
    await _storage.write(key: _keyTypeUser, value: userId);
  }

  static Future<String?> getTypeUser() async {
    return await _storage.read(key: _keyTypeUser);
  }

  static Future<void> deleteTypeUser() async {
    await _storage.delete(key: _keyTypeUser);
  }

  //metodo para borrar todo

  static Future<void> deleteTokens() async {
    try {
      await deleteToken();
      await deleteTypeUser();
      await deleteUserId();
      debugPrint("Sesión cerrada");
    } catch (e) {
      debugPrint('Error deleting tokens: $e');
      rethrow;
    }
  }
}

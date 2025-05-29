import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ReservationDriverStorage{
  static const _storage = FlutterSecureStorage();
  static const _idReservation = 'id_reservation';
  // Guardar el id de la reservacion
  static Future<void> saveReservation(String id) async {
    await _storage.write(key: _idReservation, value: id);
  }

  // Obtener la reservacion almacenado
  static Future<String?> getReservation() async {
    return await _storage.read(key: _idReservation);
  }

  // Eliminar reservation (para logout)
  static Future<void> deleteReservation() async {
    await _storage.delete(key: _idReservation);
  }

  // Verificar si existe la reservacion
  static Future<bool> hasReservation() async {
    return await _storage.containsKey(key: _idReservation);
  }
}
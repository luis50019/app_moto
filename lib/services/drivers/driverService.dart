import 'dart:convert';
import 'dart:io';
import 'package:app_ocotaxi/core/constants/app_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../models/driver/driver_info_id.dart';
import '../../models/driver/drivers_info.dart';
import '../../models/driver/reservations_response.dart';

abstract class DriverService {
  static Future<DriverResponse?> getBetterDrivers() async {
    try {
      final response = await http.get(AppUrl.urlBetterDriver);
      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          throw Exception('La respuesta está vacía');
        }
        final Map<String, dynamic> data = jsonDecode(response.body);
        return DriverResponse.fromJson(data);
      } else {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al obtener conductores: $e');
    }
  }

  static Future<DriverResponse?> getAllDrivers() async {
    try {
      final response = await http.get(AppUrl.urlAllDriver);
      if (response.statusCode == 200) {
        debugPrint(response.body);
        if (response.body.isEmpty) {
          throw Exception('La respuesta está vacía');
        }
        final Map<String, dynamic> data = jsonDecode(response.body);
        return DriverResponse.fromJson(data);
      } else {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al obtener conductores: $e');
    }
  }

  static Future<DriverDetailResponse> getDriverByID(String idDriver)async{
    try {
      debugPrint(AppUrl.urlDriverById+idDriver);
      final response = await http.get(Uri.parse(AppUrl.urlDriverById+idDriver));
      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          throw Exception('La respuesta está vacía');
        }
        final Map<String, dynamic> data = jsonDecode(response.body);
        return DriverDetailResponse.fromJson(data);
      } else {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error el conductor seleccionado: $e');
    }
  }
  static Future<ReservationsResponse?> getAllReservations(String idDriver) async {
    try {
      final uri = Uri.parse(AppUrl.urlgetAllReservations + idDriver);
      final response = await http.get(uri);

      if (response.statusCode != 200) {
        return null;
      }
      debugPrint(response.body);
      final dynamic decoded = jsonDecode(response.body);

      if (decoded is! Map<String, dynamic>) {
        return null;
      }

      if (!decoded.containsKey('data')) {
        throw FormatException('La respuesta no contiene el campo "data"');
      }

      final responseData = decoded['data'] as Map<String, dynamic>;
      return ReservationsResponse.fromJson(responseData);

    } on http.ClientException catch (e) {
      throw Exception('Error de conexión: ${e.message}');
    } on FormatException catch (e) {
      throw Exception('Error en el formato de la respuesta: ${e.message}');
    } catch (e) {
      throw Exception('Error al obtener reservaciones: ${e.toString()}');
    }
  }
  static Future<bool> CancelReservation(String idReservation) async {
    try {
      final uri = Uri.parse(AppUrl.urlDriverCancelReservations + idReservation);
      final response = await http.put(uri);

      if (response.statusCode != 200) {
        throw HttpException('Error HTTP ${response.statusCode}');
      }

      if (response.body.isEmpty) {
        throw Exception('La respuesta del servidor está vacía');
      }

      debugPrint(response.body);
      return true;
    } on http.ClientException catch (e) {
      throw Exception('Error de conexión: ${e.message}');
      return false;
    } on FormatException catch (e) {
      throw Exception('Error en el formato de la respuesta: ${e.message}');
      return false;
    } catch (e) {
      throw Exception('Error al obtener reservaciones: ${e.toString()}');
      return false;
    }
  }
  static Future<bool> AcceptReservation(String idReservation) async {
    try {
      final uri = Uri.parse(AppUrl.urlDriverAcceptReservations + idReservation);
      final response = await http.put(uri);

      if (response.statusCode != 200) {
        throw HttpException('Error HTTP ${response.statusCode}');
      }

      if (response.body.isEmpty) {
        throw Exception('La respuesta del servidor está vacía');
      }

      debugPrint(response.body);
      return true;
    } on http.ClientException catch (e) {
      throw Exception('Error de conexión: ${e.message}');
      return false;
    } on FormatException catch (e) {
      throw Exception('Error en el formato de la respuesta: ${e.message}');
      return false;
    } catch (e) {
      throw Exception('Error al obtener reservaciones: ${e.toString()}');
      return false;
    }
  }
}

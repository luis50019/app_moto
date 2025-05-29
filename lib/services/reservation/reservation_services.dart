import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/app_url.dart';
import '../../models/reservations/generate_reservation.dart';
import '../../models/users/basic_info.dart';

class ReservationService {
  static Future<ReservationResponse> createReservation(Map<String, dynamic> infoReservation) async {
    try {
      final response = await http.post(
        AppUrl.urlRegisterReservation,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(infoReservation),
      );

      debugPrint(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        debugPrint(response.body);
        if (response.body.isEmpty) {
          throw Exception('La respuesta del servidor está vacía');
        }

        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return ReservationResponse.fromJson(responseData);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Error al crear la reservación: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('Error de conexión: ${e.message}');
    } on FormatException catch (e) {
      throw Exception('Error al procesar la respuesta: ${e.message}');
    } catch (e) {
      throw Exception('Error inesperado --------: $e');
    }
  }

  static Future<ReservationResponse> findReservation(String idReservation) async {
    try {
      final response = await http.get(
        Uri.parse("${AppUrl.urlFindReservation}$idReservation"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      debugPrint(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        debugPrint(response.body);
        if (response.body.isEmpty) {
          throw Exception('La respuesta del servidor está vacía');
        }

        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return ReservationResponse.fromJson(responseData);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Error al crear la reservación: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('Error de conexión: ${e.message}');
    } on FormatException catch (e) {
      throw Exception('Error al procesar la respuesta: ${e.message}');
    } catch (e) {
      throw Exception('Error inesperado --------: $e');
    }
  }

  static Future<void> CancelReservation(String idReservacion) async {
    try {
      final response = await http.put(
        Uri.parse("${AppUrl.urlCancelReservation}/$idReservacion"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        debugPrint("${response.body} -----> entro");
        if (response.body.isEmpty) {
          throw Exception('La respuesta del servidor está vacía');
        }
        debugPrint("se boorro todo bien");
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Error al crear la reservación: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('Error de conexión: ${e.message}');
    } on FormatException catch (e) {
      throw Exception('Error al procesar la respuesta: ${e.message}');
    } catch (e) {
      throw Exception('Error inesperado --------: $e');
    }
  }
}
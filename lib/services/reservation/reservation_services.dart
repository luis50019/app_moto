import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/app_url.dart';
import '../../models/users/basic_info.dart';

class ReservationService {
  static Future<AuthResponse> createReservation(Map<String, dynamic> infoReservation) async {
    try {
      // 1. Configurar la petición POST
      final response = await http.post(
        AppUrl.urlRegisterReservation,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(infoReservation), // Convertir el mapa a JSON
      );

      // 2. Procesar la respuesta
      if (response.statusCode == 201 || response.statusCode == 200) {
        debugPrint(response.body);
        if (response.body.isEmpty) {
          throw Exception('La respuesta del servidor está vacía');
        }

        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return AuthResponse.fromJson(responseData);
      } else {
        // Manejar errores específicos según el status code
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
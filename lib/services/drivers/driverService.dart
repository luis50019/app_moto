import 'dart:convert';
import 'package:app_ocotaxi/core/constants/app_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../models/driver/driver_info_id.dart';
import '../../models/driver/drivers_info.dart';

abstract class DriverService {
  static Future<DriverResponse?> getBetterDrivers() async {
    try {
      final response = await http.get(AppUrl.urlBetterDriver); // Asegúrate de usar Uri.parse
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
      throw Exception('Error al obtener conductores: $e'); // Lanza la excepción para manejarla en la UI
    }
  }

  static Future<DriverDetailResponse> getDriverByID(String idDriver)async{
    try {
      debugPrint(AppUrl.urlDriverById+idDriver);
      final response = await http.get(Uri.parse(AppUrl.urlDriverById+idDriver)); // Asegúrate de usar Uri.parse
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
      throw Exception('Error el conductor seleccionado: $e'); // Lanza la excepción para manejarla en la UI
    }
  }
}

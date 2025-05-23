import 'dart:convert';

import 'package:app_ocotaxi/models/fee/model_fee.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/app_url.dart';

class FeeService{

  static Future<FeeResponse> getFee(double distance)async{
    try {
      final response = await http.get(Uri.parse(AppUrl.urlFeeByDistance+distance.toString()));
      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          throw Exception('La respuesta está vacía');
        }
        debugPrint(response.body);
        final Map<String, dynamic> data = jsonDecode(response.body);
        return FeeResponse.fromJson(data);
      } else {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al obtener la tarifa: $e');
    }
  }


}
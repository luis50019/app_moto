import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

Future<List<Placemark>?> getCurrentLocation() async {
  // Verifica si los servicios de ubicación están activados
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Los servicios de ubicación están desactivados.');
  }

  // Verifica y solicita permisos
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error("Permiso de ubicación denegado.");
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error("Permiso denegado permanentemente.");
  }

  // Si llegamos hasta aquí, tenemos permiso
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  return await placemarkFromCoordinates(
    position.latitude,
    position.longitude,
  );
}

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../services/location/location_service.dart';

class LocationProvider extends ChangeNotifier {
  List<Placemark>? _location;
  Position? _position;
  String? _error;
  bool _isLoading = false;

  List<Placemark>? get location => _location;
  Position? get position => _position;
  String? get error => _error;
  bool get isLoading => _isLoading;

  LocationProvider() {
    _init();
  }

  Future<void> _init() async {
    await getLocationUser();
  }

  Future<void> getLocationUser() async {
    try {
      _isLoading = true;
      notifyListeners();

      // ✅ Obtenemos la ubicación con coordenadas
      _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Si quieres también la dirección textual
      _location = await placemarkFromCoordinates(
        _position!.latitude,
        _position!.longitude,
      );

      _error = null;
    } catch (e) {
      _error = e.toString();
      _location = null;
      _position = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// ✅ Calcular distancia a un destino desde tu ubicación actual
  double calculateDistance(LatLng destination) {
    if (_position == null) return 0;

    return Geolocator.distanceBetween(
      _position!.latitude,
      _position!.longitude,
      destination.latitude,
      destination.longitude,
    );
  }
}

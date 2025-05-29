import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../../models/fee/model_fee.dart';
import '../services/reservation_provider.dart';

class LocationDestine extends ChangeNotifier {
  LatLng? _destination;
  String? _locationName;

  LatLng? get destination => _destination;
  String? get locationName => _locationName;

  void setDestination(LatLng coordinates, {String? name}) {
    _destination = coordinates;
    _locationName = name;
    notifyListeners();
  }

  void cancelTrip(){
    _destination = null;
    _locationName = "";
    debugPrint("borrando");
    notifyListeners();
  }

  bool alreadyExistLocation(){
    return _locationName!.isNotEmpty?true:false;
  }

  LatLng get getDestination{
    return _destination!;
  }

  void clearDestination() {
    _destination = null;
    _locationName = null;
    notifyListeners();
  }

}
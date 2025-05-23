import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

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

  bool alreadyExistLocation(){
    return _locationName!.isNotEmpty?true:false;
  }

  LatLng get getDestination{
    //debugPrint(_destination!.longitude.toString()+"->-"+_destination!.latitude.toString()+"");
    //LatLng(16.791485, -96.675483)
    return _destination!;
  }

  void clearDestination() {
    _destination = null;
    _locationName = null;
    notifyListeners();
  }

}
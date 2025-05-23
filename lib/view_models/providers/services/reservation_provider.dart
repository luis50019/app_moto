import 'package:app_ocotaxi/models/driver/drivers_info.dart';
import 'package:app_ocotaxi/models/fee/model_fee.dart';
import 'package:app_ocotaxi/services/fee/fee_service.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class ReservationProvider extends ChangeNotifier {
  User? _driverSelect;
  double? _distanceTrip;
  LatLng? _destination;
  FeeResponse? _fee;
  bool _status =false;

  void setDriver(User driver) {
    _driverSelect = driver;
    notifyListeners();
  }

  void setStatusReservation(bool status) {
    _status = status;
  }

  void setDestination(LatLng location){
    _destination = location;
  }

  bool get getStatusReservacion{
    return _status;
  }

  void setDistanceTrip(double distance)async{
    _distanceTrip = distance;
    debugPrint("distancia "+_distanceTrip.toString());
    _fee = await FeeService.getFee(_distanceTrip!);
    notifyListeners();
  }

  double? get getDistance{
    if(_distanceTrip!=null){
      return _distanceTrip!.truncateToDouble()/1000;
    }
    return null;
  }

  FeeResponse? get getInfoFee{
    if(_fee?.data == null){
      return null;
    }
    return _fee;
  }

  void deleteDriver() {
    _driverSelect = null;
    notifyListeners();
  }

  bool driverExist() {
    // Asegurarse de que no sea null antes de acceder
    return _driverSelect != null && _driverSelect!.basicInfo.name.isNotEmpty;
  }

  User? get getDriver {
    return _driverSelect;
  }
}

import 'package:app_ocotaxi/models/driver/drivers_info.dart';
import 'package:app_ocotaxi/models/fee/model_fee.dart';
import 'package:app_ocotaxi/models/reservation_storage.dart';
import 'package:app_ocotaxi/services/fee/fee_service.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../../models/reservations/generate_reservation.dart';

class ReservationProvider extends ChangeNotifier {
  User? _driverSelect;
  double? _distanceTrip;
  LatLng? _destination;
  FeeResponse? _fee;
  bool _status =false;
  ReservationResponse? _reservation;
  ReservationStorage controllerReservation = ReservationStorage();

  //metodos para el registro de reservaciones
  void createNewReservation(ReservationResponse newReservation)async{
    _reservation = newReservation;
    _status = true;
    await ReservationStorage.saveReservation(_reservation!.data.id);
    notifyListeners();
  }

   Future<String?> get getidReservation async{
    return await ReservationStorage.getReservation();
  }

  void cancelReservation(){
    _reservation = null;
    _driverSelect =null;
    _distanceTrip = null;
    _status = false;
    _fee = null;
    notifyListeners();
  }

  ReservationResponse? get getReservation{
    return _reservation;
  }

  void setStatusReservation(bool status) {
    _status = status;
  }

  bool get getStatusReservacion{
    return _status;
  }


  //metodos para conocer la distancia
  void setDestination(LatLng location){
    _destination = location;
    setDistanceTrip(_distanceTrip!.truncateToDouble()/1000);
  }


  void setDistanceTrip(double distance)async{
    _distanceTrip = distance;
    await getFee();
    notifyListeners();
  }

  double? get getDistance{
    if(_distanceTrip!=null){
      return _distanceTrip!.truncateToDouble()/1000;
    }
    return null;
  }

  Future<void> getFee() async{
    if(_distanceTrip == null) return;
    _fee = await FeeService.getFee(_distanceTrip!);
    notifyListeners();
  }

  FeeResponse? get getInfoFee{
    if(_fee?.data == null){
      return null;
    }
    return _fee;
  }

  //metodos para las tarifas
  void deleteDriver() {
    _driverSelect = null;
    notifyListeners();
  }

  //metodos para el conductor seleccionado
  void setDriver(User driver) {
    _driverSelect = driver;
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

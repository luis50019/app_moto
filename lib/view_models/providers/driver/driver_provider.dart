import 'package:app_ocotaxi/models/driver/reservations_response.dart';
import 'package:app_ocotaxi/models/reservation_driver_storage.dart';
import 'package:flutter/foundation.dart';

import '../../../models/reservation_storage.dart';
import '../../../models/reservations/generate_reservation.dart';

class DriverProvider extends ChangeNotifier {
  ReservationsResponse? _reservations;
  ReservationDriverStorage _controllerReservation = ReservationDriverStorage();
  bool alreadyExistReservation = false;
  ReservationResponse? _reservation;
  bool status =false;

  ReservationsResponse? get reservations => _reservations;

  void setReservations(ReservationsResponse? newData) {
    _reservations = newData;
    notifyListeners();
  }

  void setStatus(){
    status = false;
    notifyListeners();
  }

  void createNewReservation(ReservationResponse newReservation)async{
    _reservation = newReservation;
    status = true;
    await ReservationStorage.saveReservation(_reservation!.data.id);
    notifyListeners();
  }

  void saveReservation(String id){
    ReservationDriverStorage.saveReservation(id);
    alreadyExistReservation = true;
    notifyListeners();
  }

  Future<String?> get getReservation async{
    return await ReservationDriverStorage.getReservation();
  }

  Future<void> get DeleteReservation async{
    alreadyExistReservation = false;
    return await ReservationDriverStorage.deleteReservation();
  }

  ReservationsResponse? get getData{
    return _reservations;
  }

  int? get getLength{
    return _reservations?.data.length;
  }

}
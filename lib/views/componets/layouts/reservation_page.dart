import 'dart:async';

import 'package:app_ocotaxi/core/constants/app_styles.dart';
import 'package:app_ocotaxi/services/reservation/reservation_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/reservations/generate_reservation.dart';
import '../../../view_models/providers/location/location_destine.dart';
import '../../../view_models/providers/services/reservation_provider.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {

  String menssage = "Cancelar viaje";
  Timer? _reservationTimer;
  void hanlderClick(){
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final reservation = Provider.of<ReservationProvider>(context, listen: false);
      String? id = await reservation.getidReservation;
      final location = Provider.of<LocationDestine>(context, listen: false,);
      await ReservationService.CancelReservation(id!);
      location.cancelTrip();
      reservation.cancelReservation();
    });
  }

  @override
  void initState() {
    super.initState();
    _startReservationTimer();
  }

  void _startReservationTimer() {
    _reservationTimer?.cancel();

    _reservationTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      reservation();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      reservation();
    });
  }

  void reservation() async {
    final reservation = Provider.of<ReservationProvider>(context, listen: false);
    String? id = await reservation.getidReservation;
    ReservationResponse data = await ReservationService.findReservation(id!);
    final reservationProvider = Provider.of<ReservationProvider>(context, listen: false);
    menssage = data.data.state.general == "cancelado"?"nuevo viaje":"Cancelar viaje";
    reservationProvider.createNewReservation(data);
  }

  @override
  void dispose() {
    _reservationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reservation = Provider.of<ReservationProvider>(context, listen: false,).getReservation;
    final provider = Provider.of<ReservationProvider>(context, listen: false,);

    return Container(
      height: 500,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("codigo de verificacion",style: AppStyle.texBoldDark,),
          Text("estado del viaje: ${reservation!.data.state.general}",style: TextStyle(fontWeight: FontWeight.w300, color: Colors.lightBlue),),
          SizedBox(height: 50,),
          Text(reservation!.data.security.codeVerification,style: AppStyle.textCode,),
          SizedBox(height: 50,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              hanlderClick();
            },
            child: Text(
              menssage,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

}

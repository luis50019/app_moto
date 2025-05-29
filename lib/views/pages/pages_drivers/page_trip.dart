import 'dart:async';

import 'package:app_ocotaxi/core/constants/routes.dart';
import 'package:app_ocotaxi/views/componets/headers/header_location.dart';
import 'package:app_ocotaxi/views/componets/layouts/nav_bar_driver.dart';
import 'package:app_ocotaxi/views/componets/layouts/titlePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_styles.dart';
import '../../../models/reservations/generate_reservation.dart';
import '../../../services/reservation/reservation_services.dart';
import '../../../view_models/providers/driver/driver_provider.dart';
import '../../../view_models/providers/location/location_destine.dart';
import '../../../view_models/providers/services/reservation_provider.dart';

class PageTrip extends StatefulWidget {
  const PageTrip({super.key});

  @override
  State<PageTrip> createState() => _PageTripState();
}

class _PageTripState extends State<PageTrip> {
  String id = "";
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
    final reservation = Provider.of<DriverProvider>(context, listen: false);
    String? id = await reservation.getReservation;
    ReservationResponse data = await ReservationService.findReservation(id!);
    if(data == null){
      reservation.setStatus();
    }else{
      reservation.createNewReservation(data);
    }
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

    return Scaffold(
      appBar: HeaderLocation(backButton: true,url: Routes.homeDriver,),
      body: Container(
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
      ),
    );
  }
}

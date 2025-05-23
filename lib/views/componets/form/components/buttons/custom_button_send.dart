import 'package:app_ocotaxi/services/reservation/reservation_services.dart';
import 'package:app_ocotaxi/view_models/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../view_models/providers/location/location_destine.dart';
import '../../../../../view_models/providers/location/location_provider.dart';
import '../../../../../view_models/providers/services/reservation_provider.dart';

class CustomButtonSend extends StatefulWidget {
  const CustomButtonSend({super.key});

  @override
  State<CustomButtonSend> createState() => _CustomButtonSendState();
}

class _CustomButtonSendState extends State<CustomButtonSend> {

  void handlerClick(){
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final reservationProvider = Provider.of<ReservationProvider>(context, listen: false,);
      final destinationProvider = Provider.of<LocationDestine>(context, listen: false,);
      final locationUser = Provider.of<LocationProvider>(context, listen: false,);
      final authIfo = Provider.of<AuthProvider>(context, listen: false,).getInfo;
      debugPrint("id ---"+authIfo!.idUser);
      Map<String,dynamic> infoReservation = {
        "passage":authIfo?.idUser,
        "numberPassage":2,
        "driver":reservationProvider.getDriver?.id,
        "rate":reservationProvider.getInfoFee?.data.id,
        "destination":{
          "lat":destinationProvider.getDestination.latitude,
          "lng":destinationProvider.getDestination.longitude
        },
        "start":{
          "lat":locationUser.position?.latitude,
          "lng":locationUser.position?.longitude
        },
        "distance":1500
      };

      await ReservationService.createReservation(infoReservation);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0, // Ajusta este valor según necesites
      left: 20,
      right: 20,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            handlerClick();
          },
          child: const Text(
            "Enviar solicitud de viaje",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}

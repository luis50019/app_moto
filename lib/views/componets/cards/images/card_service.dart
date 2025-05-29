import 'package:app_ocotaxi/core/constants/app_colors.dart';
import 'package:app_ocotaxi/models/driver/reservations_response.dart';
import 'package:app_ocotaxi/services/drivers/driverService.dart';
import 'package:app_ocotaxi/views/componets/cards/images/image_avatar_driver.dart';
import 'package:app_ocotaxi/views/componets/layouts/build_action_button.dart';
import 'package:app_ocotaxi/views/componets/layouts/build_info_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../../../view_models/providers/auth_provider.dart';
import '../../../../view_models/providers/driver/driver_provider.dart';

class CardService extends StatefulWidget {
  final Reservation infoReservation;
  const CardService({super.key, required this.infoReservation});

  @override
  State<CardService> createState() => _CardServiceState();
}

class _CardServiceState extends State<CardService> {

  void cancelReservation() async {
    final response = await DriverService.CancelReservation(widget.infoReservation.id);
    if (response) {
      debugPrint("Se canceló con éxito");
      // Mostrar el SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("El viaje fue rechazado."),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      await loadReservations();
    } else {
      debugPrint("No se canceló");
    }
  }

  void acceptReservation() async {
    final response = await DriverService.AcceptReservation(widget.infoReservation.id);
    if (response) {
      final driverProvider = Provider.of<DriverProvider>(context, listen: false);
      await driverProvider.saveReservation(widget.infoReservation.id);
      // Mostrar el SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("El viaje fue aceptado."),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      debugPrint("No se canceló");
    }
  }

  Future<void> loadReservations() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final driverProvider = Provider.of<DriverProvider>(context, listen: false);

      String? id = await authProvider.getIdUser();
      if (id != null) {
        ReservationsResponse? data = await DriverService.getAllReservations(id);
        driverProvider.setReservations(data);
      }
    } catch (e) {
      debugPrint("Error al actualizar reservaciones: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al actualizar: ${e.toString()}")),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.all(16),
      child: Container(
        constraints: BoxConstraints(minHeight: 250,maxWidth: double.infinity),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageAvatarDriver(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${widget.infoReservation.passage.name} solicita un viaje",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  BuildInfoSection(title: "Ubicacion", content: LatLng(widget.infoReservation.route.start.lat, widget.infoReservation.route.start.lng),),
                  BuildInfoSection(title: "Destino", content: LatLng(widget.infoReservation.route.destination.lat, widget.infoReservation.route.destination.lng)),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 15,),
                      Text(
                        '\$${widget.infoReservation.rate.price}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textOrange,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      SizedBox(width: 4.0),
                      BuildActionButton(text: "Aceptar viaje", color: Colors.green, function: acceptReservation),
                      SizedBox(width: 10),
                      BuildActionButton(text: "Rechazar viaje", color: Colors.red, function: cancelReservation)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

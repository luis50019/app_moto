import 'dart:async';
import 'package:app_ocotaxi/views/pages/pages_drivers/list_reservation.dart';
import 'package:app_ocotaxi/views/pages/pages_drivers/page_trip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_models/providers/driver/driver_provider.dart';
class ReservationPageDriver extends StatefulWidget {
  const ReservationPageDriver({super.key});

  @override
  State<ReservationPageDriver> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPageDriver> {

  @override
  Widget build(BuildContext context) {
    final driverProvider = Provider.of<DriverProvider>(context);
    return driverProvider.alreadyExistReservation == true && driverProvider.status == true?PageTrip():ListReservation();
  }
}
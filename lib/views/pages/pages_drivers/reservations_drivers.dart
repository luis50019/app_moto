import 'package:app_ocotaxi/views/componets/cards/images/card_service.dart';
import 'package:flutter/material.dart';

import '../../../models/driver/reservations_response.dart';

class ReservationsDrivers extends StatefulWidget {
  final List<Reservation>? reservations; // Lista de reservaciones (mejor nombre)
  const ReservationsDrivers({
    super.key,
    this.reservations, // Cambiado de 'data' a 'reservations'
  });

  @override
  State<ReservationsDrivers> createState() => _ReservationsDriversState();
}

class _ReservationsDriversState extends State<ReservationsDrivers> {
  @override
  Widget build(BuildContext context) {
    final reservations = widget.reservations ?? [];

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: reservations.length, // Usa el largo real de la lista
      itemBuilder: (context, index) {
        final reservation = reservations[index];
        return CardService(
          infoReservation: reservation,
        );
      },
    );
  }
}
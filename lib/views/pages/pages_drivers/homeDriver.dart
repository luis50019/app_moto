import 'package:app_ocotaxi/core/constants/app_colors.dart';
import 'package:app_ocotaxi/views/componets/headers/header_location.dart';
import 'package:app_ocotaxi/views/componets/layouts/nav_bar_driver.dart';
import 'package:app_ocotaxi/views/componets/layouts/titlePage.dart';
import 'package:app_ocotaxi/views/pages/pages_drivers/reservations_drivers.dart';
import 'package:flutter/material.dart';
import '../../componets/cards/images/card_service.dart';

class Homedriver extends StatefulWidget {
  const Homedriver({super.key});

  @override
  State<Homedriver> createState() => _HomedriverState();
}

class _HomedriverState extends State<Homedriver> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderLocation(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Titlepage(text1: "Inicio"),
              const SizedBox(height: 20),
              Text(
                "¡Bienvenido, conductor!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Estamos listos para comenzar tu jornada. Aquí podrás ver tus reservas y solicitudes.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 20),
              // Puedes agregar aquí más contenido o widgets como CardService()
              // Por ejemplo:
              // CardService(), // Si quieres mostrar un servicio o imagen
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBarDriver(),
    );
  }
}

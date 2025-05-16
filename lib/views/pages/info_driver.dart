import 'package:app_ocotaxi/core/constants/routes.dart';
import 'package:app_ocotaxi/views/componets/headers/header_location.dart';
import 'package:app_ocotaxi/views/componets/layouts/comments.dart';
import 'package:app_ocotaxi/views/componets/layouts/image_profile.dart';
import 'package:app_ocotaxi/views/componets/layouts/info.dart';
import 'package:app_ocotaxi/views/componets/layouts/nav_bar.dart';
import 'package:flutter/material.dart';

import '../../models/driver/driver_info_id.dart';
import '../../services/drivers/driverService.dart';

class InfoDriverPage extends StatefulWidget {
  final String idDriver;
  const InfoDriverPage({super.key, required this.idDriver});

  @override
  State<InfoDriverPage> createState() => _InfoDriverPageState();
}

class _InfoDriverPageState extends State<InfoDriverPage> {
  DriverDetailResponse? infoDriver;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      final response = await DriverService.getDriverByID(widget.idDriver);
      setState(() {
        infoDriver = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderLocation(backButton: true, url: Routes.home),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.black, backgroundColor: Colors.white,),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  ImageProfile(url_photo: infoDriver!.data.basicInfo.profilePicture),
                  const SizedBox(height: 20),
                  Info(name: infoDriver!.data.name, rating: infoDriver!.data.rating, pthone: infoDriver!.data.phoneNumber),
                  const SizedBox(height: 20),
                  Comments(data: infoDriver!.reviews),
                  SizedBox(height:70,),
                  TextButton(
                    onPressed: () {
                      // Acción del botón
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: const Text("Solicitar"),
                  )

                ],
              ),
            ),
      bottomNavigationBar: const NavBar(),
    );
  }
}

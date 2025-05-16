import 'package:app_ocotaxi/models/driver/drivers_info.dart';
import 'package:app_ocotaxi/services/drivers/driverService.dart';
import 'package:app_ocotaxi/views/componets/cards/card_driver.dart';
import 'package:app_ocotaxi/views/componets/layouts/titlePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BetterDrivers extends StatefulWidget {
  const BetterDrivers({super.key});

  @override
  State<BetterDrivers> createState() => _BetterDriversState();
}

class _BetterDriversState extends State<BetterDrivers> {
  DriverResponse? betterDrivers;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      final response = await DriverService.getBetterDrivers();
      setState(() {
        betterDrivers = response;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    debugPrint("data: ${betterDrivers?.data[0].id}");
    if (betterDrivers == null || betterDrivers!.data.isEmpty) {
      return const Center(child: Text("No hay conductores disponibles."));
    }
    return Column(
      children: [
        Titlepage(text1: "Conductor", text2: "De la Semana"),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: betterDrivers?.data.length,
          itemBuilder: (context, index) {
            final driver = betterDrivers?.data[index];
            return CardDriver(info:driver!,);
          },
        ),
      ],
    );
  }
}

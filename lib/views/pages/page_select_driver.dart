import 'package:app_ocotaxi/core/constants/app_styles.dart';
import 'package:app_ocotaxi/core/constants/routes.dart';
import 'package:app_ocotaxi/views/componets/cards/card_driver_select.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/driver/drivers_info.dart' as User;
import '../../services/drivers/driverService.dart';
import '../componets/headers/header_location.dart';

class PageSelectDriver extends StatefulWidget {
  const PageSelectDriver({super.key});

  @override
  State<PageSelectDriver> createState() => _PageSelectDriverState();
}

class _PageSelectDriverState extends State<PageSelectDriver> {

  User.DriverResponse? drivers;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      final response = await DriverService.getAllDrivers();
      setState(() {
        drivers = response;
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
    return Scaffold(
      appBar: HeaderLocation(url: Routes.reservationPrivate, backButton: true),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(left:10),
                child: Text("Conductores", style: AppStyle.textH1CardOrange,)),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: drivers?.data.length ?? 0,
              itemBuilder: (context, index) {
                final driver = drivers?.data[index];
                return CardDriverSelect(info: driver!);
              },
            ),
          ],
        ),
      ),
    );
  }

}

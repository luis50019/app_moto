import 'package:app_ocotaxi/core/constants/app_styles.dart';
import 'package:app_ocotaxi/core/constants/routes.dart';
import 'package:app_ocotaxi/views/componets/cards/card_driver.dart';
import 'package:app_ocotaxi/views/componets/cards/card_driver_select.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../../view_models/providers/services/reservation_provider.dart';

class CustomSelectDriver extends StatefulWidget {
  const CustomSelectDriver({super.key});

  @override
  State<CustomSelectDriver> createState() => _CustomSelectDriverState();
}

class _CustomSelectDriverState extends State<CustomSelectDriver> {
  @override
  void initState() {
    super.initState();
    // Obtener la ubicación al iniciar el widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReservationProvider>(context, listen: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final infoReservation = Provider.of<ReservationProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Conductor", style: AppStyle.labelText),
        infoReservation.driverExist() == true
            ? CardDriverSelect(
                info: infoReservation.getDriver,
                changeDriver: true,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Seleccione un conductor"),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      context.push(Routes.selectDriver);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(100, 194, 193, 193),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color.fromARGB(100, 159, 159, 159),
                          width: 2,
                        ),
                      ),
                      child: const Center(
                        child: Icon(Icons.add, size: 60, weight: 600),
                      ),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}

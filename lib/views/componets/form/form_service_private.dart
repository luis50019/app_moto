import 'package:app_ocotaxi/view_models/providers/location/location_destine.dart';
import 'package:app_ocotaxi/view_models/providers/services/reservation_provider.dart';
import 'package:app_ocotaxi/views/componets/form/components/buttons/custom_button_send.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_ocotaxi/core/constants/app_styles.dart';
import 'package:app_ocotaxi/core/constants/routes.dart';
import 'package:app_ocotaxi/views/componets/form/components/custom_field/custom_select_driver.dart';
import 'package:app_ocotaxi/views/componets/form/components/custom_field/custom_text_area.dart';
import 'package:app_ocotaxi/views/componets/form/custom_input.dart';
import 'package:app_ocotaxi/views/componets/layouts/info_fee.dart';
import 'package:app_ocotaxi/view_models/providers/location/location_provider.dart';

class FormServicePrivate extends StatefulWidget {
  const FormServicePrivate({super.key});

  @override
  State<FormServicePrivate> createState() => _FormServicePrivateState();
}

class _FormServicePrivateState extends State<FormServicePrivate> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final locationUser = Provider.of<LocationProvider>(context, listen: false,);
      await locationUser.getLocationUser();
      final destinationProvider = Provider.of<LocationDestine>(context, listen: false,);
      final reservationProvider = Provider.of<ReservationProvider>(context, listen: false,);

      if (destinationProvider.alreadyExistLocation()) {
        double distance = locationUser.calculateDistance(
          destinationProvider.getDestination,
        );
        reservationProvider.setDistanceTrip(distance);
      }else{
        debugPrint("No entro");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final locationDestine = Provider.of<LocationDestine>(context);
    final currentLocation = locationProvider.location?.first;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Datos sobre el viaje", style: AppStyle.textRating),
                const SizedBox(height: 15),
                CustomInput(
                  labelText: "Ubicacion Actual",
                  placeholder: currentLocation != null
                      ? "${currentLocation.thoroughfare ?? ''}, ${currentLocation.locality ?? ''}"
                      : "Obteniendo ubicación...",
                  url: Routes.mapPage,
                  readOnly: true,
                ),
                const SizedBox(height: 15),
                CustomInput(
                  labelText: "Ubicacion destino",
                  placeholder: locationDestine.locationName,
                  url: Routes.mapPage,
                  readOnly: true,
                ),
                const SizedBox(height: 10),
                const CustomSelectDriver(),
                const SizedBox(height: 10),
                const InfoFee(),
                SizedBox(height: 80),
              ],
            ),
            CustomButtonSend(),
          ],
        ),
      ),
    );
  }
}

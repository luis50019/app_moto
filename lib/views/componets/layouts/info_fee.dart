import 'package:app_ocotaxi/core/constants/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../view_models/providers/services/reservation_provider.dart';

class InfoFee extends StatefulWidget {
  final String distance;
  final String price;
  const InfoFee({super.key, this.distance = "0", this.price = "0",});

  @override
  State<InfoFee> createState() => _InfoFeeState();
}

class _InfoFeeState extends State<InfoFee> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<ReservationProvider>(context, listen: false,);
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<ReservationProvider>(context).getInfoFee;
    final distance = Provider.of<ReservationProvider>(context).getDistance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Tarifa", style: AppStyle.textRating),
        const SizedBox(height: 10),
        if (locationProvider != null && locationProvider.message.isNotEmpty)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Distancia", style: AppStyle.labelText),
                  Text(distance.toString()+" KM", style: AppStyle.textLightDark),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("TOTAL", style: AppStyle.labelText),
                  Text(
                    NumberFormat.currency(
                      locale: 'es_MX',
                      symbol: '\$',
                      decimalDigits: 2,
                    ).format(locationProvider.data.pricingType.global.price),

                    style: AppStyle.textLightDark.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ],
          )
        else
          const Text("No se encontró una tarifa"),
      ],
    );
  }

}

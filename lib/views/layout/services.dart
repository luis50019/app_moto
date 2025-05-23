import 'package:app_ocotaxi/core/constants/routes.dart';
import 'package:app_ocotaxi/views/componets/cards/cardService.dart';
import 'package:flutter/cupertino.dart';

import '../../core/constants/app_colors.dart';

class ListService extends StatefulWidget {
  const ListService({super.key});

  @override
  State<ListService> createState() => _ListServiceState();
}

class _ListServiceState extends State<ListService> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250, // ajusta según el tamaño de tus tarjetas
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          Cardservice(
            service: "Envíos",
            url_photo: "assets/images/repartos.png",
          ),
          SizedBox(width: 10),
          Cardservice(
            backgroudCard: AppColors.backgroudCardServideDark,
            route: Routes.reservationPrivate,
            service: "Servicio Privado",
            url_photo: "assets/images/mototaxi.png",
          ),
          SizedBox(width: 10),
          Cardservice(
            service: "Servicio Compartido",
            url_photo: "assets/images/imagePeople.png",
          ),
        ],
      ),
    );
  }
}

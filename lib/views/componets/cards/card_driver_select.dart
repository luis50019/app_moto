import 'package:app_ocotaxi/core/constants/app_styles.dart';
import 'package:app_ocotaxi/models/driver/drivers_info.dart';
import 'package:app_ocotaxi/views/componets/cards/images/image_avatar_driver.dart';
import 'package:app_ocotaxi/views/componets/form/components/custom_button_select_driver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class CardDriverSelect extends StatelessWidget {
  final User? info;
  final bool changeDriver;
  const CardDriverSelect({super.key,required this.info,this.changeDriver = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.backgroudCardServideDark,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageAvatarDriver(urlImage: info!.basicInfo.profilePicture),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.deepOrange, size: 25),
                      Text(info!.rating.toString(), style: AppStyle.textRating),
                    ],
                  ),
                  Text(info!.basicInfo.name, style: AppStyle.textBold),
                  const SizedBox(height: 4),
                  Text("Tel. ${info!.basicInfo.phone.number}", style: AppStyle.textLight),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 8),
                      CustomButtonSelectDriver(driver: info!,changeDriver: changeDriver,)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

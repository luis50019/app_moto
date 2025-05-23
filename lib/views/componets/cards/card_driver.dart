import 'package:app_ocotaxi/core/constants/app_colors.dart';
import 'package:app_ocotaxi/core/constants/app_styles.dart';
import 'package:app_ocotaxi/core/constants/routes.dart';
import 'package:app_ocotaxi/models/driver/drivers_info.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardDriver extends StatelessWidget {
  final User info;
  const CardDriver({
    super.key,required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.push('${Routes.infoDriver}/${info.id}');
      },
      child: Card(
        color: AppColors.backgroudCardServideDark,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.deepOrange, size: 25),
                      Text(info.rating.toString(), style: AppStyle.textRating),
                    ],
                  ),
                ],
              ),
              Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect( borderRadius: BorderRadius.circular(10),
                    child: Image.network(info.basicInfo.profilePicture,
                      width: 150, height: 150, fit: BoxFit.cover,
                    ),
                  ),
                  Column( crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(info.basicInfo.name,style:AppStyle.textMedium,),
                      Text("tel.${info.basicInfo.phone.number}",style: AppStyle.textLight )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

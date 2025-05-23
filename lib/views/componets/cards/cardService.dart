import 'package:app_ocotaxi/core/constants/app_colors.dart';
import 'package:app_ocotaxi/core/constants/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Cardservice extends StatefulWidget {
  final String url;
  final String service;
  final String url_photo;
  final Color backgroudCard;
  final String route;
  const Cardservice({
    super.key,
    this.url = "",
    required this.service,
    required this.url_photo,this.backgroudCard=AppColors.backgroudCardService,this.route ="",
  });

  @override
  State<Cardservice> createState() => _CardserviceState();
}

class _CardserviceState extends State<Cardservice> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.push(widget.route);
      },
      child: Container(width: 150,
        decoration: BoxDecoration(
          color:widget.backgroudCard,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.url_photo, width: 150, height: 150),
            Padding(padding: EdgeInsets.only(left: 12),
              child: Text(
                widget.service,
                style: AppStyle.textCard,
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

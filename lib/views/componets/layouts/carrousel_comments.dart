import 'package:app_ocotaxi/models/driver/driver_info_id.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_styles.dart';

class CarrouselComments extends StatefulWidget {
  final List<Review> info;
  const CarrouselComments({super.key, required this.info});

  @override
  State<CarrouselComments> createState() => _CarrouselCommentsState();
}

class _CarrouselCommentsState extends State<CarrouselComments> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 220,
        enlargeCenterPage: true,
        autoPlay: true,
        viewportFraction: 0.9,
      ),
      items: widget.info.map((comment) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width, height: 120,
              margin: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 15.0),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 252, 252, 252),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [Text(comment.content.rating.overall.toString(), style: AppStyle.textRating,),
                    const Icon(Icons.star, color: Colors.deepOrange, size: 25,),],),
                  Text(
                    comment.content.comment,
                    style: AppStyle.textLightDark,
                  ),
                ],
              )
            );
          },
        );
      }).toList(),
    );
  }
}

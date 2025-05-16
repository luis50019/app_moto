import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_styles.dart';

class Info extends StatelessWidget {
  final String name;
  final double rating;
  final String pthone;
  const Info({super.key, required this.name, required this.rating, required this.pthone});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: AppStyle.textH1Light,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(rating.toString(), style: AppStyle.textRating,),
                const Icon(Icons.star, color: Colors.deepOrange, size: 25,),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

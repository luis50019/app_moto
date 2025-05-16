import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';

class CardComment extends StatelessWidget {
  final String comment;
  final double ranting;
  const CardComment({super.key, required this.comment, required this.ranting});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    Text(ranting.toString(), style: AppStyle.textRating),
                  ],
                ),
              ],
            ),
            Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column( crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("tel.${comment}",style: AppStyle.textLight )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/widgets.dart';
import '../../core/constants/app_colors.dart';

class AppDecoration {
  static Widget cloudBottomLeft(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: MediaQuery
          .of(context)
          .size
          .width / 2,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(150)),
        ),
      ),
    );
  }

  static Widget cloudBottomRight(BuildContext context){
    return Positioned(
      bottom: 0,
      left: MediaQuery.of(context).size.width / 3, // Ajusta la posición
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(100),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

abstract class AppStyle {
  //header or text import
  static final TextStyle textH1 = TextStyle(fontSize: 68, fontWeight: FontWeight.bold,);
  static final TextStyle textH1Light = TextStyle(fontSize: 68, fontWeight: FontWeight.w300,);
  static final TextStyle textH1Card = TextStyle(fontSize: 60, fontWeight: FontWeight.w500, color: Colors.white,);
  static final TextStyle textH1CardOrange = TextStyle(fontSize: 60, fontWeight: FontWeight.w500, color: Colors.deepOrange,);
  //cards
  static final TextStyle textCard = TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white);
  static final TextStyle textCardDark = TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black);
  static final TextStyle textTitleCard = TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Colors.white);

  //styles
  static final TextStyle textLight = TextStyle(fontSize: 20, fontWeight: FontWeight.w200, color: Colors.white,);
  static final TextStyle textLightDark = TextStyle(fontSize: 20, fontWeight: FontWeight.w200, color: Colors.black,);
  static final TextStyle textRating = TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.deepOrange,);
  static final TextStyle textMedium = TextStyle(fontSize: 60, fontWeight: FontWeight.w200, color: Colors.white,);
}

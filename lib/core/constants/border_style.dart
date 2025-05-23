import 'package:flutter/material.dart';

abstract class CustomBorderStyle{
  static final OutlineInputBorder borderEnable = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black45, width: 2),
    borderRadius: BorderRadius.circular(10),
  );

  static final OutlineInputBorder borderFocus =OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black45, width: 2),
    borderRadius: BorderRadius.circular(10),
  );

  static final OutlineInputBorder borderError = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2),
    borderRadius: BorderRadius.circular(10),
  );

}
import 'package:app_ocotaxi/core/constants/app_colors.dart';
import 'package:app_ocotaxi/views/auth/decoration.dart';
import 'package:app_ocotaxi/views/componets/layouts/form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          FormData(),
          AppDecoration.cloudBottomLeft(context),
          AppDecoration.cloudBottomRight(context),
        ],
      ),
    );
  }
}

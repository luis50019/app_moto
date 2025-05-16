import 'package:app_ocotaxi/core/constants/app_colors.dart';
import 'package:app_ocotaxi/core/constants/routes.dart';
import 'package:app_ocotaxi/views/auth/decoration.dart';
import 'package:app_ocotaxi/views/componets/layouts/form.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          FormData(
            message: "¿Ya tines cuenta?",
            messageLink: "Inicia sesion",
            titlePage: "Crear cuenta",
            messageButton: "Crear cuenta",
            operation: "register",
            urlPage: Routes.login.toString(),
          ),
          AppDecoration.cloudBottomLeft(context),
          AppDecoration.cloudBottomRight(context),
        ],
      ),
    );
  }
}

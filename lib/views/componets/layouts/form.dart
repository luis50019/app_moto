import 'package:app_ocotaxi/core/constants/routes.dart';
import 'package:app_ocotaxi/models/erros/erro_auth.dart';
import 'package:app_ocotaxi/view_models/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';

class FormData extends StatefulWidget {
  final String urlPage;
  final String messageLink;
  final String message;
  final String titlePage;
  final String messageButton;
  final String operation;
  const FormData({
    super.key,
    this.operation = "login",
    this.messageButton = "Entrar",
    this.titlePage = "Iniciar sesion",
    this.urlPage = "/register",
    this.messageLink = "Crear cuenta",
    this.message = "¿Aun no tines cuenta?",
  });

  @override
  State<FormData> createState() => _FormDataState();
}

class _FormDataState extends State<FormData> {
  final formKey = GlobalKey<FormState>();
  final frUsername = TextEditingController();
  final frPhoneNumber = TextEditingController();
  final frPassword = TextEditingController();

  bool isValidUsername = true;
  bool isValidPhoneNumber = true;
  bool isValidPassword = true;
  bool isValidForm = false;

  String messageUsername = "";
  String messagePassword = "";
  String messagePhoneNumber = "";

  bool validForm() {
    if (isValidUsername && isValidPassword && isValidPhoneNumber) {
      return true;
    }
    return false;
  }

  void cleanMessages() {
    messagePassword = "";
    messageUsername = "";
    messagePhoneNumber = "";
    setState(() {});
  }

  void validateUsername(String value) {
    const int minLength = 6;
    final RegExp onlyLetters = RegExp(r'^[a-zA-Z\s]+$');

    if (value.isEmpty) {
      messageUsername = "El nombre está vacío";
      isValidUsername = false;
    } else if (value.trim().length < minLength) {
      messageUsername = "Debe tener al menos $minLength caracteres";
      isValidUsername = false;
    } else if (!onlyLetters.hasMatch(value)) {
      messageUsername = "Solo puedes usar letras del abecedario";
      isValidUsername = false;
    } else {
      messageUsername = "";
      isValidUsername = true;
    }
    setState(() {});
  }

  void validatePassword(String value) {
    const int minLength = 6;
    const int maxLength = 10;

    if (value.isEmpty) {
      messagePassword = "La contraseña está vacía";
      isValidPassword = false;
    } else if (value.length < minLength) {
      messagePassword = "Debe tener al menos $minLength caracteres";
      isValidPassword = false;
    } else if (value.length > maxLength) {
      messagePassword = "Solo puede usar maximo $maxLength cracteres";
      isValidPassword = false;
    } else {
      messagePassword = "";
      isValidPassword = true;
    }
    setState(() {});
  }

  void validateNumberPhone(String value) {
    const int requiredLength = 10;
    final RegExp onlyNumbers = RegExp(r'^\d+$');

    if (value.isEmpty) {
      messagePhoneNumber = "El teléfono está vacío";
      isValidPhoneNumber = false;
    } else if (!onlyNumbers.hasMatch(value)) {
      messagePhoneNumber = "Solo puedes usar números";
      isValidPhoneNumber = false;
    } else if (value.length != requiredLength) {
      messagePhoneNumber =
          "El número debe tener exactamente $requiredLength dígitos";
      isValidPhoneNumber = false;
    } else {
      messagePhoneNumber = "";
      isValidPhoneNumber = true;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/logo.png",
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            Container(
              width: 365,
              child: Text(
                widget.titlePage.toString(),
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                ),
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 400,
                    margin: EdgeInsetsGeometry.symmetric(vertical: 10),
                    child: TextField(
                      onChanged: (String value) {
                        validateUsername(value);
                      },
                      controller: frUsername,
                      decoration: InputDecoration(
                        errorText: messageUsername == "" ? "" : messageUsername,
                        filled: true, // Activa el fondo
                        fillColor: AppColors.secondary,
                        prefixIcon: Icon(
                          Icons.person,
                          color: AppColors.primary,
                        ), // Icono izquierdo
                        hintText: 'Nombre completo',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none, // Sin borde exterior
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 400,
                    margin: EdgeInsetsGeometry.symmetric(vertical: 10),
                    child: TextField(
                      onChanged: (String value) {
                        validateNumberPhone(value);
                      },
                      controller: frPhoneNumber,
                      decoration: InputDecoration(
                        errorText: messagePhoneNumber == ""
                            ? ""
                            : messagePhoneNumber,
                        filled: true, // Activa el fondo
                        fillColor: AppColors.secondary,
                        prefixIcon: Icon(
                          Icons.phone,
                          color: AppColors.primary,
                        ), // Icono izquierdo
                        hintText: 'Numero de teléfono',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none, // Sin borde exterior
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 400,
                    margin: EdgeInsetsGeometry.symmetric(vertical: 10),
                    child: TextField(
                      controller: frPassword,
                      onChanged: (String value) {
                        validatePassword(value);
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        errorText: messagePassword == "" ? "" : messagePassword,
                        filled: true, // Activa el fondo
                        fillColor: AppColors.secondary,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: AppColors.primary,
                        ), // Icono izquierdo
                        hintText: 'Contraseña',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none, // Sin borde exterior
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (!validForm()) {
                        return;
                      }
                      debugPrint(widget.operation.toString());
                      final response = widget.operation == "login"
                          ? await authProvider.Login(
                              frUsername.text,
                              frPhoneNumber.text,
                              frPassword.text,
                            )
                          : await authProvider.Register(
                              frUsername.text,
                              frPhoneNumber.text,
                              frPassword.text,
                            );
                      if (!response) {
                        final errors = authProvider.errorAuth!.errors;
                        for (int i = 0; i < errors!.length; i++) {
                          if (errors[i].path == 'n') {
                            messageUsername = errors[i].message.toString();
                          }
                          if (errors[i].path == 'p') {
                            messagePhoneNumber = errors[i].message.toString();
                          }
                          if (errors[i].path == 'c') {
                            messagePassword = errors[i].message.toString();
                          }
                          setState(() {});
                        }
                        return;
                      }
                      cleanMessages();
                      if(await authProvider.isUser()){
                        context.pushReplacement(Routes.home);
                      }else{
                        debugPrint("hola");
                        context.pushReplacement(Routes.homeDriver);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.background,
                      side: BorderSide(color: AppColors.primary, width: 1),
                      foregroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(
                        horizontal: 150,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(widget.messageButton.toString()),
                  ),
                  SizedBox(height: 20),
              Text(
                "${authProvider.errorAuth?.message != null
                    ? authProvider.errorAuth?.message.toString()
                    : authProvider.isAuth
                    ? ""
                    : ""}",
                style: TextStyle(
                  color: authProvider.isAuth ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                )
              )],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.message.toString()),
                TextButton(
                  onPressed: () {
                    context.push(widget.urlPage.toString());
                  },
                  child: Text(widget.messageLink.toString()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

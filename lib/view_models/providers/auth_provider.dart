
import 'dart:convert';

import 'package:app_ocotaxi/core/constants/app_url.dart';
import 'package:app_ocotaxi/models/driver/drivers_info.dart';
import 'package:app_ocotaxi/models/token_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/erros/erro_auth.dart';
import '../../models/users/basic_info.dart';


class AuthProvider extends ChangeNotifier{
  AuthResponse? _infoBasic;
  bool isAuth = false;
  ErrorAuth? errorAuth;
  TokenService controllerToken = TokenService();

  void AuthBasicInfo(Map<String,dynamic> jsonInfo){
    this._infoBasic = AuthResponse.fromJson(jsonInfo);
    TokenService.saveUserId(_infoBasic!.idUser);
    notifyListeners();
  }

  Future<bool> isUser()async{
    final type = await TokenService.getTypeUser();
    debugPrint("typo: $type");
    return type == 'user';
  }

  Future<bool> logout(BuildContext context) async {
    try {
      await TokenService.deleteTokens();
      return true; // Éxito
    } catch (error) {
      debugPrint("Error al cerrar sesión: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al cerrar sesión: $error")),
      );
      return false; // Fallo
    }
  }

  AuthResponse? get getInfo{
    return _infoBasic;
  }

  Future<String?> getIdUser() async{
    return await TokenService.getUserId();
  }

  Future<bool> Login(String name,String phoneNumber,String password) async {
      try{
        Map<String,dynamic>basic = {
          "username":name,
          "phone":phoneNumber,
          "password":password
        };
        final basic_info = jsonEncode({
          "username":name,
          "phone":phoneNumber,
          "password":password
        });
        final response = await http.post(AppUrl.urlLogin,headers:{
          'Content-Type': 'application/json',
        },body: basic_info);
        final Map<String,dynamic> jsonInfo =  jsonDecode(response.body);
        if(response.statusCode != 200){
          errorAuth = ErrorAuth.fromJson(jsonInfo);
          isAuth = false;
          return false;
        }
        AuthBasicInfo(jsonInfo);
        errorAuth = null;
        isAuth = true;
        TokenService.saveToken(jsonInfo['access_token']['value']);
        TokenService.saveUserId(_infoBasic!.idUser);
        TokenService.saveTypeUser(_infoBasic!.type);
        return true;
      }catch(e){
        debugPrint("$e");
      }
      return false;
  }

  Future<bool> AlreadyTokenExist() async{
    try{
      final String? token = await TokenService.getToken();
      final String? idUser = await TokenService.getUserId();
      debugPrint("token: $token");
      debugPrint("idUser: $idUser");
      if((token!.isEmpty || token == null) && (idUser!.isEmpty || idUser == null)){
        return false;
      }
      return true;
    }catch(e){
      debugPrint("error");
    }

    return false;
  }

  Future<bool> Register(String name,String phoneNumber,String password) async {
    try{
      Map<String,String>data = {
        "username":name,
        "phone":phoneNumber,
        "password":password
      };
      final body = jsonEncode(data);

      final response = await http.post(AppUrl.urlRegister,headers:{
        'Content-Type': 'application/json',
      },body: body);
      final Map<String,dynamic> jsonInfo =  jsonDecode(response.body);
      if(response.statusCode != 200){
        errorAuth = ErrorAuth.fromJson(jsonInfo);
        isAuth = false;
        return false;
      }
      errorAuth = null;
      AuthBasicInfo(jsonInfo['user']);
      isAuth = true;
      TokenService.saveToken(jsonInfo['access_token']['value']);
      TokenService.saveUserId(_infoBasic!.idUser);
      TokenService.saveTypeUser(_infoBasic!.type);
      return true;
    }catch(e){
      debugPrint("$e");
    }
    return false;
  }


}

import 'dart:convert';

import 'package:app_ocotaxi/core/constants/app_url.dart';
import 'package:app_ocotaxi/models/token_storage.dart';
import 'package:app_ocotaxi/models/users/basic_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../models/erros/erro_auth.dart';


class AuthProvider extends ChangeNotifier{
  BasicInfo? _infoBasic;
  bool isAuth = false;
  ErrorAuth? errorAuth;
  TokenService controllerToken = TokenService();

  void AuthBasicInfo(Map<String,dynamic> jsonInfo){
    this._infoBasic = BasicInfo.fromJson(jsonInfo);
    notifyListeners();
  }

  void showData(){
    debugPrint(this._infoBasic?.name);
  }

  Future<bool> Login(String name,String phoneNumber,String password) async {
      try{
        Map<String,String>data = {
          "username":name,
          "phone":phoneNumber,
          "password":password
        };
        final body = jsonEncode(data);

        final response = await http.post(AppUrl.urlLogin,headers:{
          'Content-Type': 'application/json',
        },body: body);
        final Map<String,dynamic> jsonInfo =  jsonDecode(response.body);
        if(response.statusCode != 200){
          errorAuth = ErrorAuth.fromJson(jsonInfo);
          isAuth = false;
          return false;
        }
        AuthBasicInfo(jsonInfo['user']);
        errorAuth = null;
        isAuth = true;
        TokenService.saveToken(jsonInfo['access_token']['value']);
        return true;
      }catch(e){
        debugPrint("$e");
      }
      return false;
  }
  Future<bool> AlreadyTokenExist() async{
    try{
      final String? token = await TokenService.getToken();
      debugPrint("token: $token");
      if(token!.isEmpty || token == null){
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
      return true;
    }catch(e){
      debugPrint("$e");
    }
    return false;
  }


}
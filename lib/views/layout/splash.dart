import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/routes.dart';
import '../../view_models/providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    // Espera a que el widget esté en el árbol de widgets
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final myProvider = Provider.of<AuthProvider>(context, listen: false);
      if(await myProvider.AlreadyTokenExist()){
        handlerNavigator(Routes.home);
      }else{
        handlerNavigator(Routes.login);
      }
    });
  }

  handlerNavigator(String url_route){
    Future.delayed(const Duration(seconds: 3),(){
      context.go(url_route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: FlutterLogo(size: 200,),),);
  }
}

class MyProvider {
}

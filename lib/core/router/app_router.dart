import 'package:app_ocotaxi/core/constants/routes.dart';
import 'package:app_ocotaxi/views/auth/login_screen.dart';
import 'package:app_ocotaxi/views/auth/register_screen.dart';
import 'package:app_ocotaxi/views/componets/layouts/form.dart';
import 'package:app_ocotaxi/views/layout/splash.dart';
import 'package:app_ocotaxi/views/pages/home.dart';
import 'package:app_ocotaxi/views/pages/info_driver.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterApp {
  static final GoRouter routes = GoRouter(
    initialLocation: Routes.splash,
    routes: [
      GoRoute(path: Routes.splash, builder: (context, state) => SplashScreen()),
      GoRoute(path: Routes.login, builder: (context, state) => LoginScreen()),
      GoRoute(path: Routes.register, builder: (context, state) => RegisterScreen(),),
      GoRoute(path: Routes.home,builder: (context,state)=>HomePage()),
      GoRoute(path: '${Routes.infoDriver}/:id',
        builder: (context, state) {
          final idDriver = state.pathParameters['id'];
          return InfoDriverPage(idDriver: idDriver!);
        },
      ),


    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Página no encontrada'))),
  );
}

import 'package:app_ocotaxi/core/router/app_router.dart';
import 'package:app_ocotaxi/view_models/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=>AuthProvider())
  ],child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme:ThemeData(),
      debugShowCheckedModeBanner: false,
      routerConfig: RouterApp.routes,
      title: 'OcoTaxi',
    );
  }
}

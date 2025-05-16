import 'package:app_ocotaxi/views/componets/headers/header_location.dart';
import 'package:app_ocotaxi/views/componets/layouts/nav_bar.dart';
import 'package:app_ocotaxi/views/componets/layouts/titlePage.dart';
import 'package:app_ocotaxi/views/layout/betterDrivers.dart';
import 'package:app_ocotaxi/views/layout/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderLocation(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Titlepage(text1: "Nuestros", text2: "Servicios"),
            SizedBox(height: 10),
            ListService(),
            SizedBox(height: 100,),
            BetterDrivers()
          ],
        ),
      ),
      bottomNavigationBar: NavBar()
    );
  }
}

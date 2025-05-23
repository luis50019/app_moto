import 'package:app_ocotaxi/core/constants/routes.dart';
import 'package:app_ocotaxi/view_models/providers/location/location_provider.dart';
import 'package:app_ocotaxi/views/componets/form/form_service_private.dart';
import 'package:app_ocotaxi/views/componets/headers/header_location.dart';
import 'package:app_ocotaxi/views/componets/layouts/titlePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServicePrivatePage extends StatefulWidget {
  const ServicePrivatePage({super.key});

  @override
  State<ServicePrivatePage> createState() => _ServicePrivatePageState();
}

class _ServicePrivatePageState extends State<ServicePrivatePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const HeaderLocation(url: Routes.home,backButton: true,),
      body: const SingleChildScrollView(
        child: SizedBox(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Titlepage(text1: "Servicio",text2: "Privado"),
              FormServicePrivate()
            ],
          )
        ),
      ),
    );
  }
}
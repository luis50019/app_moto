import 'package:app_ocotaxi/core/constants/routes.dart';
import 'package:app_ocotaxi/view_models/providers/auth_provider.dart';
import 'package:app_ocotaxi/views/componets/headers/header_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';

class PageProfile extends StatefulWidget {
  const PageProfile({super.key});

  @override
  State<PageProfile> createState() => _PageProfileState();
}

class _PageProfileState extends State<PageProfile> {
  @override
  Widget build(BuildContext context) {
    final providerAuth = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      appBar: HeaderLocation(backButton: true),
      body: Container(
        height: 150,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                if (await providerAuth.logout(context)) {
                  context.pushReplacement(Routes.splash);
                } else {
                  context.pushReplacement(Routes.home);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                side: BorderSide(color: AppColors.primary, width: 1),
                foregroundColor: AppColors.background,
                padding: EdgeInsets.symmetric(horizontal: 150, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Cerrar sesion"),
            ),
          ],
        ),
      ),
    );
  }
}

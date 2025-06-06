import 'package:app_ocotaxi/core/constants/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<String> routes = [Routes.home,Routes.mapPage,Routes.profile];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (int index){
        context.push(routes[index]);
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio',),
        BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Explorar',),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
      ],
    );
  }
}

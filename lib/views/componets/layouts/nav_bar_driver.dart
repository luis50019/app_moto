import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/routes.dart';

class NavBarDriver extends StatefulWidget {
  const NavBarDriver({super.key});

  @override
  State<NavBarDriver> createState() => _NavBarDriverState();
}

class _NavBarDriverState extends State<NavBarDriver> {
  List<String> routes = [Routes.homeDriver,Routes.reservationDriver,Routes.profile];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (int index){
        context..go(routes[index]);
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio',),
        BottomNavigationBarItem(icon: Icon(Icons.car_crash), label: 'Reservaciones',),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
      ],
    );
  }
}

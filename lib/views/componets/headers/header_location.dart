import 'package:app_ocotaxi/core/constants/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import '../../../services/location/location_service.dart';

class HeaderLocation extends StatefulWidget implements PreferredSizeWidget {
  final bool backButton;
  final String url;
  const HeaderLocation({super.key,this.url ="", this.backButton = false});

  @override
  Size get preferredSize => const Size.fromHeight(100);
  @override
  State<HeaderLocation> createState() => _HeaderLocationState();
}

class _HeaderLocationState extends State<HeaderLocation> {
  Placemark? location;

  @override
  void initState() {
    super.initState();
    genCurrentLocation();
  }

  void genCurrentLocation() async {
    final placemarks = await getCurrentLocation();
    debugPrint("Termino");
    if (placemarks != null && placemarks.isNotEmpty) {
      setState(() {
        location = placemarks.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(120), // altura del header
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        height: 120,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    widget.backButton == true
                        ? GestureDetector(
                      onTap: () => context.pop(),
                      child: const Icon(Icons.arrow_back, color: Colors.white,size: 35,),
                    ) : const SizedBox.shrink(),
                    SizedBox(width: 10,),
                    const Text(
                      "Ubicación",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 15,
                    ),
                    Text(
                      "${location?.thoroughfare ?? ''}, ${location?.locality ?? ''}",
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

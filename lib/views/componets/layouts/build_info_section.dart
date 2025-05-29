import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/constants/app_colors.dart';

class BuildInfoSection extends StatefulWidget {
  final String title;
  final LatLng content;
  const BuildInfoSection({super.key, required this.title, required this.content});

  @override
  State<BuildInfoSection> createState() => _BuildInfoSectionState();
}

class _BuildInfoSectionState extends State<BuildInfoSection> {
  Placemark? placeDirection;
  bool isLoading = true;  // Indicador para saber si está cargando

  @override
  void initState() {
    super.initState();
    _fetchDirection();  // Llamamos el método para obtener la dirección
  }

  void _fetchDirection() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        widget.content.latitude,
        widget.content.longitude,
      );
      setState(() {
        placeDirection = placemarks.first;
        isLoading = false;  // Terminó de cargar
      });
    } catch (e) {
      print("Error obteniendo dirección: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 25,
            color: AppColors.textOrange,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        isLoading
            ? Text("Cargando dirección...")  // Mensaje mientras carga
            : placeDirection != null
            ? Text(
          "${placeDirection!.street}, ${placeDirection!.locality}",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        )
            : Text("No se pudo obtener la dirección"),  // Si hay error
      ],
    );
  }
}

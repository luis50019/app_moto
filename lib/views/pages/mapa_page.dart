import 'dart:async';
import 'dart:convert';

import 'package:app_ocotaxi/core/constants/routes.dart';
import 'package:app_ocotaxi/view_models/providers/location/location_destine.dart';
import 'package:app_ocotaxi/views/componets/headers/header_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../view_models/providers/location/location_provider.dart';
import '../../view_models/providers/services/reservation_provider.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({super.key,});

  @override
  State<MapaPage> createState() => _OpenStreetMapScreenState();
}

class _OpenStreetMapScreenState extends State<MapaPage> {
  final MapController _mapController = MapController();
  final Location _location = Location();
  final TextEditingController _locationController = TextEditingController();
  late final StreamSubscription<LocationData> _locationSubscription;
  bool isLoading = true;
  LatLng? _currentLocation;
  LatLng? _destination;
  bool _locationFound = false;
  List<LatLng> _route = [];

  @override
  void initState() {
    super.initState();
    _initializeLocation();
    _checkExistingDestination();
  }
  @override
  void dispose() {
    _locationSubscription.cancel();
    _locationController.dispose();
    super.dispose();
  }


  Future<void> _initializeLocation() async {
    if (!await _checktheRequestPermissions()) return;

    _locationSubscription = _location.onLocationChanged.listen((LocationData locationDate) {
      if (locationDate.latitude != null && locationDate.longitude != null) {
        if (!mounted) return;
        setState(() {
          _currentLocation = LatLng(
            locationDate.latitude!,
            locationDate.longitude!,
          );
          isLoading = false;
        });
      }
    });
  }

  void _checkExistingDestination() {
    final coordsProvider = Provider.of<LocationDestine>(context, listen: false);
    if (coordsProvider.destination != null) {
      _fetchRoute(); // Si ya hay un destino configurado, traza la ruta
    }
  }

  //metodod para hacer el feching de datos
  Future<void> _fetchCoordinatesPoint(String calleQuery) async {
    // Coordenadas más precisas para Ocotlán de Morelos (ajustadas)
    final double ocotlanMinLat = 16.770308;
    final double ocotlanMaxLat = 16.802461;
    final double ocotlanMinLon = -96.675062;
    final double ocotlanMaxLon = -96.672635;

    final nominatimUrl = Uri.parse(
      "https://nominatim.openstreetmap.org/search?"
          "q=$calleQuery, Ocotlán de Morelos, Oaxaca, México"
          "&format=json"
          "&addressdetails=1"
          "&limit=10"
          "&bounded=1"
          "&polygon_geojson=1"
          "&namedetails=1"
          "&viewbox=${ocotlanMinLon},${ocotlanMaxLat},${ocotlanMaxLon},${ocotlanMinLat}"
          "&street=",
    );

    try {
      final response = await http.get(
        nominatimUrl,
        headers: {"User-Agent": "MyFlutterApp/1.0"},
      );

      debugPrint(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> results = jsonDecode(response.body);
        List<Map<String, dynamic>> callesOcotlan = [];

        for (final place in results) {
          // Parseo de alta precisión (7 decimales)
          final lat = double.parse((place['lat'] as String));
          final lon = double.parse((place['lon'] as String));
          callesOcotlan.add({
            'name': place['display_name'],
            'lat': lat,
            'lon': lon,
            'osm_type': place['osm_type'],
            'class': place['class'],
          });
        }

        if (callesOcotlan.isNotEmpty) {
          callesOcotlan.sort((a, b) {
            if (a['osm_type'] == 'node' && b['osm_type'] != 'node') return -1;
            if (a['osm_type'] != 'node' && b['osm_type'] == 'node') return 1;
            return 0;
          });

          final bestResult = callesOcotlan.first;
          final preciseLatLng = LatLng(
            bestResult['lat'],
            bestResult['lon'],
          );

          setState(() {
            _destination = preciseLatLng;
          });

          Provider.of<LocationDestine>(context, listen: false).setDestination(
            preciseLatLng,
            name: bestResult['name'],
          );
          
          final locationUser = Provider.of<LocationProvider>(context, listen: false,);
          await locationUser.getLocationUser();
          final destinationProvider = Provider.of<LocationDestine>(context, listen: false,);
          final reservationProvider = Provider.of<ReservationProvider>(context, listen: false,);

          if (destinationProvider.alreadyExistLocation()) {
            double distance = locationUser.calculateDistance(
              destinationProvider.getDestination,
            );
            reservationProvider.setDistanceTrip(distance);
            reservationProvider.getFee();
          }

          await _fetchRoute();
          _mapController.move(preciseLatLng, 18); // Mayor zoom para precisión
        } else {
          errorMessage("No se encontró '$calleQuery' en Ocotlán de Morelos");
        }
      } else {
        errorMessage("Error en la búsqueda: ${response.statusCode}");
      }
    } catch (e) {
      errorMessage("Error: ${e.toString()}");
      debugPrint("StackTrace: ${e.toString()}");
    }
  }

  Future<void> _fetchRoute() async {
    if (_currentLocation == null || _destination == null) return;

    // Usar geometría de alta precisión
    final url = Uri.parse(
      "http://router.project-osrm.org/route/v1/driving/"
          '${_currentLocation!.longitude.toStringAsFixed(7)},'
          '${_currentLocation!.latitude.toStringAsFixed(7)};'
          '${_destination!.longitude.toStringAsFixed(7)},'
          '${_destination!.latitude.toStringAsFixed(7)}'
          '?overview=full&geometries=polyline&steps=true',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['routes'] != null && data['routes'].isNotEmpty) {
          final geometry = data['routes'][0]['geometry'];
          _decodePolyline(geometry);
          setState(() {
            _locationFound = true;
          });

          // Ajuste fino del zoom basado en la distancia
          final distance = data['routes'][0]['distance']; // en metros
          final zoomLevel = distance < 1000.0 ? 18.0 : distance < 5000 ? 16.0 : 14.0;
          _mapController.move(_destination!, zoomLevel);
        }
      } else {
        errorMessage("Fallo al obtener las rutas: ${response.statusCode}");
      }
    } catch (e) {
      errorMessage("Error al trazar ruta: ${e.toString()}");
    }
  }

  void _decodePolyline(String encodedPolyline) {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodePoints = polylinePoints.decodePolyline(
      encodedPolyline,
    );
    setState(() {
      _route = decodePoints
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    });
  }

  //metodo para checar los persmisos de ubicacion
  Future<bool> _checktheRequestPermissions() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return false;
    }
    return true;
  }

  Future<void> _userCurrentLocations() async {
    if (_currentLocation != null) {
      _mapController.move(_currentLocation!, 15);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Al ubicacion no es obtenida")),
      );
    }
  }

  void errorMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<ReservationProvider>(context);
    return Scaffold(
      appBar: HeaderLocation(backButton: true),
      body: Stack(
        children: [
          isLoading
              ? Center(child: CircularProgressIndicator())
              : FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: _currentLocation ?? LatLng(16.7865, -96.6738),
                    initialZoom: 16,
                    minZoom: 16,
                    maxZoom: 50,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      maxZoom: 19,
                      minZoom: 12,
                    ),
                    CurrentLocationLayer(
                      style: const LocationMarkerStyle(
                        marker: DefaultLocationMarker(
                          child: Icon(
                            Icons.location_pin,
                            color: Colors.deepOrange,
                          ),
                        ),
                        markerSize: Size(35, 35),
                        markerDirection: MarkerDirection.heading,
                      ),
                    ),
                    if (_destination != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: _destination!,
                            width: 50,
                            height: 50,
                            child: const Icon(
                              Icons.location_pin,
                              size: 40,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    if (_currentLocation != null &&
                        _destination != null &&
                        _route.isNotEmpty)
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: _route,
                            strokeWidth: 5,
                            color: Colors.red,
                          ),
                        ],
                      ),
                  ],
                ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter a location',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    style: IconButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      final location = _locationController.text.trim();
                      if (location.isNotEmpty) {
                        _fetchCoordinatesPoint(location);
                      }
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
          ),
          if(_locationFound) Positioned(
            bottom: 80,
            left: 20,
            right: 20,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  context.push(Routes.reservationPrivate);
                },
                child: const Text(
                  "Aceptar destino",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _userCurrentLocations(),
        backgroundColor: Colors.black38,
        child: Icon(Icons.my_location, size: 30, color: Colors.white),
      ),
    );
  }
}

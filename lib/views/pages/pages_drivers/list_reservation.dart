import 'dart:async';

import 'package:app_ocotaxi/views/pages/pages_drivers/reservations_drivers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/driver/reservations_response.dart';
import '../../../services/drivers/driverService.dart';
import '../../../view_models/providers/auth_provider.dart';
import '../../../view_models/providers/driver/driver_provider.dart';
import '../../componets/headers/header_location.dart';
import '../../componets/layouts/nav_bar_driver.dart';
import '../../componets/layouts/titlePage.dart';

class ListReservation extends StatefulWidget {
  const ListReservation({super.key});

  @override
  State<ListReservation> createState() => _ListReservationState();
}

class _ListReservationState extends State<ListReservation> {
  Timer? _refreshTimer;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _initRefreshTimer();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await loadReservations();
    } catch (e) {
      setState(() {
        _errorMessage = "Error al cargar reservaciones";
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _initRefreshTimer() {
    _refreshTimer = Timer.periodic(
      const Duration(seconds: 5),
          (_) => loadReservations(),
    );
  }

  Future<void> loadReservations() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final driverProvider = Provider.of<DriverProvider>(context, listen: false);

      String? id = await authProvider.getIdUser();
      if (id != null) {
        ReservationsResponse? data = await DriverService.getAllReservations(id);
        driverProvider.setReservations(data);
        _isLoading = false;
      }
    } catch (e) {
      debugPrint("Error al actualizar reservaciones: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al actualizar: ${e.toString()}")),
        );
      }
    }
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.textOrange),
          ),
          const SizedBox(height: 20),
          Text(
            "Cargando reservaciones...",
            style: TextStyle(
              color: AppColors.textOrange,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 50, color: Colors.red),
          const SizedBox(height: 20),
          Text(
            _errorMessage ?? "Ocurrió un error",
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _loadInitialData,
            child: const Text("Reintentar"),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final driverProvider = Provider.of<DriverProvider>(context);

    if (driverProvider.getData == null || driverProvider.getData!.data.isEmpty) {
      return Center(
        child: Text(
          "No hay reservaciones disponibles",
          style: TextStyle(color: AppColors.textOrange),
        ),
      );
    }

    return ReservationsDrivers(
      reservations: driverProvider.getData!.data,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderLocation(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              const Titlepage(text1: "Solicitudes", text2: "de viaje"),
              Expanded(
                child: _isLoading
                    ? _buildLoadingScreen()
                    : _errorMessage != null
                    ? _buildErrorScreen()
                    : _buildContent(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBarDriver(),
    );
  }
}

import 'dart:async';
import 'package:app_ocotaxi/core/constants/routes.dart';
import 'package:app_ocotaxi/views/componets/headers/header_location.dart';
import 'package:app_ocotaxi/views/componets/layouts/nav_bar_driver.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/reservation/reservation_services.dart';
import '../../../view_models/providers/driver/driver_provider.dart';
import '../../../view_models/providers/location/location_destine.dart';
import '../../../view_models/providers/services/reservation_provider.dart';

class PageTrip extends StatefulWidget {
  const PageTrip({super.key});

  @override
  State<PageTrip> createState() => _PageTripState();
}

class _PageTripState extends State<PageTrip> {
  final TextEditingController _codeController = TextEditingController();
  Timer? _reservationTimer;
  bool _isLoading = false;
  bool _isCodeVerified = false;
  String _verificationMessage = '';
  Color _verificationMessageColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    _startReservationTimer();
  }

  void _startReservationTimer() {
    _reservationTimer?.cancel();
    _reservationTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _checkReservationStatus();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkReservationStatus();
    });
  }

  Future<void> _checkReservationStatus() async {
    final reservation = Provider.of<DriverProvider>(context, listen: false);
    final String? id = await reservation.getReservation;
    if (id != null) {
      final data = await ReservationService.findReservation(id);
      if (data == null) {
        reservation.setStatus();
      } else {
        reservation.createNewReservation(data);
      }
    }
  }

  Future<void> _verifyCode() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _verificationMessage = '';
    });

    try {
      final reservation = Provider.of<ReservationProvider>(context, listen: false).getReservation;
      final enteredCode = _codeController.text.trim();
      final correctCode = reservation?.data.security.codeVerification ?? '';

      await Future.delayed(const Duration(seconds: 1)); // Simulación de verificación

      if (enteredCode == correctCode) {
        setState(() {
          _isCodeVerified = true;
          _verificationMessage = 'Código verificado correctamente';
          _verificationMessageColor = Colors.green;
        });
        // Aquí iría la lógica para confirmar el viaje
      } else {
        setState(() {
          _verificationMessage = 'Código incorrecto, intenta nuevamente';
          _verificationMessageColor = Colors.red;
        });
      }
    } catch (e) {
      setState(() {
        _verificationMessage = 'Error al verificar el código';
        _verificationMessageColor = Colors.red;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _cancelTrip() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancelar viaje'),
        content: const Text('¿Estás seguro de que deseas cancelar este viaje?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final reservation = Provider.of<ReservationProvider>(context, listen: false);
              final String? id = await reservation.getidReservation;
              if (id != null) {
                await ReservationService.CancelReservation(id);
                final location = Provider.of<LocationDestine>(context, listen: false);
                location.cancelTrip();
                reservation.cancelReservation();
              }
            },
            child: const Text('Sí, cancelar'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    _reservationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reservation = Provider.of<ReservationProvider>(context).getReservation;
    final tripStatus = reservation?.data.state.general ?? 'pendiente';

    return Scaffold(
      appBar: HeaderLocation(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Estado del viaje
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    'Estado del viaje',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    tripStatus.toUpperCase(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _getStatusColor(tripStatus),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Código de verificación
            const Text(
              'Ingresa el código de verificación',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),

            // Mostrar código real (solo para desarrollo/demo)
            if (reservation != null)
              Text(
                'Código real: ${reservation.data.security.codeVerification}',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
                textAlign: TextAlign.center,
              ),

            const SizedBox(height: 20),

            // Campo de entrada para el código
            TextField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 6,
              decoration: InputDecoration(
                hintText: '123456',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabled: !_isCodeVerified,
              ),
              style: const TextStyle(fontSize: 24, letterSpacing: 2),
            ),

            const SizedBox(height: 10),

            // Mensaje de verificación
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _verificationMessageColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                _verificationMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _verificationMessageColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Botón de verificación
            ElevatedButton(
              onPressed: _isCodeVerified ? null : _verifyCode,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.blue,
                disabledBackgroundColor: Colors.green,
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                _isCodeVerified ? 'CÓDIGO VERIFICADO' : 'VERIFICAR CÓDIGO',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Botón de cancelar
            OutlinedButton(
              onPressed: _cancelTrip,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: const BorderSide(color: Colors.red),
              ),
              child: const Text(
                'CANCELAR VIAJE',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBarDriver(),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pendiente':
        return Colors.orange;
      case 'confirmado':
        return Colors.green;
      case 'cancelado':
        return Colors.red;
      case 'completado':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
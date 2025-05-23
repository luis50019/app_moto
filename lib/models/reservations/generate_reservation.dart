import 'dart:convert';

import 'package:latlong2/latlong.dart';

class ReservationResponse {
  final String message;
  final bool status;
  final ReservationData data;

  ReservationResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory ReservationResponse.fromJson(Map<String, dynamic> json) {
    return ReservationResponse(
      message: json['message'],
      status: json['status'],
      data: ReservationData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'status': status,
    'data': data.toJson(),
  };

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class ReservationData {
  final String passage;
  final String driver;
  final String rate;
  final Route route;
  final ReservationState state;
  final Security security;
  final Pay pay;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  ReservationData({
    required this.passage,
    required this.driver,
    required this.rate,
    required this.route,
    required this.state,
    required this.security,
    required this.pay,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ReservationData.fromJson(Map<String, dynamic> json) {
    return ReservationData(
      passage: json['passage'],
      driver: json['driver'],
      rate: json['rate'],
      route: Route.fromJson(json['route']),
      state: ReservationState.fromJson(json['state']),
      security: Security.fromJson(json['security']),
      pay: Pay.fromJson(json['pay']),
      id: json['_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() => {
    'passage': passage,
    'driver': driver,
    'rate': rate,
    'route': route.toJson(),
    'state': state.toJson(),
    'security': security.toJson(),
    'pay': pay.toJson(),
    '_id': id,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    '__v': v,
  };
}

class Route {
  final LocationPoint destination;
  final LocationPoint start;
  final int distance; // en metros

  Route({
    required this.destination,
    required this.start,
    required this.distance,
  });

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      destination: LocationPoint.fromJson(json['destination']),
      start: LocationPoint.fromJson(json['start']),
      distance: json['distance'],
    );
  }

  Map<String, dynamic> toJson() => {
    'destination': destination.toJson(),
    'start': start.toJson(),
    'distance': distance,
  };

  // Método adicional para obtener distancia en km
  double get distanceInKm => distance / 1000;
}

class LocationPoint {
  final double lat;
  final double lng;

  LocationPoint({
    required this.lat,
    required this.lng,
  });

  factory LocationPoint.fromJson(Map<String, dynamic> json) {
    return LocationPoint(
      lat: json['lat'].toDouble(),
      lng: json['lng'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'lat': lat,
    'lng': lng,
  };

  // Convertir a LatLng para usar con flutter_map
  LatLng toLatLng() => LatLng(lat, lng);
}

class ReservationState {
  final String general;

  ReservationState({
    required this.general,
  });

  factory ReservationState.fromJson(Map<String, dynamic> json) {
    return ReservationState(
      general: json['general'],
    );
  }

  Map<String, dynamic> toJson() => {
    'general': general,
  };

  bool get isPending => general == 'pendiente';
  bool get isCompleted => general == 'completado';
  bool get isCancelled => general == 'cancelado';
}

class Security {
  final String codeVerification;

  Security({
    required this.codeVerification,
  });

  factory Security.fromJson(Map<String, dynamic> json) {
    return Security(
      codeVerification: json['codeVerification'],
    );
  }

  Map<String, dynamic> toJson() => {
    'codeVerification': codeVerification,
  };
}

class Pay {
  final String methodo;
  final String state;

  Pay({
    required this.methodo,
    required this.state,
  });

  factory Pay.fromJson(Map<String, dynamic> json) {
    return Pay(
      methodo: json['methodo'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() => {
    'methodo': methodo,
    'state': state,
  };

  bool get isPending => state == 'pendiente';
  bool get isPaid => state == 'pagado';
  bool get isCash => methodo == 'efectivo';
  bool get isCard => methodo == 'tarjeta';
}
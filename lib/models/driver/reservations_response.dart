class ReservationsResponse {
  final String message;
  final bool status;
  final List<Reservation> data;

  ReservationsResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory ReservationsResponse.fromJson(Map<String, dynamic> json) {
    return ReservationsResponse(
      message: json['message'] ?? '',
      status: json['status'] ?? false,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => Reservation.fromJson(item))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

// Modelo para una reservación individual
class Reservation {
  final Route route;
  final ReservationState state;
  final Security security;
  final Pay pay;
  final String id;
  final Passage passage;
  final Driver driver;
  final Rate rate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Reservation({
    required this.route,
    required this.state,
    required this.security,
    required this.pay,
    required this.id,
    required this.passage,
    required this.driver,
    required this.rate,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      route: Route.fromJson(json['route']),
      state: ReservationState.fromJson(json['state']),
      security: Security.fromJson(json['security']),
      pay: Pay.fromJson(json['pay']),
      id: json['_id'] ?? '',
      passage: Passage.fromJson(json['passage']),
      driver: Driver.fromJson(json['driver']),
      rate: Rate.fromJson(json['rate']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'route': route.toJson(),
      'state': state.toJson(),
      'security': security.toJson(),
      'pay': pay.toJson(),
      '_id': id,
      'passage': passage.toJson(),
      'driver': driver.toJson(),
      'rate': rate.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}

// Modelo para la ruta
class Route {
  final Location destination;
  final Location start;
  final int distance;

  Route({
    required this.destination,
    required this.start,
    required this.distance,
  });

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      destination: Location.fromJson(json['destination']),
      start: Location.fromJson(json['start']),
      distance: json['distance'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'destination': destination.toJson(),
      'start': start.toJson(),
      'distance': distance,
    };
  }
}

class Location {
  final double lat;
  final double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}

// Modelo para el estado de la reservación
class ReservationState {
  final String general;

  ReservationState({
    required this.general,
  });

  factory ReservationState.fromJson(Map<String, dynamic> json) {
    return ReservationState(
      general: json['general'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'general': general,
    };
  }
}

class Security {
  final String codeVerification;

  Security({
    required this.codeVerification,
  });

  factory Security.fromJson(Map<String, dynamic> json) {
    return Security(
      codeVerification: json['codeVerification'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codeVerification': codeVerification,
    };
  }
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
      methodo: json['methodo'] ?? '',
      state: json['state'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'methodo': methodo,
      'state': state,
    };
  }
}

// MODELOS ADICIONALES PARA passage, driver, y rate

class Passage {
  final String id;
  final String name;
  final String phoneNumber;
  final String profilePicture;

  Passage({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.profilePicture,
  });

  factory Passage.fromJson(Map<String, dynamic> json) {
    return Passage(
      id: json['_id'] ?? '',
      name: json['basic_info']['name'] ?? '',
      phoneNumber: json['basic_info']['phone']['number'] ?? '',
      profilePicture: json['basic_info']['profile_picture'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'basic_info': {
        'name': name,
        'phone': {'number': phoneNumber},
        'profile_picture': profilePicture,
      },
    };
  }
}

class Driver {
  final String id;
  final String name;
  final String phoneNumber;
  final String profilePicture;
  final int rating;

  Driver({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.profilePicture,
    required this.rating,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['_id'] ?? '',
      name: json['basic_info']['name'] ?? '',
      phoneNumber: json['basic_info']['phone']['number'] ?? '',
      profilePicture: json['basic_info']['profile_picture'] ?? '',
      rating: json['rating'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'basic_info': {
        'name': name,
        'phone': {'number': phoneNumber},
        'profile_picture': profilePicture,
      },
      'rating': rating,
    };
  }
}

class Rate {
  final String id;
  final double price;
  final bool isActive;

  Rate({
    required this.id,
    required this.price,
    required this.isActive,
  });

  factory Rate.fromJson(Map<String, dynamic> json) {
    return Rate(
      id: json['_id'] ?? '',
      price: json['pricingType']['global']['price']?.toDouble() ?? 0.0,
      isActive: json['pricingType']['global']['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'pricingType': {
        'global': {'price': price, 'isActive': isActive},
      },
    };
  }
}

class DriverResponse {
  final List<User> data;

  DriverResponse({required this.data});

  factory DriverResponse.fromJson(Map<String, dynamic> json) {
    return DriverResponse(
      data: (json['data'] as List).map((item) => User.fromJson(item)).toList(),
    );
  }
}

class User {
  final BasicInfo basicInfo;
  final Operation operation;
  final UserLocation location;
  final Preferences preferences;
  final String id;
  final double rating;
  final List<dynamic> reminders;
  final int v;

  User({
    required this.basicInfo,
    required this.operation,
    required this.location,
    required this.preferences,
    required this.id,
    required this.rating,
    required this.reminders,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      basicInfo: BasicInfo.fromJson(json['basic_info']),
      operation: Operation.fromJson(json['operation']),
      location: UserLocation.fromJson(json['location']),
      preferences: Preferences.fromJson(json['preferences']),
      id: json['_id'],
      rating: (json['rating'] as num).toDouble(),
      reminders: json['reminders'] ?? [],
      v: json['__v'] ?? 0,
    );
  }

}

class BasicInfo {
  final Email email;
  final Phone phone;
  final String name;
  final String password;
  final String profilePicture;
  final String languagePreference;

  BasicInfo({
    required this.email,
    required this.phone,
    required this.name,
    required this.password,
    required this.profilePicture,
    required this.languagePreference,
  });

  factory BasicInfo.fromJson(Map<String, dynamic> json) {
    return BasicInfo(
      email: Email.fromJson(json['email']),
      phone: Phone.fromJson(json['phone']),
      name: json['name'] ?? '',
      password: json['password'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
      languagePreference: json['language_preference'] ?? '',
    );
  }
}

class Email {
  final String address;
  final bool verified;

  Email({
    required this.address,
    required this.verified,
  });

  factory Email.fromJson(Map<String, dynamic> json) {
    return Email(
      address: json['address'] ?? '',
      verified: json['verified'] ?? false,
    );
  }
}

class Phone {
  final String number;
  final String countryCode;
  final bool verified;

  Phone({
    required this.number,
    required this.countryCode,
    required this.verified,
  });

  factory Phone.fromJson(Map<String, dynamic> json) {
    return Phone(
      number: json['number'] ?? '',
      countryCode: json['country_code'] ?? '',
      verified: json['verified'] ?? false,
    );
  }
}

class Operation {
  final List<dynamic> activeZones;
  final List<dynamic> schedules;

  Operation({required this.activeZones, required this.schedules});

  factory Operation.fromJson(Map<String, dynamic> json) {
    return Operation(
      activeZones: json['active_zones'] ?? [],
      schedules: json['schedules'] ?? [],
    );
  }
}

class UserLocation {
  final List<dynamic> history;

  UserLocation({required this.history});

  factory UserLocation.fromJson(Map<String, dynamic> json) {
    return UserLocation(
      history: json['history'] ?? [],
    );
  }
}

class Preferences {
  final List<dynamic> tags;

  Preferences({required this.tags});

  factory Preferences.fromJson(Map<String, dynamic> json) {
    return Preferences(
      tags: json['tags'] ?? [],
    );
  }
}

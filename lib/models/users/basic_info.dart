class AuthResponse {
  final User user;
  final String idUser;
  final String type;
  final AccessToken accessToken;
  final String message;

  AuthResponse({
    required this.user,
    required this.idUser,
    required this.type,
    required this.accessToken,
    required this.message,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: User.fromJson(json['user'] ?? {}), // Manejo de nulo
      idUser: json['id_user']?.toString() ?? '', // Conversión segura
      type: json['type']?.toString() ?? 'user', // Valor por defecto
      accessToken: AccessToken.fromJson(json['access_token'] ?? {}), // Manejo de nulo
      message: json['message']?.toString() ?? '', // Conversión segura
    );
  }
}

class User {
  final Email? email; // Cambiado a nullable
  final Phone phone;
  final String name;
  final String password;
  final String languagePreference;
  final String? profilePicture;

  User({
    this.email, // Ya no es required
    required this.phone,
    required this.name,
    required this.password,
    required this.languagePreference,
    this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] != null && json['email']['address']?.toString().isNotEmpty == true
          ? Email.fromJson(json['email'])
          : null, // Solo crea Email si tiene datos
      phone: Phone.fromJson(json['phone'] ?? {}),
      name: json['name']?.toString() ?? '',
      password: json['password']?.toString() ?? '',
      languagePreference: json['language_preference']?.toString() ?? 'es_MX',
      profilePicture: json['profile_picture']?.toString(),
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
      address: json['address']?.toString() ?? '',
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
      number: json['number']?.toString() ?? '',
      countryCode: json['country_code']?.toString() ?? '+52',
      verified: json['verified'] ?? false,
    );
  }
}

class AccessToken {
  final String name;
  final String value;

  AccessToken({
    required this.name,
    required this.value,
  });

  factory AccessToken.fromJson(Map<String, dynamic> json) {
    return AccessToken(
      name: json['name']?.toString() ?? 'access_token',
      value: json['value']?.toString() ?? '',
    );
  }
}
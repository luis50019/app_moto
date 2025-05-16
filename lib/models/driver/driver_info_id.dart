class DriverDetailResponse {
  final User data;
  final List<Review> reviews;

  DriverDetailResponse({required this.data, required this.reviews});

  factory DriverDetailResponse.fromJson(Map<String, dynamic> json) {
    return DriverDetailResponse(
      data: User.fromJson(json['data']),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class User {
  final BasicInfo basicInfo;
  final Operation operation;
  final UserLocation location;
  final Preferences preferences;
  final String id;
  final String name;
  final String phoneNumber;
  final String password;
  final double rating;
  final List<dynamic> reminders;
  final int v;

  User({
    required this.basicInfo,
    required this.operation,
    required this.location,
    required this.preferences,
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.password,
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
      name: json['basic_info']['name'] ?? '',
      phoneNumber: json['basic_info']['phone']['number'] ?? '',
      password: json['basic_info']['password'] ?? '',
      rating: json['rating'] ?? 0,
      reminders: json['reminders'] ?? [],
      v: json['__v'] ?? 0,
    );
  }
}

class BasicInfo {
  final Email email;
  final Phone phone;
  final String languagePreference;
  final String name;
  final String password;
  final String profilePicture;

  BasicInfo({
    required this.email,
    required this.phone,
    required this.languagePreference,
    required this.name,
    required this.password,
    required this.profilePicture,
  });

  factory BasicInfo.fromJson(Map<String, dynamic> json) {
    return BasicInfo(
      email: Email.fromJson(json['email']),
      phone: Phone.fromJson(json['phone']),
      languagePreference: json['language_preference'] ?? '',
      name: json['name'] ?? '',
      password: json['password'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
    );
  }
}

class Email {
  final bool verified;

  Email({required this.verified});

  factory Email.fromJson(Map<String, dynamic> json) {
    return Email(verified: json['verified'] ?? false);
  }
}

class Phone {
  final String countryCode;
  final String number;
  final bool verified;

  Phone({
    required this.countryCode,
    required this.number,
    required this.verified,
  });

  factory Phone.fromJson(Map<String, dynamic> json) {
    return Phone(
      countryCode: json['country_code'] ?? '',
      number: json['number'] ?? '',
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
    return UserLocation(history: json['history'] ?? []);
  }
}

class Preferences {
  final List<dynamic> tags;

  Preferences({required this.tags});

  factory Preferences.fromJson(Map<String, dynamic> json) {
    return Preferences(tags: json['tags'] ?? []);
  }
}

class Review {
  final Participants participants;
  final ReviewContent content;
  final ReviewMetadata metadata;
  final ReviewVisibility visibility;
  final ReviewAnalytics analytics;
  final String id;
  final String createdAt;
  final String updatedAt;
  final int v;

  Review({
    required this.participants,
    required this.content,
    required this.metadata,
    required this.visibility,
    required this.analytics,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      participants: Participants.fromJson(json['participants']),
      content: ReviewContent.fromJson(json['content']),
      metadata: ReviewMetadata.fromJson(json['metadata']),
      visibility: ReviewVisibility.fromJson(json['visibility']),
      analytics: ReviewAnalytics.fromJson(json['analytics']),
      id: json['_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}

class Participants {
  final String driverId;
  final String passengerId;

  Participants({required this.driverId, required this.passengerId});

  factory Participants.fromJson(Map<String, dynamic> json) {
    return Participants(
      driverId: json['driver_id'],
      passengerId: json['passenger_id'],
    );
  }
}

class ReviewContent {
  final Rating rating;
  final String comment;
  final List<dynamic> photos;

  ReviewContent({
    required this.rating,
    required this.comment,
    required this.photos,
  });

  factory ReviewContent.fromJson(Map<String, dynamic> json) {
    return ReviewContent(
      rating: Rating.fromJson(json['rating']),
      comment: json['comment'],
      photos: json['photos'] ?? [],
    );
  }
}

class Rating {
  final RatingCategories categories;
  final int overall;

  Rating({required this.categories, required this.overall});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      categories: RatingCategories.fromJson(json['categories']),
      overall: json['overall'],
    );
  }
}

class RatingCategories {
  final int punctuality;
  final int vehicle;
  final int driving;

  RatingCategories({
    required this.punctuality,
    required this.vehicle,
    required this.driving,
  });

  factory RatingCategories.fromJson(Map<String, dynamic> json) {
    return RatingCategories(
      punctuality: json['punctuality'],
      vehicle: json['vehicle'],
      driving: json['driving'],
    );
  }
}

class ReviewMetadata {
  final String date;

  ReviewMetadata({required this.date});

  factory ReviewMetadata.fromJson(Map<String, dynamic> json) {
    return ReviewMetadata(date: json['date']);
  }
}

class ReviewVisibility {
  final bool isPublic;
  final bool hideName;

  ReviewVisibility({required this.isPublic, required this.hideName});

  factory ReviewVisibility.fromJson(Map<String, dynamic> json) {
    return ReviewVisibility(
      isPublic: json['public'],
      hideName: json['hide_name'],
    );
  }
}

class ReviewAnalytics {
  final List<dynamic> keywords;

  ReviewAnalytics({required this.keywords});

  factory ReviewAnalytics.fromJson(Map<String, dynamic> json) {
    return ReviewAnalytics(keywords: json['keywords'] ?? []);
  }
}

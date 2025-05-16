import 'package:json_annotation/json_annotation.dart';

part 'basic_info.g.dart';

@JsonSerializable()
class BasicInfo {
  final String name;
  final String password;

  @JsonKey(name: 'language_preference')
  final String languagePreference;

  @JsonKey(name: 'profile_picture')
  final String profilePicture;

  final Email email;
  final Phone phone;

  BasicInfo({
    required this.name,
    required this.password,
    required this.languagePreference,
    required this.profilePicture,
    required this.email,
    required this.phone,
  });

  factory BasicInfo.fromJson(Map<String, dynamic> json) =>
      _$BasicInfoFromJson(json);

  Map<String, dynamic> toJson() => _$BasicInfoToJson(this);
}

@JsonSerializable()
class Email {
  final String address;
  final bool verified;

  Email({
    required this.address,
    required this.verified,
  });

  factory Email.fromJson(Map<String, dynamic> json) => _$EmailFromJson(json);
  Map<String, dynamic> toJson() => _$EmailToJson(this);
}

@JsonSerializable()
class Phone {
  final String number;

  @JsonKey(name: 'country_code')
  final String countryCode;

  final bool verified;

  Phone({
    required this.number,
    required this.countryCode,
    required this.verified,
  });

  factory Phone.fromJson(Map<String, dynamic> json) => _$PhoneFromJson(json);
  Map<String, dynamic> toJson() => _$PhoneToJson(this);
}

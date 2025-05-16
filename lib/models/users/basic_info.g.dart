// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicInfo _$BasicInfoFromJson(Map<String, dynamic> json) => BasicInfo(
  name: json['name'] as String,
  password: json['password'] as String,
  languagePreference: json['language_preference'] as String,
  profilePicture: json['profile_picture'] as String,
  email: Email.fromJson(json['email'] as Map<String, dynamic>),
  phone: Phone.fromJson(json['phone'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BasicInfoToJson(BasicInfo instance) => <String, dynamic>{
  'name': instance.name,
  'password': instance.password,
  'language_preference': instance.languagePreference,
  'profile_picture': instance.profilePicture,
  'email': instance.email,
  'phone': instance.phone,
};

Email _$EmailFromJson(Map<String, dynamic> json) => Email(
  address: json['address'] as String,
  verified: json['verified'] as bool,
);

Map<String, dynamic> _$EmailToJson(Email instance) => <String, dynamic>{
  'address': instance.address,
  'verified': instance.verified,
};

Phone _$PhoneFromJson(Map<String, dynamic> json) => Phone(
  number: json['number'] as String,
  countryCode: json['country_code'] as String,
  verified: json['verified'] as bool,
);

Map<String, dynamic> _$PhoneToJson(Phone instance) => <String, dynamic>{
  'number': instance.number,
  'country_code': instance.countryCode,
  'verified': instance.verified,
};

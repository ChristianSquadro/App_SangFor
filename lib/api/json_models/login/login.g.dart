// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) {
  return Login(
    Access.fromJson(json['access'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'access': instance.access.toJson(),
    };

Access _$AccessFromJson(Map<String, dynamic> json) {
  return Access(
    Token.fromJson(json['token'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AccessToJson(Access instance) => <String, dynamic>{
      'token': instance.token.toJson(),
    };

Token _$TokenFromJson(Map<String, dynamic> json) {
  return Token(
    json['issued_at'] as String,
    json['expires'] as String,
    json['id'] as String,
  );
}

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'issued_at': instance.issued_at,
      'expires': instance.expires,
      'id': instance.id,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$PostFromJson(Map<String, dynamic> json) {
  return Login(
    json['userId'] as int,
    json['id'] as int,
    json['title'] as String,
    json['body'] as String,
  );
}

Map<String, dynamic> _$PostToJson(Login instance) => <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
    };

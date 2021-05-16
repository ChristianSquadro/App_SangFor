// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HTTPError.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HTTPError _$HTTPErrorFromJson(Map<String, dynamic> json) {
  return HTTPError(
    Error.fromJson(json['error'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HTTPErrorToJson(HTTPError instance) => <String, dynamic>{
      'error': instance.error.toJson(),
    };

Error _$ErrorFromJson(Map<String, dynamic> json) {
  return Error(
    json['message'] as String,
  );
}

Map<String, dynamic> _$ErrorToJson(Error instance) => <String, dynamic>{
      'message': instance.message,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UrlConsole.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UrlConsole _$UrlConsoleFromJson(Map<String, dynamic> json) {
  return UrlConsole(
    Console.fromJson(json['console'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UrlConsoleToJson(UrlConsole instance) =>
    <String, dynamic>{
      'console': instance.console.toJson(),
    };

Console _$ConsoleFromJson(Map<String, dynamic> json) {
  return Console(
    json['url'] as String,
  );
}

Map<String, dynamic> _$ConsoleToJson(Console instance) => <String, dynamic>{
      'url': instance.url,
    };

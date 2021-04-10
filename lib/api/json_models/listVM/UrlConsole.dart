import 'package:json_annotation/json_annotation.dart';

part 'UrlConsole.g.dart';

@JsonSerializable(explicitToJson: true)
class  UrlConsole{
  final Console console;

  const UrlConsole(this.console);

  //the factory method is used to hide the constructor
  factory UrlConsole.fromJson(Map<String, dynamic> json) => _$UrlConsoleFromJson(json);
  Map<String, dynamic> toJson() => _$UrlConsoleToJson(this);
}

@JsonSerializable()
class Console {
  final String url;

  const Console(this.url);

  //the factory method is used to hide the constructor
  factory Console.fromJson(Map<String, dynamic> json) => _$ConsoleFromJson(json);
  Map<String, dynamic> toJson() => _$ConsoleToJson(this);
}
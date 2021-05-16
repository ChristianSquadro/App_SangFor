import 'package:json_annotation/json_annotation.dart';

part 'HTTPError.g.dart';

@JsonSerializable(explicitToJson: true)
class HTTPError {
  final Error error;

  const HTTPError(this.error);

  factory HTTPError.fromJson(Map<String, dynamic> json) => _$HTTPErrorFromJson(json);
  Map<String, dynamic> toJson() => _$HTTPErrorToJson(this);
}

@JsonSerializable()
class Error {
  final String message;

  const Error(this.message);

  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}
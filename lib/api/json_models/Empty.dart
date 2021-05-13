import 'package:json_annotation/json_annotation.dart';

part 'Empty.g.dart';

@JsonSerializable(nullable: true)
class Empty {
  final String empty;

  const Empty(this.empty);

  factory Empty.fromJson(Map<String, dynamic> json) => _$EmptyFromJson(json);
  Map<String, dynamic> toJson() => _$EmptyToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class Login {
  final int userId;
  final int id;
  final String title;
  final String body;

  const Login(this.userId, this.id, this.title, this.body);

  //the factory method is used to hide the constructor
  factory Login.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
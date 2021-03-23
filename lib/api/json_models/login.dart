import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable(explicitToJson: true)
class Login {
  final Access access;

  const Login(this.access);

  //the factory method is used to hide the constructor
  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
  Map<String, dynamic> toJson() => _$LoginToJson(this);
}


@JsonSerializable(explicitToJson: true)
class Access {
  final Token token;

  const Access(this.token);

  factory Access.fromJson(Map<String, dynamic> json) => _$AccessFromJson(json);
  Map<String, dynamic> toJson() => _$AccessToJson(this);
}

@JsonSerializable()
class Token {
  final String issued_at;
  final String expires;
  final String id;

  const Token(this.issued_at,this.expires,this.id);

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
  Map<String, dynamic> toJson() => _$TokenToJson(this);
}
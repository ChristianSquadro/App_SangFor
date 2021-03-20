import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  const Post(this.userId, this.id, this.title, this.body);

  //the factory method is used to hide the constructor
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
import 'package:app_sangfor/api/json_models/login.dart';
import 'package:app_sangfor/api/json_parsers/json_parser.dart';
import 'object_decoder.dart';

class PostParser extends JsonParser<Post>  with ObjectDecoder<Post> {
  const PostParser();

  @override
  Future<Post> parseFromJson(String json) async {
    final decoded = decodeJsonObject(json);
    return Post.fromJson(decoded);
  }
}
import 'file:///C:/Users/CHRI/AndroidStudioProjects/app_sangfor/lib/api/json_models/login/login.dart';
import 'package:app_sangfor/api/json_parsers/json_parser.dart';
import '../object_decoder.dart';

class LoginParser extends JsonParser<Login>  with ObjectDecoder<Login> {
  const LoginParser();

  @override
  Future<Login> parseFromJson(String json) async {
    final decoded = decodeJsonObject(json);
    return Login.fromJson(decoded);
  }
}
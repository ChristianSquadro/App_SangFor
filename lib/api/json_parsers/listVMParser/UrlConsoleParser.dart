import 'package:app_sangfor/api/json_models/listVM/UrlConsole.dart';
import 'package:app_sangfor/api/json_parsers/json_parser.dart';
import '../object_decoder.dart';

class UrlConsoleParser extends JsonParser<UrlConsole>  with ObjectDecoder<UrlConsole> {
  const UrlConsoleParser();

  @override
  Future<UrlConsole> parseFromJson(String json) async {
    final decoded = decodeJsonObject(json);
    return UrlConsole.fromJson(decoded);
  }
}
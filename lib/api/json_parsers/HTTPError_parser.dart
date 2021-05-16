import 'package:app_sangfor/api/json_models/Empty.dart';
import 'package:app_sangfor/api/json_models/HTTPError.dart';
import 'package:app_sangfor/api/json_parsers/json_parser.dart';
import 'object_decoder.dart';

class HTTPErrorParser extends JsonParser<HTTPError>  with ObjectDecoder<HTTPError> {
  const HTTPErrorParser();

  @override
  Future<HTTPError> parseFromJson(String json) async {
    final decoded = decodeJsonObject(json);
    return HTTPError.fromJson(decoded);
  }
}
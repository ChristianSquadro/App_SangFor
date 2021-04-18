import 'package:app_sangfor/api/json_models/Empty.dart';
import 'package:app_sangfor/api/json_parsers/json_parser.dart';
import 'object_decoder.dart';

class EmptyParser extends JsonParser<Empty>  with ObjectDecoder<Empty> {
  const EmptyParser();

  @override
  Future<Empty> parseFromJson(String json) async {
    final decoded = decodeJsonObject(json);
    return Empty.fromJson(decoded);
  }
}
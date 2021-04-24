import 'package:app_sangfor/api/json_parsers/json_parser.dart';
import '../object_decoder.dart';

class PerformanceVMParser extends JsonParser<List<dynamic>>  with ListDecoder<List<dynamic>> {
  const PerformanceVMParser();

  @override
  Future<List<dynamic>> parseFromJson(String json) async {
    final decoded = decodeJsonList(json);
    return decoded;
  }
}
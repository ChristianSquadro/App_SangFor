import 'package:app_sangfor/api/json_models/flavorVM/flavorVM.dart';
import 'package:app_sangfor/api/json_parsers/json_parser.dart';
import '../object_decoder.dart';

class FlavorVMParser extends JsonParser<FlavorVM>  with ObjectDecoder<FlavorVM> {
  const FlavorVMParser();

  @override
  Future<FlavorVM> parseFromJson(String json) async {
    final decoded = decodeJsonObject(json);
    return FlavorVM.fromJson(decoded);
  }
}
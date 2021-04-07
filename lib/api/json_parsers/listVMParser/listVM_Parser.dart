import 'package:app_sangfor/api/json_models/listVM/listVM.dart';
import 'package:app_sangfor/api/json_parsers/json_parser.dart';
import '../object_decoder.dart';

class ListVMParser extends JsonParser<ListVM>  with ObjectDecoder<ListVM> {
  const ListVMParser();

  @override
  Future<ListVM> parseFromJson(String json) async {
    final decoded = decodeJsonObject(json);
    return ListVM.fromJson(decoded);
  }
}
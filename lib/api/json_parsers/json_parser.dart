library json_parser;

export 'loginParser/login_parser.dart';
export 'flavorVMParser/flavorVM_parser.dart';
export 'object_decoder.dart';

abstract class JsonParser<T> {
  const JsonParser();

  Future<T> parseFromJson(String json);
}
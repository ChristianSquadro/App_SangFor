import 'dart:convert';
import 'json_parser.dart';

//'ON' means that in order to apply this mixin to a class, this class must extend or implement JsonParser because the mixin uses a feature provided by JsonParser.
mixin ObjectDecoder<T> on JsonParser<T> {
  Map<String, dynamic> decodeJsonObject(String json) =>
      jsonDecode(json) as Map<String, dynamic>;
}

mixin ListDecoder<T> on JsonParser<T> {
  List<dynamic> decodeJsonList(String json) =>
      jsonDecode(json) as List<dynamic>;
}
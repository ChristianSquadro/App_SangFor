import "package:app_sangfor/api/json_parsers/json_parser.dart";
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class RequestREST {
  final Dio client;
  final String endpoint;
  final Map<String, String> data;

  const RequestREST({
    @required this.client,
    @required this.endpoint,
    this.data=const {},
  });

 /*
  static final _client = Dio(
      BaseOptions(
        baseUrl: "https://jsonplaceholder.typicode.com/",
        connectTimeout: 3000, // 3 seconds
        receiveTimeout: 3000, // 3 seconds
        headers: <String, String>{"api-key": "add_one_if_needed", },
      )
  );
*/

  Future<T> executeGet<T>(JsonParser<T> parser) async {
    final response = await client.get<String>(endpoint);
    return parser.parseFromJson(response.data);
  }

  Future<T> executePost<T>(JsonParser<T> parser) async {
    final formData = FormData.fromMap(data);
    final response = await client.post<String>(
      endpoint,
      data: formData,
    );

    return parser.parseFromJson(response.data);
  }
}
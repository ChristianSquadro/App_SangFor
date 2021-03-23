import "package:app_sangfor/api/json_parsers/json_parser.dart";
import 'package:app_sangfor/utils/pair.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'json_models/login.dart';

class RequestREST {
  final Dio client;
  final String endpoint;
  final FormData data;

  const RequestREST({
      @required this.client,
      @required this.endpoint,
      this.data,
      });

  Future<T> executeGet<T>(JsonParser<T> parser) async {
    try {
      final response = await client.get<String>(endpoint);
      return await parser.parseFromJson(response.data);
    } on DioError catch (e) {
      rethrow;
    }
  }

  Future<T> executePost<T>(JsonParser<T> parser) async {
    try {
      final formData = data;
      final response = await client.post<String>(
        endpoint,
        data: formData,
      );
      return await parser.parseFromJson(response.data);
    } on DioError catch (e) {
      rethrow;
    }
  }
}

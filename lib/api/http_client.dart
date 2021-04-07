import 'package:app_sangfor/api/json_parsers/json_parser.dart';
import 'package:dio/dio.dart';

class RequestREST {
  final Dio client;
  final String endpoint;
  final String data;

  const RequestREST({
      required this.client,
      required this.endpoint,
      required this.data
      });

  Future<T> executeGet<T>(JsonParser<T> parser) async {
    try {
      final response = await client.get<String>(endpoint);
      return await parser.parseFromJson(response.data!);
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
      return await parser.parseFromJson(response.data!);
    } on DioError catch (e) {
      rethrow;
    }
  }
}

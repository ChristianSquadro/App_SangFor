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

  Future<T> executeGet<T>(JsonParser<T> parser,{bool expectedResponse=true}) async {
    try {
      final response = await client.get<String>(endpoint);
      return await (expectedResponse) ? parser.parseFromJson(response.data!) : parser.parseFromJson("{\"empty\": \"empty\"}");
    } on DioError catch (e){
      throw e;
    }
  }

  Future<T> executePost<T>(JsonParser<T> parser,{bool expectedResponse=true}) async {
    try {
      final formData = data;
      final response = await client.post<String>(
        endpoint,
        data: formData,
      );
      return await (expectedResponse) ? parser.parseFromJson(response.data!) : parser.parseFromJson("{\"empty\": \"empty\"}");
    } on DioError catch (e){
      throw e;
    }
  }
}

abstract class JsonParser<T> {
  const JsonParser();

  Future<T> parseFromJson(String json);
}
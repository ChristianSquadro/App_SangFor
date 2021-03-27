import 'package:app_sangfor/api/http_client.dart';
import 'package:dio/dio.dart';

class DataConnection {
  static late String _ipAdress;
  static late String _token;
  static late String _tenant;
  static late String _username;
  static late String _password;

  String get ipAddress => _ipAdress;
  String get token => _token;
  String get tenant => _token;
  String get username => _username;
  String get password => _password;

  ///this is for insert data  (IpAdress,Token,Tenant,Username,Password) with optional-parameters
  static modifyDataConnection(
      {String? ipAddress,
      String? token,
      String? tenant,
      String? username,
      String? password}) {
    _ipAdress = ipAddress ?? _ipAdress;
    _token = token ?? _token;
    _tenant = tenant ?? _tenant;
    _username = username ?? _username;
    _password = password ?? _password;
  }

  static RequestREST createRequestREST(String endpoint) {
    var dio = Dio(BaseOptions(
      baseUrl: "https://" + _ipAdress,
      connectTimeout: 3000, // 3 seconds
      receiveTimeout: 3000, // 3 seconds
    ));
    return RequestREST(
        client: dio,
        endpoint: "/openstack/identity/"+endpoint,
        data: FormData.fromMap({
          "auth": {
            "tenantName": _tenant,
            "passwordCredentials": {"username": _username, "password": _password}
          }
        }));
  }
}

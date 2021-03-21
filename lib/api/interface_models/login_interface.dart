import 'package:app_sangfor/api/json_models/login.dart';
import 'package:app_sangfor/api/json_parsers/json_parser.dart';
import 'package:dio/dio.dart';
import 'package:app_sangfor/api/http_client.dart';

/// Contains the minimal authentication logic that must be implemented
/// by a provider. It can also be used to create "mock" classes for easy
/// unit testing.
class LoginInterface {

  const LoginInterface();

  /// Login with usernamne and password
  Future<Login> authenticate(String ipServer,String username, String password)
  {
    var dio=Dio(
        BaseOptions(
          baseUrl: "https://"+ipServer,
          connectTimeout: 3000, // 3 seconds
          receiveTimeout: 3000, // 3 seconds
        )
    );
    var requestHTTP=new RequestREST(
        client: dio,
        endpoint: "/openstack/identity/v2.0/tokens ",
        data:FormData.fromMap({
        "auth":{
            "tenantName": "test",
                "passwordCredentials": {
                "username": username,
                "password": password
                }
            }
        })
    );

    return requestHTTP.executePost<Login>(const LoginParser());
  };

  /// Logout
  Future<void> logOut();
}

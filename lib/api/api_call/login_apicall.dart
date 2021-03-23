import 'package:app_sangfor/api/json_models/login.dart';
import 'package:app_sangfor/api/json_parsers/json_parser.dart';
import 'package:app_sangfor/widgets/show_error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:app_sangfor/api/http_client.dart';
import 'package:flutter/material.dart';

/// Contains the minimal authentication logic that must be implemented
/// by a provider. It can also be used to create "mock" classes for easy

class Login_ApiCall {
  static String token;

  const Login_ApiCall();

  /// Login with usernamne and password
  Future<bool> authenticate(String ipServer,String username, String password,BuildContext context) async
  {
    var dio=Dio(
        BaseOptions(
          baseUrl: "https://"+ipServer,
          connectTimeout: 3000, // 3 seconds
          receiveTimeout: 3000, // 3 seconds
        )
    );
    var requestHTTP= RequestREST(
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

    try {
      var response = await requestHTTP.executePost<Login>(const LoginParser());
      token = response.access.token.id;
      return Future<bool>.value(true);
    } on DioError catch(e)
    {
      showErrorDialog(context,e.message);
      return Future<bool>.value(false);
    }
  }

  /// Logout
  static Future<void> logOut();
}

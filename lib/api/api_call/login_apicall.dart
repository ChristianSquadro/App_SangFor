import 'file:///C:/Users/CHRI/AndroidStudioProjects/app_sangfor/lib/api/json_models/login/login.dart';
import 'package:app_sangfor/api/json_parsers/json_parser.dart';
import 'package:app_sangfor/repository/data_connection.dart';
import 'file:///C:/Users/CHRI/AndroidStudioProjects/app_sangfor/lib/widgets/reusable_widgets/show_error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// Contains the minimal authentication logic that must be implemented
/// by a provider. It can also be used to create "mock" classes for easy

class Login_ApiCall {
  const Login_ApiCall();

  /// Login with usernamne and password
  Future<bool> authenticate(String ipServer,String tenant,String username, String password,BuildContext context) async
  {
    DataConnection.modifyDataConnection(ipAddress: ipServer,tenant: tenant,username: username,password: password);
    var requestHTTP=DataConnection.createRequestREST("/v2.0/tokens");
    try {
      var response = await requestHTTP.executePost<Login>(const LoginParser());
      DataConnection.modifyDataConnection(token:response.access.token.id);
      DataConnection.storageWrite();
      return Future<bool>.value(true);
    } on DioError catch(e)
    {
      showErrorDialog(context,e.message);
      return Future<bool>.value(false);
    }
  }

  /// Logout
  Future<void> logOut() async
  {
    DataConnection.storageDeleteAll();
  }
}

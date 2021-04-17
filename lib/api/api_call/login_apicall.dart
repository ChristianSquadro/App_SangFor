import 'package:app_sangfor/api/json_parsers/loginParser/login_parser.dart';
import 'package:app_sangfor/api/json_models/login/login.dart';
import 'package:app_sangfor/repository/data_connection.dart';
import 'package:app_sangfor/widgets/reusable_widgets/show_error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// Contains the minimal authentication logic that must be implemented
/// by a provider. It can also be used to create "mock" classes for easy

class Login_ApiCall {
  const Login_ApiCall();

  /// Login with usernamne and password
  Future<bool> authenticate(String ipServer,String tenant,String username, String password,BuildContext context) async
  {
    DataConnection.modifyDataConnection(IpAddress: ipServer,Tenant: tenant,Username: username,Password: password);
    var requestHTTP=DataConnection.createFirstRequestREST("/identity/v2.0/tokens",true);
    try {
      var response = await requestHTTP.executePost<Login>(const LoginParser());
      DataConnection.modifyDataConnection(Token:response.access.token.id);
      DataConnection.storageWrite();
      return Future<bool>.value(true);
    } on DioError catch(e)
    {
      showErrorDialog(context,e);
      return Future<bool>.value(false);
    }
  }

  /// Logout
  Future<void> logOut() async
  {
    DataConnection.storageDeleteAll();
  }
}

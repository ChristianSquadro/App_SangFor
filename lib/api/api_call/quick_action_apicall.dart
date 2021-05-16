import 'package:app_sangfor/api/json_models/Empty.dart';
import 'package:app_sangfor/api/json_models/HTTPError.dart';
import 'package:app_sangfor/api/json_models/login/login.dart';
import 'package:app_sangfor/api/json_parsers/HTTPError_parser.dart';
import 'package:app_sangfor/api/json_parsers/empty_parser.dart';
import 'package:app_sangfor/api/json_parsers/json_parser.dart';
import 'package:app_sangfor/api/json_parsers/loginParser/login_parser.dart';
import 'package:app_sangfor/repository/data_connection.dart';
import 'package:app_sangfor/widgets/reusable_widgets/show_error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class QuickActions_ApiCall {
  const QuickActions_ApiCall();

  Future<bool> powerOn(BuildContext context, String idServer) async {
    var objectJSON =
    {
      "os-start": null
    };
    bool isNotDone = true;
    while (isNotDone) {
      try {
        var requestHTTP = await DataConnection.createRequestREST(
            "/compute/v2/servers/$idServer/action", true, objectJSON);
        await requestHTTP!.executePost<Empty>(
            const EmptyParser(), expectedResponse: false);
        return Future<bool>.value(true);
      } on DioError catch (e) {
        //catch the Unauthorized error
        if (e.response!.statusCode == 401) {
          var requestToken =
          DataConnection.createFirstRequestREST("/identity/v2.0/tokens", false);
          var response = await requestToken.executePost<Login>(
              const LoginParser());
          DataConnection.token = response.access.token.id;
        } else {
          isNotDone = false;
          JsonParser<HTTPError> parser=const HTTPErrorParser();
          HTTPError error=await parser.parseFromJson(e.response!.data as String);
          showErrorDialog(context,error.error.message);
        }
        return Future<bool>.error(e);
      }
    }
    return Future<bool>.error("No Data");
  }

  Future<bool> powerOff(BuildContext context, String idServer) async {
    var objectJSON =
    {
      "os-stop": null
    };
    bool isNotDone = true;
    while (isNotDone) {
      try {
        var requestHTTP = await DataConnection.createRequestREST(
            "/compute/v2/servers/$idServer/action", true, objectJSON);
        await requestHTTP
        !.executePost<Empty>(const EmptyParser(), expectedResponse: false);
        return Future<bool>.value(true);
      } on DioError catch (e) {
        //catch the Unauthorized error
        if (e.response!.statusCode == 401) {
          var requestToken =
          DataConnection.createFirstRequestREST("/identity/v2.0/tokens", false);
          var response = await requestToken.executePost<Login>(
              const LoginParser());
          DataConnection.token = response.access.token.id;
        } else {
          isNotDone = false;
          JsonParser<HTTPError> parser=const HTTPErrorParser();
          HTTPError error=await parser.parseFromJson(e.response!.data as String);
          showErrorDialog(context,error.error.message);
        }
        return Future<bool>.error(e);
      }
    }
    return Future<bool>.error("No Data");
  }
}

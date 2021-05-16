import 'package:app_sangfor/api/json_models/HTTPError.dart';
import 'package:app_sangfor/api/json_models/listVM/UrlConsole.dart';
import 'package:app_sangfor/api/json_models/listVM/listVM.dart';
import 'package:app_sangfor/api/json_models/login/login.dart';
import 'package:app_sangfor/api/json_parsers/HTTPError_parser.dart';
import 'package:app_sangfor/api/json_parsers/json_parser.dart';
import 'package:app_sangfor/api/json_parsers/listVMParser/UrlConsoleParser.dart';
import 'package:app_sangfor/api/json_parsers/listVMParser/listVM_Parser.dart';
import 'package:app_sangfor/api/json_parsers/loginParser/login_parser.dart';
import 'package:app_sangfor/repository/data_connection.dart';
import 'package:app_sangfor/widgets/reusable_widgets/show_error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ListVM_ApiCall {
  const ListVM_ApiCall();

  Future<ListVM> loadVM(BuildContext context) async {
    bool isNotDone = true;
    while (isNotDone) {
      try {
        var requestHTTP = await DataConnection.createRequestREST(
            "/compute/v2/servers/detail", true);
        var response = requestHTTP!.executeGet<ListVM>(const ListVMParser());
        isNotDone = false;
        return response;
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
        return Future<ListVM>.error(e);
      }
    }
    return Future<ListVM>.error("No data!");
  }

  Future<String> loadConsole(BuildContext context,String linkVM) async {
    var objectJSON =
      {
        "os-getVNCConsole": {
          "type": "novnc"
        }
      };
    bool isNotDone=true;
    while (isNotDone)
    try {
      var requestHTTP = await DataConnection.createRequestREST("${linkVM}/action",true,objectJSON);
      var response = await requestHTTP!.executePost<UrlConsole>(const UrlConsoleParser());
      return response.console.url;
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
      return Future<String>.error(e);
    }
  return Future<String>.error("No data!");
  }
}

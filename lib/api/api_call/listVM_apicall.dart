import 'package:app_sangfor/api/json_models/listVM/UrlConsole.dart';
import 'package:app_sangfor/api/json_models/listVM/listVM.dart';
import 'package:app_sangfor/api/json_parsers/listVMParser/UrlConsoleParser.dart';
import 'package:app_sangfor/api/json_parsers/listVMParser/listVM_Parser.dart';
import 'package:app_sangfor/repository/data_connection.dart';
import 'package:app_sangfor/widgets/reusable_widgets/show_error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ListVM_ApiCall {
  const ListVM_ApiCall();

  Future<ListVM> loadVM(BuildContext context) async {
    var requestHTTP =
        DataConnection.createRequestREST("/compute/v2/servers/detail", true);
    try {
      var response = requestHTTP.executeGet<ListVM>(const ListVMParser());
      return response;
    } on DioError catch (e) {
      showErrorDialog(context,e);
      return Future<ListVM>.error(e);
    }
  }

  Future<String> loadConsole(BuildContext context,String linkVM) async {
    var objectJSON =
      {
        "os-getVNCConsole": {
          "type": "novnc"
        }
      };

    var requestHTTP =
    DataConnection.createRequestREST("${linkVM}/action",true,objectJSON);

    try {
      var response = await requestHTTP.executePost<UrlConsole>(const UrlConsoleParser());
      return response.console.url;
    } on DioError catch (e) {
      showErrorDialog(context,e);
      return Future<String>.error(e);
    }
  }
}

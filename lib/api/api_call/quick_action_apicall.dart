import 'package:app_sangfor/api/json_models/Empty.dart';
import 'package:app_sangfor/api/json_parsers/empty_parser.dart';
import 'package:app_sangfor/repository/data_connection.dart';
import 'package:app_sangfor/widgets/reusable_widgets/show_error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class QuickActions_ApiCall {
  const QuickActions_ApiCall();

  Future<bool> powerOn(BuildContext context,String urlServer) async {
    var objectJSON =
    {
      "os-start": null
    };
    var requestHTTP = DataConnection.createRequestREST(urlServer+"/action", true,objectJSON);
    try {
      await requestHTTP.executePost<Empty>(const EmptyParser());
      return Future<bool>.value(true);
    } on DioError catch (e) {
      showErrorDialog(context, e);
      return Future<bool>.error(e);
    }
  }

  Future<bool> powerOff(BuildContext context,String urlServer) async {
    var objectJSON =
    {
      "os-stop": null
    };
    var requestHTTP = DataConnection.createRequestREST(urlServer+"/action", true,objectJSON);
    try {
      await requestHTTP.executePost<Empty>(const EmptyParser());
      return Future<bool>.value(true);
    } on DioError catch (e) {
      showErrorDialog(context, e);
      return Future<bool>.error(e);
    }
  }
}

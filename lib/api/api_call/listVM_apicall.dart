import 'package:app_sangfor/api/json_models/listVM/listVM.dart';
import 'package:app_sangfor/api/json_parsers/listVMParser/listVM_Parser.dart';
import 'package:app_sangfor/repository/data_connection.dart';
import 'package:app_sangfor/widgets/reusable_widgets/show_error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ListVM_ApiCall {
  const ListVM_ApiCall();

  Future<ListVM> loadVM() async {
    var requestHTTP =
        DataConnection.createRequestREST("/compute/v2/servers/detai", true);
    try {
      var response = await requestHTTP.executeGet<ListVM>(const ListVMParser());
      return response;
    } on DioError catch (e) {
      return Future<ListVM>.error(e);
    }
  }
}

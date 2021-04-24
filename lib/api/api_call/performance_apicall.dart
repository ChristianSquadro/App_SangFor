
import 'package:app_sangfor/api/json_parsers/performanceVM_parser/performanceVM_parser.dart';
import 'package:app_sangfor/repository/data_connection.dart';
import 'package:app_sangfor/widgets/reusable_widgets/show_error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PerformanceVM_ApiCall {
  const PerformanceVM_ApiCall();

  Future<List<List<dynamic>>> getCpuUtilisation(BuildContext context, String urlServer) async {
    var requestHTTP = DataConnection.createRequestREST(
        "https://192.168.3.140/openstack/metric/v1/resource/generic/8dfac023-23ad-4659-b02f-d9d0d3b2016f/metric/memory_util/measures",
        true);
    try {
      var response=await requestHTTP.executeGet<List<dynamic>>(const PerformanceVMParser());
      return response.cast<List<List<dynamic>>>();
    } on DioError catch (e) {
      showErrorDialog(context, e);
      return Future<List<List<dynamic>>>.error(e);
    }
  }
}
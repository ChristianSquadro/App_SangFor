import 'package:app_sangfor/api/json_parsers/performanceVM_parser/performanceVM_parser.dart';
import 'package:app_sangfor/repository/data_connection.dart';
import 'package:app_sangfor/widgets/reusable_widgets/show_error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CurrentPerformanceApiCall {
  const CurrentPerformanceApiCall();

  Future<List<dynamic>> getPerformanceUtilisation(BuildContext context, String idServer) async {
    List<dynamic> responses=[];

    try {
      var requestHTTP1 = await DataConnection.createRequestREST("/metric/v1/resource/generic/$idServer/metric/cpu_util/measures", true);
      var requestHTTP2 = await DataConnection.createRequestREST("/metric/v1/resource/generic/$idServer/metric/memory_util/measures", true);
      var requestHTTP3 = await DataConnection.createRequestREST("/metric/v1/resource/generic/$idServer/metric/disk_util/measures",true);
      responses.add(await requestHTTP1!.executeGet<List<dynamic>>(const PerformanceVMParser()));
      responses.add(await requestHTTP2!.executeGet<List<dynamic>>(const PerformanceVMParser()));
      responses.add(await requestHTTP3!.executeGet<List<dynamic>>(const PerformanceVMParser()));
      return responses;
    } on DioError catch (e) {
      showErrorDialog(context, e);
      return Future<List<dynamic>>.error(e);
    }
  }
}
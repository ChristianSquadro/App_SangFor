
import 'package:app_sangfor/api/json_parsers/performanceVM_parser/performanceVM_parser.dart';
import 'package:app_sangfor/repository/data_connection.dart';
import 'package:app_sangfor/widgets/reusable_widgets/show_error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PerformanceVM_ApiCall {
  const PerformanceVM_ApiCall();

  Future<List<dynamic>> getChartUtilisation(BuildContext context, String idServer) async {
    var requestHTTP1 = DataConnection.createRequestREST("/metric/v1/resource/generic/$idServer/metric/cpu_util/measures", true);
    var requestHTTP2 = DataConnection.createRequestREST("/metric/v1/resource/generic/$idServer/metric/memory_util/measures", true);
    var requestHTTP3 = DataConnection.createRequestREST("/metric/v1/resource/generic/$idServer/metric/disk_util/measures", true);
    var requestHTTP4 = DataConnection.createRequestREST("/metric/v1/resource/generic/$idServer/metric/network.incoming.bytes/measures", true);
    var requestHTTP5 = DataConnection.createRequestREST("/metric/v1/resource/generic/$idServer/metric/network.outgoing.bytes/measures", true);
    List<dynamic> responses=[];

    try {
      responses.add(await requestHTTP1.executeGet<List<dynamic>>(const PerformanceVMParser()));
      responses.add(await requestHTTP2.executeGet<List<dynamic>>(const PerformanceVMParser()));
      responses.add(await requestHTTP3.executeGet<List<dynamic>>(const PerformanceVMParser()));
      responses.add(await requestHTTP4.executeGet<List<dynamic>>(const PerformanceVMParser()));
      responses.add(await requestHTTP5.executeGet<List<dynamic>>(const PerformanceVMParser()));
      return responses;
    } on DioError catch (e) {
      showErrorDialog(context, e);
      return Future<List<dynamic>>.error(e);
    }
  }
}
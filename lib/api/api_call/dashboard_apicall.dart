import 'package:app_sangfor/api/json_models/listVM/listVM.dart';
import 'package:app_sangfor/api/json_parsers/listVMParser/listVM_Parser.dart';
import 'package:app_sangfor/repository/data_connection.dart';
import 'package:app_sangfor/widgets/reusable_widgets/show_error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DashBoard_ApiCall {
  const DashBoard_ApiCall();

  Future<List<double>> loadDashBoard(BuildContext context) async {
    try {
      var requestHTTP = await DataConnection.createRequestREST("/compute/v2/servers/detail", true);
      var response = await requestHTTP!.executeGet<ListVM>(const ListVMParser());
      var listStatusVM=_countStatusVM(response);
      return listStatusVM;
    } on DioError catch (e) {
      showErrorDialog(context, e);
      return Future<List<double>>.error(e);
    }
  }

  Future<List<double>> _countStatusVM(ListVM listVM) async {
    List<double> listStatusVM= [0,0,0,0];

    while (listVM.servers.isNotEmpty)
      {
        switch (listVM.servers.last.status)
        {
          case "ACTIVE":
            listStatusVM[0] += 1.0;
            listVM.servers.removeLast();
            break;
          case "SHUTOFF":
            listStatusVM[1] += 1.0;
            listVM.servers.removeLast();
            break;
          case "SUSPENDED":
            listStatusVM[2] += 1.0;
            listVM.servers.removeLast();
            break;
          case "CRASHED":
            listStatusVM[3] += 1.0;
            listVM.servers.removeLast();
            break;
          default:
            listVM.servers.removeLast();
            break;
        }
      }

      return Future<List<double>>.value(listStatusVM);
  }

}
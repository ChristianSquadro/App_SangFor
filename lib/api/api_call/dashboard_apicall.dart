import 'package:app_sangfor/api/json_models/HTTPError.dart';
import 'package:app_sangfor/api/json_models/listVM/listVM.dart';
import 'package:app_sangfor/api/json_models/login/login.dart';
import 'package:app_sangfor/api/json_parsers/HTTPError_parser.dart';
import 'package:app_sangfor/api/json_parsers/json_parser.dart';
import 'package:app_sangfor/api/json_parsers/listVMParser/listVM_Parser.dart';
import 'package:app_sangfor/api/json_parsers/loginParser/login_parser.dart';
import 'package:app_sangfor/repository/data_connection.dart';
import 'package:app_sangfor/widgets/reusable_widgets/show_error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DashBoard_ApiCall {
  const DashBoard_ApiCall();

  Future<List<double>> loadDashBoard(BuildContext context) async {
    bool isNotDone = true;
    while (isNotDone) {
      try {
        var requestHTTP = await DataConnection.createRequestREST(
            "/compute/v2/servers/detail", true);
        var response = await requestHTTP!.executeGet<ListVM>(
            const ListVMParser());
        var listStatusVM = _countStatusVM(response);
        return listStatusVM;
      } on DioError catch (e) {
        //catch the Unauthorized error
        if (e.response!.statusCode == 401) {
          var requestToken =
          DataConnection.createFirstRequestREST("/identity/v2.0/tokens", false);
          var response = await requestToken.executePost<Login>(const LoginParser());
          DataConnection.token = response.access.token.id;
        } else {
          isNotDone = false;
          JsonParser<HTTPError> parser=const HTTPErrorParser();
          HTTPError error=await parser.parseFromJson(e.response!.data as String);
          showErrorDialog(context,error.error.message);
          return Future<List<double>>.error(e);
        }
      }
    }
  return Future<List<double>>.error("No data!");
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
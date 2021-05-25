import 'package:app_sangfor/api/json_models/HTTPError.dart';
import 'package:app_sangfor/api/json_models/flavorVM/flavorVM.dart';
import 'package:app_sangfor/api/json_models/login/login.dart';
import 'package:app_sangfor/api/json_parsers/HTTPError_parser.dart';
import 'package:app_sangfor/api/json_parsers/flavorVMParser/flavorVM_parser.dart';
import 'package:app_sangfor/api/json_parsers/json_parser.dart';
import 'package:app_sangfor/api/json_parsers/loginParser/login_parser.dart';
import 'package:app_sangfor/repository/data_connection.dart';
import 'package:app_sangfor/widgets/reusable_widgets/show_error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FlavorVM_ApiCall {
  const FlavorVM_ApiCall();

  /// Login with usernamne and password
  Future<FlavorVM> loadFlavorVM (String idFlavor,BuildContext context) async
  {
    bool isNotDone=true;
    while (isNotDone) {
      try {
        var requestHTTP = await DataConnection.createRequestREST(
            "/compute/v2/flavors/$idFlavor", true, true);
        var response = await requestHTTP!.executeGet<FlavorVM>(
            const FlavorVMParser());
        return response;
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
          if(e.response?.data != null) {
            HTTPError error = await parser.parseFromJson(
                e.response!.data as String);
            showErrorDialog(context, error.error.message);
          }
          else
            showErrorDialog(context, "Connection Timeout!");
          return Future<FlavorVM>.error(e);
        }
      }
    }
    return Future<FlavorVM>.error("No data!");
  }

  /// Logout
  Future<void> logOut() async
  {
    DataConnection.storageDeleteAll();
  }
}

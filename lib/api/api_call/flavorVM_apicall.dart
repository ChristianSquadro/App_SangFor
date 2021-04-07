import 'package:app_sangfor/api/json_models/flavorVM/flavorVM.dart';
import 'package:app_sangfor/api/json_parsers/flavorVMParser/flavorVM_parser.dart';
import 'package:app_sangfor/repository/data_connection.dart';
import 'package:app_sangfor/widgets/reusable_widgets/show_error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FlavorVM_ApiCall {
  const FlavorVM_ApiCall();

  /// Login with usernamne and password
  Future<FlavorVM?> loadFlavorVM (String ipServer,String tenant,String username, String password,BuildContext context) async
  {
    var requestHTTP=DataConnection.createRequestREST("/compute/v2/flavors/detail/",true);
    try {
      var response = await requestHTTP.executeGet<FlavorVM>(const FlavorVMParser());
      return response;
    } on DioError catch(e)
    {
      showErrorDialog(context,e.message);
      return null;// it's null if the requestHTTP doesn't go well
    }
  }

  /// Logout
  Future<void> logOut() async
  {
    DataConnection.storageDeleteAll();
  }
}

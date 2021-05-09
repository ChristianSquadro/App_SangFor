import 'package:app_sangfor/api/json_models/flavorVM/flavorVM.dart';
import 'package:app_sangfor/api/json_parsers/flavorVMParser/flavorVM_parser.dart';
import 'package:app_sangfor/repository/data_connection.dart';
import 'package:app_sangfor/widgets/reusable_widgets/show_error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FlavorVM_ApiCall {
  const FlavorVM_ApiCall();

  /// Login with usernamne and password
  Future<FlavorVM> loadFlavorVM (String idFlavor,BuildContext context) async
  {
    var requestHTTP=DataConnection.createRequestREST("/compute/v2/flavors/$idFlavor",true);
    try {
      var response = await requestHTTP.executeGet<FlavorVM>(const FlavorVMParser());
      return response;
    } on DioError catch(e)
    {
      showErrorDialog(context,e.message);
      return Future.error(e);// it's null if the requestHTTP doesn't go well
    }
  }

  /// Logout
  Future<void> logOut() async
  {
    DataConnection.storageDeleteAll();
  }
}

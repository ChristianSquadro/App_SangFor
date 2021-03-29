import 'dart:convert';
import 'dart:io';

import 'package:app_sangfor/api/http_client.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class DataConnection {
  static  String _ipAdress="";
  static  String _token="";
  static  String _tenant="";
  static  String _username="";
  static  String _password="";

  String get ipAddress => _ipAdress;
  String get token => _token;
  String get tenant => _tenant;
  String get username => _username;
  String get password => _password;

  ///this is for insert data  (IpAdress,Token,Tenant,Username,Password) with optional-parameters
  static modifyDataConnection(
      {String? ipAddress,
      String? token,
      String? tenant,
      String? username,
      String? password}) {
    _ipAdress = ipAddress ?? _ipAdress;
    _token = token ?? _token;
    _tenant = tenant ?? _tenant;
    _username = username ?? _username;
    _password = password ?? _password;
  }

  static RequestREST createRequestREST(String resource_path) {
    var dio = Dio(BaseOptions(
      baseUrl: "https://" + _ipAdress + "/openstack/identity/",
      connectTimeout: 3000, // 3 seconds
      receiveTimeout: 3000, // 3 seconds
      receiveDataWhenStatusError: true,
    ));

    //accept the HTTP certification
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    var objectJSON = {
      "auth": {
        "tenantName": _tenant,
        "passwordCredentials": {"username": _username, "password": _password}
      }
    };

    return RequestREST(
        client: dio,
        endpoint: resource_path,
        data: jsonEncode(objectJSON)
    );
  }
}



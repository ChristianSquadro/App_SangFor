import 'dart:convert';
import 'dart:io';
import 'package:app_sangfor/api/http_client.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataConnection {
  static String _ipAdress = "";
  static String _token = "";
  static String _tenant = "";
  static String _username = "";
  static String _password = "";

  static String get ipAddress => _ipAdress;
  static String get token => _token;
  static String get tenant => _tenant;
  static String get username => _username;
  static String get password => _password;

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

  static Dio _createDio (String resource_path,bool headerToken)
  {
    var dio = Dio(BaseOptions(
      baseUrl: "https://" + _ipAdress + "/openstack/",
      connectTimeout: 3000, // 3 seconds
      receiveTimeout: 3000, // 3 seconds
      receiveDataWhenStatusError: true,
      headers: (headerToken) ?  {"X-Auth-Token" : token} : <String, String> {},
    ));

    //accept the HTTP certification
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    return dio;
  }

  static RequestREST createFirstRequestREST(String resource_path,bool headerToken) {
    var dio=_createDio(resource_path,headerToken);

    var objectJSON = {
      "auth": {
        "tenantName": _tenant,
        "passwordCredentials": {"username": _username, "password": _password}
      }
    };

    return RequestREST(
        client: dio, endpoint: resource_path, data: jsonEncode(objectJSON));
  }

  static RequestREST createRequestREST(String resource_path,bool headerToken,[objectJSON]) {
    var dio=_createDio(resource_path,headerToken);

    return RequestREST(
        client: dio, endpoint: resource_path, data: jsonEncode(objectJSON ?? <String,String> {}));
  }

  static Future<void> storageWrite () async {
    var storage = new FlutterSecureStorage();
    await storage.write(key: "ipAddress", value: _ipAdress);
    await storage.write(key: "token", value: _token);
    await storage.write(key: "tenant", value: _tenant);
    await storage.write(key: "username", value: _username);
    await storage.write(key: "password", value: _password);
    var tmp=await storage.readAll();
    print(tmp.toString());
  }

  static Future<void> storageRead () async {
    var storage = new FlutterSecureStorage();
    _ipAdress=(await storage.read(key: "ipAddress"))!;
    _token=(await storage.read(key: "token"))!;
    _tenant=(await storage.read(key: "tenant"))!;
    _username=(await storage.read(key: "username"))!;
    _password=(await storage.read(key: "password"))!;
    var tmp=await storage.readAll();
    print(tmp.toString());
  }

  static Future<void> storageDeleteAll () async {
    var storage = new FlutterSecureStorage();
    await storage.deleteAll();
  }

  static Future<Map<String,String>> storageReadAll () async {
    var storage = new FlutterSecureStorage();
    return await storage.readAll();
  }

}

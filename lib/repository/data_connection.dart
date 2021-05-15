import 'dart:convert';
import 'dart:io';
import 'package:app_sangfor/api/http_client.dart';
import 'package:app_sangfor/api/json_models/login/login.dart';
import 'package:app_sangfor/api/json_parsers/loginParser/login_parser.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:app_sangfor/api/json_models/Empty.dart';
import 'package:app_sangfor/api/json_parsers/empty_parser.dart';

class DataConnection {
  static String? ipAddress = "";
  static String? token = "";
  static String? tenant = "";
  static String? username = "";
  static String? password = "";

  ///this is for insert data  (IpAdress,Token,Tenant,Username,Password) with optional-parameters
  static modifyDataConnection(
      {String? IpAddress,
      String? Token,
      String? Tenant,
      String? Username,
      String? Password}) {
    ipAddress = IpAddress ?? ipAddress;
    token = Token ?? token;
    tenant = Tenant ?? tenant;
    username = Username ?? username;
    password = Password ?? password;
  }

  static Dio _createDio(String resource_path, bool headerToken) {
    var dio = Dio(BaseOptions(
      baseUrl: "https://" + ipAddress! + "/openstack/",
      connectTimeout: 5000, // 3 seconds
      receiveTimeout: 5000, // 3 seconds
      receiveDataWhenStatusError: true,
      headers: (headerToken) ? {"X-Auth-Token": token} : <String, String>{},
    ));

    //ignore the HTTP certification
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    return dio;
  }

  static RequestREST createFirstRequestREST(
      String resource_path, bool headerToken) {
    var dio = _createDio(resource_path, headerToken);

    var objectJSON = {
      "auth": {
        "tenantName": tenant,
        "passwordCredentials": {"username": username, "password": password}
      }
    };

    return RequestREST(
        client: dio, endpoint: resource_path, data: jsonEncode(objectJSON));
  }

  static Future<RequestREST?> createRequestREST(String resource_path, bool headerToken, [objectJSON]) async {RequestREST? requestREST;
    var dio = _createDio(resource_path, headerToken);

    try {
      //attempt of connection to test the token availability
      requestREST = RequestREST(
          client: dio,
          endpoint: "/compute/v2/",
          data: jsonEncode(objectJSON ?? <String, String>{}));
      await requestREST.executeGet<Empty>(const EmptyParser(),expectedResponse: false);
    } on DioError catch (e) {
      //catch the Unauthorized error
      if (e.response!.statusCode == 401) {
        var requestToken =
        createFirstRequestREST("/identity/v2.0/tokens", false);
        var response = await requestToken.executePost<Login>(const LoginParser());
        token = response.access.token.id;
      }
    } finally {
      //the true request and the other exception are caught by the designated API
      requestREST = RequestREST(
          client: dio,
          endpoint: resource_path,
          data: jsonEncode(objectJSON ?? <String, String>{}));
    }

    return requestREST;
  }

  static Future<void> storageWrite() async {
    var storage = new FlutterSecureStorage();
    await storage.write(key: "ipAddress", value: ipAddress);
    await storage.write(key: "token", value: token);
    await storage.write(key: "tenant", value: tenant);
    await storage.write(key: "username", value: username);
    await storage.write(key: "password", value: password);
    var tmp = await storage.readAll();
    print(tmp.toString());
  }

  static Future<void> storageRead() async {
    var storage = new FlutterSecureStorage();
    ipAddress = (await storage.read(key: "ipAddress"));
    token = (await storage.read(key: "token"));
    tenant = (await storage.read(key: "tenant"));
    username = (await storage.read(key: "username"));
    password = (await storage.read(key: "password"));
    var tmp = await storage.readAll();
    print(tmp.toString());
  }

  static Future<void> storageDeleteAll() async {
    var storage = new FlutterSecureStorage();
    await storage.deleteAll();
  }

  static Future<Map<String, String>> storageReadAll() async {
    var storage = new FlutterSecureStorage();
    return await storage.readAll();
  }
}

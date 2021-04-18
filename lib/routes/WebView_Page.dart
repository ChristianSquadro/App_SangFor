import 'dart:io';
import 'package:app_sangfor/api/api_call/listVM_apicall.dart';
import 'package:app_sangfor/cache/Vm_Cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';

class WebViewConsole extends StatefulWidget {
  const WebViewConsole();

  @override
  _WebViewConsoleState createState() => _WebViewConsoleState();
}

class _WebViewConsoleState extends State<WebViewConsole> {
  late final flutterWebviewPlugin = FlutterWebviewPlugin();
  final listVMApiCall = ListVM_ApiCall();
  late Future<String> url;

  @override
  void initState() {
    super.initState();
    url = listVMApiCall.loadConsole(context,Provider.of<VmCache>(context, listen: false).urlServer);
    if (Platform.isIOS) {
      flutterWebviewPlugin.onScrollYChanged
          .listen((double offsetY) => offsetY = 2);
      flutterWebviewPlugin.onScrollXChanged
          .listen((double offsetX) => offsetX = 2);
    }

    if (Platform.isAndroid) {
      flutterWebviewPlugin.onScrollYChanged
          .listen((double offsetY) => offsetY = 0.5);
      flutterWebviewPlugin.onScrollXChanged
          .listen((double offsetX) => offsetX = 0.5);
    }
  }

  @override
  void dispose() {
    super.dispose();
    flutterWebviewPlugin.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: new Text("Console")),
        body: FutureBuilder<String>(
            future: url,
            builder: (context, snapshot) {
              //adding connectionState i'm sure when i press the refresh button to show the circular progress bar
              // because after set state the hasData and hasError aren't reset until the response is back
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                final data = snapshot.data;
                print(data);
                return Consumer<VmCache>(builder: (_, value, __) {
                  return WebviewScaffold(
                      withZoom: true,
                      useWideViewPort: true,
                      withOverviewMode: true,
                      url: data,
                      ignoreSSLErrors: true,
                      hidden: true,
                      );
                });
              }
              if (snapshot.hasError &&
                  snapshot.connectionState == ConnectionState.done) {
                return Center(child: Text("No Data!"));
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}

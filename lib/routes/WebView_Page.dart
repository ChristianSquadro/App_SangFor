import 'dart:io';
import 'package:app_sangfor/api/api_call/listVM_apicall.dart';
import 'package:app_sangfor/cache/Vm_Cache.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewConsole extends StatefulWidget {
  const WebViewConsole();

  @override
  _WebViewConsoleState createState() => _WebViewConsoleState();
}

class _WebViewConsoleState extends State<WebViewConsole> {
  final listVMApiCall = ListVM_ApiCall();
  late Future<String> url;

  @override
  void initState() {
    super.initState();
    url = listVMApiCall.loadConsole(
        context, Provider.of<VmCache>(context, listen: false).urlServer);
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
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
                var data = snapshot.data;
                //it's for testing
                //data = data!.replaceFirst("192.168.3.140", "scp.sicloud.org");
                print(data);

                return WebView(
                  initialUrl: "https://www.google.com/",
                );

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

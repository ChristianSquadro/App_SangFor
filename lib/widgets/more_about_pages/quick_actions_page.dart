import 'package:app_sangfor/api/api_call/quick_action_apicall.dart';
import 'package:app_sangfor/cache/Vm_Cache.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuickActionsPage extends StatefulWidget {
  const QuickActionsPage();

  @override
  _QuickActionsState createState() => _QuickActionsState();
}

class _QuickActionsState extends State<QuickActionsPage> {
  QuickActions_ApiCall quickActionApiCall = QuickActions_ApiCall();

  @override
  Widget build(BuildContext context) {
    return Consumer<VmCache>(builder: (_, value, __) {
      return Scaffold(
        appBar: AppBar(title: Text("Quick Actions")),
        body: Column(children: [
          const SizedBox(
            height: 10,
          ),
          Row(children: [
            Expanded(
                child: ElevatedButton(
                    onPressed: () =>
                        quickActionApiCall.powerOn(context, value.idServer),
                    child: Text("Power On")))
          ]),
          Row(children: [
            Expanded(
                child: ElevatedButton(
                    onPressed: () =>
                        quickActionApiCall.powerOff(context, value.urlServer),
                    child: Text("Power Off")))
          ]),
        ]),
      );
    });
  }
}

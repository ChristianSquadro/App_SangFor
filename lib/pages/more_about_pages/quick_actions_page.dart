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
        body: Column(children: [
          const SizedBox(
            height: 10,
          ),
          Row(children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,20,0),
                    child: ElevatedButton(
                        onPressed: () => quickActionApiCall.powerOn(
                            context, value.detailsVM.id),
                        child: Row (mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.power_outlined),Text("Power ON")]))))
          ]),
          Row(children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,20,0),
                    child: ElevatedButton(
                      onPressed: () => quickActionApiCall.powerOff(
                          context, value.detailsVM.id),
                      child: Row (mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.power_off_outlined),Text("Power OFF")]),
                    )))
          ]),
        ]),
      );
    });
  }
}

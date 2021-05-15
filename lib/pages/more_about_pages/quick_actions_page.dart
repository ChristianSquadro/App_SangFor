import 'package:app_sangfor/api/api_call/quick_action_apicall.dart';
import 'package:app_sangfor/cache/Vm_Cache.dart';
import 'package:app_sangfor/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuickActionsPage extends StatefulWidget {
  const QuickActionsPage();

  @override
  _QuickActionsState createState() => _QuickActionsState();
}

class _QuickActionsState extends State<QuickActionsPage> {
  bool isButtonPressed=false;

  QuickActions_ApiCall quickActionApiCall = QuickActions_ApiCall();

  Function()? _buttonPressed (String buttonName)
  {
        switch (buttonName) {
          case "PowerOn":
            if(Provider.of<VmCache>(context, listen: false).detailsVM.status=="SHUTOFF" && !isButtonPressed)
              return () {
               quickActionApiCall.powerOn(context, Provider.of<VmCache>(context, listen: false).detailsVM.id);
               setState(() => isButtonPressed=true);
              };
            else
              return null;

          case "PowerOff":
            if(Provider.of<VmCache>(context, listen: false).detailsVM.status=="ACTIVE" && !isButtonPressed)
              return () {
              quickActionApiCall.powerOff(context, Provider.of<VmCache>(context, listen: false).detailsVM.id);
              setState(() => isButtonPressed=true);
            };
            else
              return null;

          default:
            return null;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VmCache>(builder: (_, value, __) {
      return Scaffold(
        backgroundColor: AppColors.appBackgroundColor,
        body: Column(children: [
          const SizedBox(
            height: 10,
          ),
          Row(children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,20,0),
                    child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(AppColors.buttonColor)),
                        onPressed: _buttonPressed("PowerOn"),
                        child: Row (mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.power_outlined),Text("Power ON")]))))
          ]),
          Row(children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,20,0),
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(AppColors.buttonColor)),
                      onPressed: _buttonPressed("PowerOff"),
                      child: Row (mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.power_off_outlined),Text("Power OFF")]),
                    )))
          ]),
        ]),
      );
    });
  }
}

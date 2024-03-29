import 'package:app_sangfor/api/api_call/listVM_apicall.dart';
import 'package:app_sangfor/api/json_models/listVM/listVM.dart';
import 'package:app_sangfor/cache/Vm_Cache.dart';
import 'package:app_sangfor/styles.dart';
import 'package:app_sangfor/widgets/reusable_widgets/drawer_menu.dart';
import 'package:app_sangfor/widgets/widget_VM/barchart_performance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routes.dart';

class VMPage extends StatefulWidget {
  const VMPage();

  @override
  _VMPageState createState() => _VMPageState();
}

class _VMPageState extends State<VMPage> {
  late Future<ListVM> _listVM;
  final ListVM_ApiCall listVM_ApiCall = const ListVM_ApiCall();

  @override
  void initState() {
    super.initState();
    _listVM = listVM_ApiCall.loadVM(context);
  }

  MaterialColor _changeColor (String statusVM)
  {
    switch (statusVM) {
      case "ACTIVE":
        return Colors.green;
      case "SHUTOFF":
        return Colors.red;
      case "SUSPENDED":
        return Colors.orange;
      case "CRASHED":
        return Colors.yellow;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VmCache>(builder: (_, value, __) {
      return Scaffold(
        backgroundColor: AppColors.appBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor,
            title: Text("Virtual Machines"),
            actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _listVM = listVM_ApiCall.loadVM(context);
              setState(() => {});
            },
          )
        ]),
        drawer: DrawerMenu(),
        body: FutureBuilder<ListVM>(
            future: _listVM,
            builder: (context, snapshot) {
              //adding connectionState i'm sure when i press the refresh button to show the circular progress bar
              // because after set state the hasData and hasError aren't reset until the response is back
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                final data = snapshot.data;

                return ListView.separated(
                  itemCount: data!.servers.length,
                  padding: const EdgeInsets.all(8),
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                  itemBuilder: (context, index) {
                    return Card(
                        color: AppColors.cardColor,
                        elevation: 10,
                        child: Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Center(
                                      child: Text(
                                    data.servers[index].name.toUpperCase(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:Colors.white,
                                        fontSize: 15),
                                  ))),
                              const Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Align(
                                        child:Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ElevatedButton(
                                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(AppColors.buttonColor),),
                                                  onPressed: () {
                                                    value.detailsVM =
                                                        data.servers[index];
                                                    Navigator.of(context)
                                                        .pushNamed(RouteGenerator
                                                            .webViewConsole);
                                                  },
                                                  child: Text("Console")),
                                              ElevatedButton(
                                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(AppColors.buttonColor),),
                                                  onPressed: () {
                                                    value.detailsVM =
                                                        data.servers[index];
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            RouteGenerator
                                                                .VMMoreAbout);
                                                  },
                                                  child: Text("   More   "))
                                            ])),
                                    Padding(padding: EdgeInsets.fromLTRB(0, 7, 0, 0) , child:ConstrainedBox(
                                        constraints: BoxConstraints.tight(Size.square(200)),
                                        child: BarPerformance(data.servers[index]))),
                                  ]),
                              const Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Center(
                                      child: Text(
                                    data.servers[index].status,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: _changeColor(data.servers[index].status)),
                                  ))),
                            ]));
                  },
                );
              }
              if (snapshot.hasError &&
                  snapshot.connectionState == ConnectionState.done) {
                return Center(child: Text("No Data!"));
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      );
    });
  }
}

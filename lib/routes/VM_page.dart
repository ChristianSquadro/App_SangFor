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

//you have to transfer this method in WebView_Page

  @override
  Widget build(BuildContext context) {
    return Consumer<VmCache>(builder: (_, value, __) {
      return Scaffold(
        appBar: AppBar(title: Text("Virtual Machines"), actions: <Widget>[
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
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemBuilder: (context, index) {
                    return Card(
                        color: AppColors.cardColor,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                              Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Positioned(
                                        left: 40,
                                        top: 50,
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff02d38f)),),
                                                  onPressed: () {
                                                    value.detailsVM =
                                                        data.servers[index];
                                                    Navigator.of(context)
                                                        .pushNamed(RouteGenerator
                                                            .webViewConsole);
                                                  },
                                                  child: Text("Console")),
                                              ElevatedButton(
                                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff02d38f)),),
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
                                    Align(
                                        heightFactor: 1.1,
                                        widthFactor: 0.65,
                                        child: BarChartSample1()),
                                  ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 32,5),
                                      child: Image(
                                        image: AssetImage("assets/cpu.png"),
                                        height: 40,
                                        width: 40,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 32,0),
                                      child: Image(
                                          image: AssetImage("assets/ram.png"),
                                          height: 40,
                                          width: 40)),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 32,5),
                                      child: Image(
                                          image: AssetImage("assets/disk.png"),
                                          height: 40,
                                          width: 40)),
                                ],
                              ),
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
                                        color: Colors.green),
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

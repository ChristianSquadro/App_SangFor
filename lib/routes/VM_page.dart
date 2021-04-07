import 'package:app_sangfor/api/api_call/listVM_apicall.dart';
import 'package:app_sangfor/api/json_models/listVM/listVM.dart';
import 'package:app_sangfor/widgets/reusable_widgets/drawer_menu.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Virtual Machine"), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            _listVM = listVM_ApiCall.loadVM(context);
           setState(() => {} );
          },
        )
      ]),
      drawer: DrawerMenu(),
      body: FutureBuilder<ListVM>(
          future: _listVM,
          builder: (context, snapshot) {
            //adding connectionState i'm sure when i press the refresh button to show the circular progress bar
            // because after set state the hasData and hasError aren't reset until the response is back
            if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
              final data = snapshot.data;

              return ListView.builder(
                itemCount: data!.servers.length,
                itemBuilder: (context, index) {
                  return Container(
                      height: 100,
                      color: Colors.blueGrey,
                      child: Center(
                          child: Text("Name VM: ${data.servers[index].name} \n"
                              "Status: ${data.servers[index].status}")));
                },
              );
            }
            if (snapshot.hasError && snapshot.connectionState == ConnectionState.done) {
              return Center(child: Text("No Data!"));
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

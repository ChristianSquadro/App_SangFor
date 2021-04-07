import 'package:app_sangfor/api/api_call/listVM_apicall.dart';
import 'package:app_sangfor/api/json_models/listVM/listVM.dart';
import 'package:app_sangfor/widgets/reusable_widgets/drawer_menu.dart';
import 'package:app_sangfor/widgets/reusable_widgets/show_error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class VMPage extends StatefulWidget {
  const VMPage();

  @override
  _VMPageState createState() => _VMPageState();
}

class _VMPageState extends State<VMPage> {
  late Future<ListVM?> _listVM;
  late final BuildContext mainContext;
  final ListVM_ApiCall listVM_ApiCall = const ListVM_ApiCall();

  @override
  void initState() {
    super.initState();
    mainContext=context;
    _listVM = listVM_ApiCall.loadVM();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Virtual Machine"),
      ),
      drawer: DrawerMenu(),
      body: FutureBuilder<ListVM?>(
          future: _listVM,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
            if (snapshot.hasError) {
              showErrorDialog(mainContext,snapshot.error!);
              return Center (child : Text ("No Data!"));
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

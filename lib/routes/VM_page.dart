import 'package:app_sangfor/widgets/reusable_widgets/drawer_menu.dart';
import 'package:flutter/material.dart';

class VMPage extends StatefulWidget {
  const VMPage();

  @override
  _VMPageState createState() => _VMPageState();
}

class _VMPageState extends State<VMPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Virtual Machine"),
      ),
      drawer: DrawerMenu(),
    );
  }
}

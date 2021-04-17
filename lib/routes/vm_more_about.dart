import 'package:flutter/material.dart';

class VMDetailsPage extends StatefulWidget {
  const VMDetailsPage();

  @override
  _VMDetailsState createState() => _VMDetailsState();
}

class _VMDetailsState extends State<VMDetailsPage> {
  int _selectedIndex = 1;

  static const List<Widget> _widgetOptions = <Widget>[
    //insert page to return
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    //remove setState and use Bloc
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Virtual Machine Details")),
      //body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped ,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: "Details",
              backgroundColor: Colors.lightBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_fix_high),
            label: "Quick Actions",
            backgroundColor: Colors.lightBlue,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.graphic_eq_sharp),
              label: "Performance",
              backgroundColor: Colors.lightBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: "Alerts",
            backgroundColor: Colors.lightBlue,
          ),
        ],
      ),
    );
  }
}

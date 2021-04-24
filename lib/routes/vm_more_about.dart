import 'package:app_sangfor/widgets/more_about_pages/details_page.dart';
import 'package:app_sangfor/widgets/more_about_pages/performance_page.dart';
import 'package:app_sangfor/widgets/more_about_pages/quick_actions_page.dart';
import 'package:flutter/material.dart';

class VMDetailsPage extends StatefulWidget {
  const VMDetailsPage();

  @override
  _VMDetailsState createState() => _VMDetailsState();
}

class _VMDetailsState extends State<VMDetailsPage> {
  int _selectedIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  static const List<Widget> _widgetOptions = const <Widget>[
    DetailsPage(),
    QuickActionsPage(),
    PerformancePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
    //remove setState and use Bloc
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          physics:new NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
          children: const <Widget>[
            DetailsPage(),
            QuickActionsPage(),
            PerformancePage(),
          ],
        ),
      ),
      //_widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        //selectedItemColor: Colors.white,
        onTap: _onItemTapped,
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
          /*BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: "Alerts",
            backgroundColor: Colors.lightBlue,
          ),*/
        ],
      ),
    );
  }
}

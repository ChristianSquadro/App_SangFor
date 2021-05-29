import 'package:app_sangfor/widgets/reusable_widgets/drawer_menu.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

class About extends StatefulWidget {
  const About();

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: new AppBar(
          backgroundColor: AppColors.appBarColor, title: Text("About")),
      drawer: DrawerMenu(),
      body: Column(
        children: [
          Center(
            child: Text(
              "About This App",
              style: TextStyle(color: Colors.white, fontSize: 21, height: 2,fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "APP NAME:  Sangfor Tenant App \n\n"
                "DESCRIPTION:  Sangfor SCP Tenant App enables tenants’ administrators to monitor and manage their virtual machines from a mobile device (smartphone or tablet). \n\n"
                "WARNING:  Use the Tenant’s Admin username for full permissions and NOT a Tenant User username. Furthermore, the Console View requires the SSL certification verification, because it runs on a WebView.\n\n"
                "NOTE: The app was developed during an internship for a degree thesis, with the oversight of Si.el.co. Srl (https://www.sielco.it)  and in collaboration with Sangfor Italy. It is a beta release and as such it only has a limited subset of the intended functionality. Please contact me at christian.squadro@gmail.com for any bugs found in the application.\n",
                style: TextStyle(color: Colors.grey, fontSize: 18),
              )),
        ],
      ),
    );
  }
}

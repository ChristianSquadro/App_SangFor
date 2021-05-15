import 'package:app_sangfor/routes.dart';
import 'package:app_sangfor/routes/home_page.dart';
import 'package:app_sangfor/styles.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 2,
        child:Container(
        color: AppColors.appBarColor ,
        child:ListView(
            children: [
                ListTile(
                  leading: const Icon(Icons.home_outlined),
                  title: const Text("DashBoard"),
                  onTap: () => Navigator.of(context).pushNamed(RouteGenerator.dashboard),
                ),
                const Divider(
                  height: 1,
                  color: Colors.grey,
                ),
              ListTile(
                leading: const Icon(Icons.computer_outlined),
                title: const Text("Virtual Machines"),
                onTap: () => Navigator.of(context).pushNamed(RouteGenerator.vmPage),
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app_outlined),
                title: const Text("Logout"),
                onTap: () {
                  showLogoutDialog (context);
                },
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
            ]
        )
    ));
  }
}

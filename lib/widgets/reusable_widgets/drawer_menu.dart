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
        child: Container(
            color: AppColors.appBarColor,
            child: ListView(children: [
              ListTile(
                leading: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                ),
                title: const Text(
                  "DashBoard",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(RouteGenerator.dashboard),
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              ListTile(
                leading: const Icon(
                  Icons.computer_outlined,
                  color: Colors.white,
                ),
                title: const Text("Virtual Machines",
                    style: TextStyle(color: Colors.white, fontSize: 14)),
                onTap: () =>
                    Navigator.of(context).pushNamed(RouteGenerator.vmPage),
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              ListTile(
                leading: const Icon(
                  Icons.info_outline_rounded,
                  color: Colors.white,
                ),
                title: const Text("About",
                    style: TextStyle(color: Colors.white, fontSize: 14)),
                onTap: () {
                  Navigator.of(context).pushNamed(RouteGenerator.about);
                },
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              ListTile(
                leading: const Icon(
                  Icons.exit_to_app_outlined,
                  color: Colors.white,
                ),
                title: const Text("Logout",
                    style: TextStyle(color: Colors.white, fontSize: 14)),
                onTap: () {
                  showLogoutDialog(context);
                },
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
            ])));
  }
}

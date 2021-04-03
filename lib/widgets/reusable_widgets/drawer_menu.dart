import 'package:app_sangfor/routes.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
            children: [
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("DashBoard"),
                  onTap: () => Navigator.of(context).pushNamed(RouteGenerator.dashboard),
                ),
                const Divider(
                  height: 1,
                  color: Colors.grey,
                ),
              ListTile(
                leading: const Icon(Icons.computer),
                title: const Text("Virtual Machines"),
                onTap: () => Navigator.of(context).pushNamed(RouteGenerator.vmPage),
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
            ]
        )
    );
  }
}

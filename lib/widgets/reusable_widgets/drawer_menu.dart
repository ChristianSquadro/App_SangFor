import 'package:app_sangfor/blocs/authentication_bloc/bloc.dart';
import 'package:app_sangfor/blocs/authentication_bloc/events.dart';
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
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text("Logout"),
                onTap: () => _showLogoutDialog(context),
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
            ]
        )
    );
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure to Log Out?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                context.read<AuthenticationBloc>().add(LoggedOut());
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:app_sangfor/blocs/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Landing page shown on successful authentication.
class DashBoard extends StatelessWidget {
  const DashBoard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DashBoard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => _showLogoutDialog(context),
          )
        ],
      ),
      body: Center(
        child: Text("welcome"),
      ),
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

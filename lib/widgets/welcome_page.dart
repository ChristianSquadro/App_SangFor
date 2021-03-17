import 'package:flutter/material.dart';
import 'package:app_sangfor/blocs/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Landing page shown on successful authentication.
class WelcomePage extends StatelessWidget {
  const WelcomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DashBoard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () =>
                context.watch<AuthenticationBloc>().add(LoggedOut()),
          )
        ],
      ),
      body: Center(
        child: Text("welcome"),
      ),
    );
  }
}

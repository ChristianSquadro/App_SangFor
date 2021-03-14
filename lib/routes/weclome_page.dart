import 'package:flutter/material.dart';
import 'package:app_sangfor/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _WelcomePage extends StatelessWidget {
  const _WelcomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("LoginApp"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => BlocProvider
                .of<AuthenticationBloc>(context)
                .add(LoggedOut()),
          ),
        ],
      ),
      drawer: const Drawer(),
      body: const Center(
        child: Text("You're logged in"),
      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:app_sangfor/blocs/authentication_bloc.dart';
import 'package:app_sangfor/blocs/login_bloc.dart';
import 'package:app_sangfor/widgets/login_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

/// First widget to appear when the application starts containing
/// the [LoginForm] form.
class LoginPage extends StatelessWidget {
  const LoginPage();

  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthenticationBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Login")
      ),
      body: BlocProvider<CredentialsBloc>(
        create: (context) => CredentialsBloc(
          authenticationBloc: authBloc,
        ),
        child: const Center(child: LoginForm()),
      ),
    );
  }
}

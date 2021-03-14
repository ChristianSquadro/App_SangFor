import 'package:flutter/material.dart';
import 'package:app_sangfor/widgets/login_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _LoginPage extends StatelessWidget {
  const _LoginPage();

  @override
  Widget build(BuildContext context) {
    final repository = context.select((FirebaseUserRepository r) => r);
    final authBloc = context.bloc<AuthenticationBloc>();

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("LoginApp"),
        ),
        body: BlocProvider(
            child: const LoginForm(),
            create: (context) => CredentialsBloc(
                userRepository: repository,
                authenticationBloc: authBloc,
            ),
        ),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_sangfor/blocs/credentials_bloc/credentials_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm();

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
// controllers, form key, call to 'dispose' here...
  final _formKey = GlobalKey<FormState>();
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      length: 2,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, data) {
      var baseWidth = 250.0;

      // For wider screen, such as tablets
      if (data.maxWidth >= baseWidth) {
        baseWidth = data.maxWidth / 1.4;
      }

      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SvgPicture.asset(
          "assets/flutter_logo.svg",
          width: baseWidth,
        ),
        Form(
          key: _formKey,
          child: Wrap(
            children: <Widget>[
              SizedBox(
                width: baseWidth - 30,
                child: TextFormField(
                  decoration: const InputDecoration(
                      icon: Icon(Icons.mail), hintText: "Email"),
                  validator: _validateEmail,
                ),
              ),
              SizedBox(
                width: baseWidth - 30,
                child: TextFormField(
                  decoration: const InputDecoration(
                      icon: Icon(Icons.vpn_key), hintText: "Password"),
                  obscureText: true,
                  validator: _validatePassword,
                ),
              ),
              BlocConsumer<CredentialsBloc, CredentialsState>(
                listener: (context, state) {
                  if (state is CredentialsLoginFailure) {
                    // Show a snackbar or a dialog to notify the failure
                  }
                },
                builder: (context, state) {
                  if (state is CredentialsLoginLoading) {
                    return const CircularProgressIndicator();
                  }

                  return ElevatedButton(
                    child: Text(context.localize("login")),
                    onPressed: () {
                      final state = formKey.currentState;

                      if (state?.validate() ?? false) {
                        _loginButtonPressed(context);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ]);
    });
  }
}

String? _validateEmail(String value) {
  if (value.isEmpty) {
    return "Field cannot be empty";
  } else {
    return null;
  }
}

String? _validatePassword(String value) {
  if (value.length < 8) {
    return "At least 8 chars!";
  } else {
    return null;
  }
}

void _loginButtonPressed(BuildContext context) {
  BlocProvider.of<CredentialsBloc>(context).add(LoginButtonPressed(
      username: _emailController.text, password: _passwordController.text));
}

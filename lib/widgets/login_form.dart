import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_sangfor/blocs/login_bloc.dart';
import 'package:app_sangfor/widgets/separator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Actual login form, with validation, asking for email and password
class LoginForm extends StatefulWidget {
  const LoginForm();

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  final ipServerController = TextEditingController();
  final tenantController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? validateIpServer(String? input) {
    if (input!.contains(RegExp(r"^(?!0)(?!.*\.$)((1?\d?\d|25[0-5]|2[0-4]\d)(\.|$)){4}$", caseSensitive: false, multiLine: false))) {
      return null;
    } else {
      return "invalid_field";
    }
  }

  String? validateTenant(String? input) {
    if (!input!.isEmpty) {
      return null;
    } else {
      return "invalid_field";
    }
  }

  String? validateEmail(String? input) {
    if ((input!.length > 10) && (input.contains("@"))) {
      return null;
    } else {
      return "invalid_field";
    }
  }

  String? validatePassword(String? input) {
    if (input!.length > 5) {
      return null;
    } else {
      return "invalid_field";
    }
  }

  //it'll search for the instance of CredentialsBloc from the loginform to the nearest widget above itself
  void loginButtonPressed(BuildContext context) {
    context.watch<CredentialsBloc>().add(LoginButtonPressed(
        ipServer: ipServerController.text,tenant: tenantController.text,username: emailController.text, password: passwordController.text,context: context));
  }


  @override
  void dispose() {
    ipServerController.dispose();
    tenantController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, data) {
        var baseWidth = 250.0;

        // For wider screen, such as tablets
        if (data.maxWidth <= baseWidth) {
          baseWidth = data.maxWidth / 1.4;
        }

        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterLogo(size: 70),

              const Separator(50),

              Form(
                key: formKey,
                child: Wrap(
                  direction: Axis.vertical,
                  spacing: 20,
                  children: <Widget>[
                    SizedBox(
                      width: baseWidth - 30,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.computer),
                          hintText: "ip server",
                        ),
                        validator: validateIpServer,
                        controller: ipServerController,
                      ),
                    ),
                    SizedBox(
                      width: baseWidth - 30,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          hintText: "tenant",
                        ),
                        validator: validateTenant,
                        controller: tenantController,
                      ),
                    ),
                    SizedBox(
                      width: baseWidth - 30,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          hintText: "username",
                        ),
                        validator: validateEmail,
                        controller: emailController,
                      ),
                    ),
                    SizedBox(
                      width: baseWidth - 30,
                      child: TextFormField(
                        obscureText: true,
                        validator: validatePassword,
                        controller: passwordController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.vpn_key),
                          hintText: "password",
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Separator(25),

              // Login
              BlocConsumer<CredentialsBloc, CredentialsState>(
                listener: (context, state) {
                  if (state is CredentialsLoginFailure) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      duration: const Duration(seconds: 2),
                      content: Text("error_login"),
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is CredentialsLoginLoading) {
                    return const CircularProgressIndicator();
                  }

                  return RaisedButton(
                    key: Key("loginButton"),
                    child: Text("login"),
                    color: Colors.lightGreen,
                    textColor: Colors.white,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        loginButtonPressed(context);
                      }
                    },
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}

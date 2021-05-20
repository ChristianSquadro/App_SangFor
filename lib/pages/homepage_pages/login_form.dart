import 'package:app_sangfor/repository/data_connection.dart';
import 'package:app_sangfor/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_sangfor/blocs/login_bloc.dart';
import 'package:app_sangfor/widgets/reusable_widgets/separator.dart';
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
  bool checkedValue = false;

  String? validateIpServer(String? input) {
    if (input!.contains(RegExp(
        r"^(?!0)(?!.*\.$)((1?\d?\d|25[0-5]|2[0-4]\d)(\.|$)){4}$",
        caseSensitive: false,
        multiLine: false))) {
      return null;
    } else {
      return "invalid_field";
    }
  }

  /*String? validateTenant(String? input) {
    if (input!.isNotEmpty) {
      return null;
    } else {
      return "invalid_field";
    }
  }*/

  String? validateEmail(String? input) {
    if ((input!.isNotEmpty)) {
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
    context.read<CredentialsBloc>().add(LoginButtonPressed(
        ipServer: ipServerController.text,
        tenant:"",
        //tenant: tenantController.text,
        username: emailController.text,
        password: passwordController.text,
        context: context));
  }

  @override
  void dispose() {
    ipServerController.dispose();
    //tenantController.dispose();
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
              Image(
                  image: AssetImage("assets/login_sangfor_logo.png"),
                  height: 70),

              const Separator(30),

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
                          prefixIcon: const Icon(Icons.computer_outlined),
                          hintText: "IP Server",
                        ),
                        validator: validateIpServer,
                        controller: ipServerController,
                      ),
                    ),
                    /*SizedBox(
                      width: baseWidth - 30,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_outline_rounded),
                          hintText: "Tenant",
                        ),
                        validator: validateTenant,
                        controller: tenantController,
                      ),
                    ),*/
                    SizedBox(
                      width: baseWidth - 30,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_outlined),
                          hintText: "Username/Email",
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
                          prefixIcon: const Icon(Icons.vpn_key_outlined),
                          hintText: "Password",
                        ),
                      ),
                    ),
                    SizedBox(
                        width: baseWidth - 30,
                        child: CheckboxListTile(
                          title: Text("Save Credentials?"),
                          value: checkedValue,
                          onChanged: (newValue) {
                            if (newValue==true)
                              DataConnection.saveCredentials=true;
                            else
                              DataConnection.saveCredentials=false;
                            setState(() {
                              checkedValue = newValue!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ))
                  ],
                ),
              ),

              const Separator(30),

              // Login
              BlocConsumer<CredentialsBloc, CredentialsState>(
                listener: (context, state) {
                  if (state is CredentialsLoginFailure) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      duration: const Duration(seconds: 2),
                      content: Text("error login"),
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is CredentialsLoginLoading) {
                    return const CircularProgressIndicator();
                  }

                  return ConstrainedBox(
                      constraints: BoxConstraints.tightFor(width: 120),
                      child: ElevatedButton(
                        key: Key("loginButton"),
                        child: Text("Login"),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.buttonColor)),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            loginButtonPressed(context);
                          }
                        },
                      ));
                },
              )
            ],
          ),
        );
      },
    );
  }
}

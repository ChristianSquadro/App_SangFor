import 'package:flutter/material.dart';
import 'package:app_sangfor/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'blocs/authentication_bloc.dart';

void main() => runApp(const LoginApp());

class LoginApp extends StatelessWidget {
  const LoginApp();

  @override
  Widget build(BuildContext context) {

    return BlocProvider<AuthenticationBloc>(
      child: MaterialApp(
        initialRoute: RouteGenerator.homePage,
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

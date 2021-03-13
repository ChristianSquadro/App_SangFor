import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const LoginApp());

class LoginApp extends StatelessWidget {
  const LoginApp();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(repository);
      },
      child: MaterialApp(
        initialRoute: RouteGenerator.homePage,
        onGenerateRoute: RouteGenerator.generateRoute,

        builder: (context, child) {
          return CupertinoTheme(
            // Instead of letting Cupertino widgets auto-adapt to the Material
            // theme (which is green), this app will use a different theme
            // for Cupertino (which is blue by default).
            data: CupertinoThemeData(),
            child: Material(child: child),
          );
        },
        onGenerateTitle: (context) => context.localize("title"),
        debugShowCheckedModeBanner: false,

      ),

    );

  }

}

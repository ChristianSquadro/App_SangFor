import 'package:app_sangfor/repository/user_repository.dart';
import 'package:app_sangfor/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_sangfor/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:provider/provider.dart';

void main() => runApp(
    Provider<UserRepository>(
        create: (_) => FirebaseUserRepository(),
        child: const LoginApp(),
    ),

);

class LoginApp extends StatelessWidget {
  const LoginApp();

  @override
  Widget build(BuildContext context) {
    final repository = context.select((FirebaseUserRepository r) => r);

    return BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(repository);
      },
      child: MaterialApp(
        initialRoute: RouteGenerator.homePage,
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );

  }

}

import 'package:app_sangfor/repository/test_repository.dart';
import 'package:flutter/material.dart';
import 'package:app_sangfor/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'blocs/authentication_bloc.dart';

void main() => runApp(Provider<TestUserRepository>(
  create: (_) => const TestUserRepository(
    fakeEmail: "alberto@miola.it",
    success: true,
  ),
  child: const LoginApp(),
));

class LoginApp extends StatelessWidget {
  const LoginApp();

  @override
  Widget build(BuildContext context) {
    final repository = context.select((TestUserRepository r) => r);
    return BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(repository),
      child: MaterialApp(
        initialRoute: RouteGenerator.homePage,
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

import 'package:app_sangfor/api/api_call/login_apicall.dart';
import 'package:flutter/material.dart';
import 'package:app_sangfor/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'blocs/authentication_bloc.dart';
import 'cache/Vm_Cache.dart';


void main(){
  runApp(Provider<VmCache>(create: (_) => VmCache(), child: const LoginApp()));}

class LoginApp extends StatelessWidget {
  const LoginApp();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(const Login_ApiCall()),
      child: MaterialApp(
        initialRoute: RouteGenerator.homePage,
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

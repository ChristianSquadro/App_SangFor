import 'package:app_sangfor/api/api_call/login_apicall.dart';
import 'package:app_sangfor/pages/homepage_pages/intro_page.dart';
import 'package:app_sangfor/repository/data_connection.dart';
import 'package:app_sangfor/pages/homepage_pages/dashboard.dart';
import 'package:app_sangfor/pages/homepage_pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:app_sangfor/blocs/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../routes.dart';

//first level function necessary because the method red cannot be called anywhere else
Future<void> showLogoutDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Warning'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Are you sure to log out?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              context.read<AuthenticationBloc>().add(LoggedOut());
              Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.homePage, (r) => false);
            },
          ),
        ],
      );
    },
  );
}

/// Home widget containing a tab that programmatically swipes between the
/// login form and the welcome page.
class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin<HomePage> {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      length: 3,
    );
    checkCredentials();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  ///check the credential already insert before showing the login
  Future<void> checkCredentials () async
  {
    var loginApiCall= const Login_ApiCall();
    await DataConnection.storageRead();
    var success=false;
    //it means someone didn't log in yet or log out
   if (DataConnection.ipAddress != null)
        success= await loginApiCall.authenticate(DataConnection.ipAddress!, DataConnection.tenant!, DataConnection.username!,DataConnection.password!, context);
    if(success)
      tabController.animateTo(2);
    else
      tabController.animateTo(1);
  }

  /// Sliding animation to show the login form
  void loginTransition() {
    if (tabController.index != 2) tabController.animateTo(2);
  }

  /// Sliding animation to show the welcome page
  void logoutTransition() {
    if (tabController.index != 1) tabController.animateTo(1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        // This state is emitted on successful authentication
        if (state is AuthenticationSuccess) {
          loginTransition();
        }

        // This state is emitted on logout
        if (state is AuthenticationRevoked) {
          logoutTransition();
        }

        return TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: const [
            IntroPage(),
            LoginPage(),
            DashBoard(),
          ],
        );
      },
    );
  }
}

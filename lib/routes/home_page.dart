import 'package:app_sangfor/api/api_call/login_apicall.dart';
import 'package:app_sangfor/repository/data_connection.dart';
import 'package:app_sangfor/widgets/homepage_pages/dashboard.dart';
import 'package:app_sangfor/widgets/homepage_pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:app_sangfor/blocs/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      length: 2,
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
   if (DataConnection.ipAddress.isNotEmpty)
        success= await loginApiCall.authenticate(DataConnection.ipAddress, DataConnection.tenant, DataConnection.username,DataConnection.password, context);
    if(success)
      tabController.animateTo(1);
  }

  /// Sliding animation to show the login form
  void loginTransition() {
    if (tabController.index != 1) tabController.animateTo(1);
  }

  /// Sliding animation to show the welcome page
  void logoutTransition() {
    if (tabController.index != 0) tabController.animateTo(0);
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
            LoginPage(),
            DashBoard(),
          ],
        );
      },
    );
  }
}

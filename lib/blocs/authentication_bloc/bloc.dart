import 'package:app_sangfor/api/api_call/login_apicall.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'events.dart';
import 'states.dart';

/// Manages the authentication state of the app
class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Login_ApiCall login_apiCall;
  AuthenticationBloc(this.login_apiCall) : super(AuthenticationInit());

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is LoggedIn) {
      yield AuthenticationSuccess();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await login_apiCall.logOut();
      yield AuthenticationRevoked();
    }
  }
}

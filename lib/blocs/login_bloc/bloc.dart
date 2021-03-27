import 'package:app_sangfor/api/api_call/login_apicall.dart';
import 'package:app_sangfor/blocs/authentication_bloc/events.dart';
import 'package:app_sangfor/blocs/authentication_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'states.dart';
import 'events.dart';

/// Manages the login state of the app
class CredentialsBloc extends Bloc<CredentialsEvent, CredentialsState> {
  final Login_ApiCall login_ApiCall;
  final AuthenticationBloc authenticationBloc;
  CredentialsBloc({
    required this.authenticationBloc,
    this.login_ApiCall = const Login_ApiCall(),
  }) : super(CredentialsInitial());

  @override
  Stream<CredentialsState> mapEventToState(CredentialsEvent event) async* {
    if (event is LoginButtonPressed) {
      yield* _loginPressed(event);
    }
  }

  Stream<CredentialsState> _loginPressed(CredentialsEvent event) async* {
    yield CredentialsLoginLoading();

    final success = await login_ApiCall.authenticate(
        event.ipServer,event.tenant, event.username, event.password, event.context);

    if (success) {
      authenticationBloc.add(const LoggedIn());
      yield CredentialsInitial();
    } else {
      yield CredentialsLoginFailure();
    }
  }
}

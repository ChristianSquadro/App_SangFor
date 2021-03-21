import 'package:app_sangfor/api/interface_models/login_interface.dart';
import 'package:app_sangfor/blocs/authentication_bloc/events.dart';
import 'package:flutter/material.dart';
import 'package:app_sangfor/blocs/authentication_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'states.dart';
import 'events.dart';

/// Manages the login state of the app
class CredentialsBloc extends Bloc<CredentialsEvent, CredentialsState> {
  final LoginInterface loginInterface;
  final AuthenticationBloc authenticationBloc;
  CredentialsBloc({
    @required this.authenticationBloc,
    this.loginInterface= const LoginInterface(),
  }) : super(CredentialsInitial());

  @override
  Stream<CredentialsState> mapEventToState(CredentialsEvent event) async* {
    if (event is LoginButtonPressed) {
      yield* _loginPressed(event);
    }
  }

  Stream<CredentialsState> _loginPressed(CredentialsEvent event) async* {
    yield CredentialsLoginLoading();

    try {
      final success =
          await loginInterface.authenticate(event.ipServer,event.username, event.password);

      if (success) {
        authenticationBloc.add(const LoggedIn());
        yield CredentialsInitial();
      } else {
        yield CredentialsLoginFailure();
      }
    } on FirebaseAuthException {
      yield CredentialsLoginFailure();
    }
  }
}

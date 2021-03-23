import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Events for the [LoginBloc] bloc
abstract class CredentialsEvent extends Equatable {
  final String ipServer;
  final String username;
  final String password;
  final BuildContext context;
  const CredentialsEvent(this.ipServer,this.username, this.password,this.context);

  @override
  List<Object> get props => [ipServer,username, password];
}

/// Event fired when the login button is tapped
class LoginButtonPressed extends CredentialsEvent {
  const LoginButtonPressed(
      {@required String ipServer,@required String username, @required String password,@required BuildContext context})
      : super(ipServer,username, password,context);
}

import 'package:equatable/equatable.dart';

/// States emitted by [LogibBloc]
abstract class CredentialsState extends Equatable {
  const CredentialsState();

  @override
  List<Object> get props => [];
}

/// Action required (authentication or registration)
class CredentialsInitial extends CredentialsState {
  const CredentialsInitial();
}

/// Login request awaiting for response
class CredentialsLoginLoading extends CredentialsState {
  const CredentialsLoginLoading();
}

/// Invalid authentication credentials
class CredentialsLoginFailure extends CredentialsState {
  const CredentialsLoginFailure();
}


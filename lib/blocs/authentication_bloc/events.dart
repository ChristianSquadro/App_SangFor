/// Events for the [AuthenticationBloc] bloc
abstract class AuthenticationEvent extends Equatable {
  /// Base class for events fired by [AuthenticationBloc]
  const AuthenticationEvent();

  @override
  List<Object> get props => [];

}

/// User has logged with success
class LoggedIn extends AuthenticationEvent {
  const LoggedIn();
}

/// User requested to logout
class LoggedOut extends AuthenticationEvent {
  const LoggedOut();
}
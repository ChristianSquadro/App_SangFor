/// Manages the authentication state of the app
class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
final UserRepository userRepository;
AuthenticationBloc(this.userRepository) :
super(const AuthenticationInit());

@override
Stream<AuthenticationState> mapEventToState(AuthenticationEvent e) async*{
  if (e is LoggedIn) {
    yield const AuthenticationSuccess();
  }
  if (e is LoggedOut) {
    yield const AuthenticationLoading();
    await userRepository.logOut();
    yield const AuthenticationRevoked();
  }
}

}
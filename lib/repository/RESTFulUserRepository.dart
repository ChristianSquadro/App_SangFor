import 'package:app_sangfor/repository/user_repository.dart';

class RESTFulUserRepository extends UserRepository {
  /// Firebase authentication repository
  const FirebaseUserRepository();

  @override
  String get signedEmail =>
      FirebaseAuth.instance
          .currentUser
          .email ?? "-";

  @override
  Future<bool> authenticate(String username, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username,
          password: password

      );

      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return false;
    }

  }

  @override
  Future<bool> register(String username, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: username,
        password: password,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return false;
    }

  }

  @override
  Future<void> logOut() => FirebaseAuth.instance.signOut();

}
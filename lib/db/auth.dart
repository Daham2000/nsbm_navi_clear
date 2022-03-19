import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;
  late UserCredential result;

  Future<UserCredential> emailPasswordLogin(
      String email, String password) async {
    try {
      result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(result.user?.uid);
      return result;
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
    return result;
  }

  Future<UserCredential?> emailPasswordSignup(
      String email, String password) async {
    try {
      result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(result.user?.uid);
      return result;
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      return result;
    }
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  Future<User?> getLoggedUser() async {
    final User? user = auth.currentUser;
    return user;
  }
}

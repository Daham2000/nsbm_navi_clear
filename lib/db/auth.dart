import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      print(error);
    }
    return null;
  }
}

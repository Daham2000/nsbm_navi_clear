import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nsbm_navi_clear/db/model/profile.dart';

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
      String email, String password,Profile profile) async {
    try {
      result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      CollectionReference users =
      FirebaseFirestore.instance.collection('users');
      await users
          .add({
        'displayName': profile.displayName,
        'email': email,
        'profilePicture': ""
      });
      return result;
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      return result;
    }
  }

  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await auth.signOut();
  }

  Future<User?> getLoggedUser() async {
    final User? user = auth.currentUser;
    return user;
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      print(googleUser?.email);
      final u = await users.where('email', isEqualTo: googleUser?.email).get();
      if(u.docs.isEmpty){
        await users
            .add({
          'displayName': googleUser?.displayName,
          'email': googleUser?.email,
          'profilePicture': googleUser?.photoUrl
        });
      }
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

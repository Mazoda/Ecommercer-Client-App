import 'package:clientecommerce/AppRouter/AppRouter.dart';
import 'package:clientecommerce/views/Screens/FirstScreen.dart';
import 'package:clientecommerce/views/Screens/CategoriesScreen.dart';
import 'package:clientecommerce/views/Screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signIn(String emailAddress, String pass) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: emailAddress, password: pass);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  signUp(String email, String pass) async {
    try {
      UserCredential credential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      firebaseAuth.currentUser!.sendEmailVerification();

      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  checkUser() async {
    User? user = firebaseAuth.currentUser;
    if (user == null) {
      AppRoute.PushWithReplacementToWidget(FirstScreen());
    } else {
      AppRoute.PushWithReplacementToWidget(HomePageSCreen());
    }
  
  }

 getUser() async {
    User? user =await firebaseAuth.currentUser;

    return user;
  }

  signOut() async {
    await firebaseAuth.signOut();
  }

  resetPassWord(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}

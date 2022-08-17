import 'dart:developer';

import 'package:clientecommerce/AppRouter/AppRouter.dart';
import 'package:clientecommerce/data/auth_Helper.dart';
import 'package:clientecommerce/data/fireStore_Helper.dart';
import 'package:clientecommerce/models/AppUser.dart';
import 'package:clientecommerce/providers/fireStoreProvider.dart';
import 'package:clientecommerce/views/Screens/HomePage.dart';
import 'package:clientecommerce/views/Screens/LoginScreen.dart';
import 'package:clientecommerce/views/Screens/CategoriesScreen.dart';
import 'package:clientecommerce/views/widgets/successfulregister.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:string_validator/string_validator.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    getUser();
  }

  User? user;
  String error = "                                  ";
  bool passwordVisible = true;
  bool value = false;
  bool confirmpasswordVisible = true;
  GlobalKey<FormState> registerKey = GlobalKey();
  GlobalKey<FormState> loginkey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  // TextEditingController emaillogin = TextEditingController();

  TextEditingController passlogin = TextEditingController();

  void toggle() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  void toggle2() {
    confirmpasswordVisible = !confirmpasswordVisible;
    notifyListeners();
  }

  // errors(String name) {
  //   name = " Incorrect Email or Password ";
  //   notifyListeners();
  // }

  nullValidation(String v) {
    if (v.isEmpty || v == null) {
      return "This field is required";
    }
  }

  signIn(String emailAddress, String password, BuildContext context) async {
    if (Provider.of<AuthProvider>(context, listen: false)
        .loginkey
        .currentState!
        .validate()) {
      UserCredential? user =
          await AuthHelper.authHelper.signIn(emailAddress, password);
      Provider.of<FireStoreProvider>(context,listen: false).userDetails();
      if (user != null) {
        AppRoute.PushWithReplacementToWidget(const HomePageSCreen());
        email.clear();
        pass.clear();
        error = "";
        notifyListeners();
      } else if (user == null) {
        error = "Incorrect Email or Password ";
        notifyListeners();
      }
    }
  }

  signUp(String emailAddress, String password,
      GlobalKey<FormState> registerKey) async {
    if (registerKey.currentState!.validate()) {
      UserCredential credential =
          await AuthHelper.authHelper.signUp(emailAddress, password);
      if (credential != null) {
        AppRoute.PushWithReplacementToWidget(SuccessfulSignUp());
        FireStoreHelper.firestore.addUserToFireBase(
            username.text, credential.user!.email!, credential.user!.uid);
      }
      confirmpassword.clear();
      email.clear();
      pass.clear();
      username.clear();
      notifyListeners();
    }
  }

  checkUser() async {
    await AuthHelper.authHelper.checkUser();
    notifyListeners();
  }

  getUser() async {
    user = await AuthHelper.authHelper.getUser();
    // log(user!.uid.toString());
    notifyListeners();
  }

  signOut() async {
    await AuthHelper.authHelper.signOut();
    AppRoute.PushWithReplacementToWidget(LoginScreen());
    notifyListeners();
  }

  String? password(String? v) {
    if (v!.length < 6) {
      return 'password must be more than 6';
    }
    notifyListeners();
  }

  String? passwordLogin(String? v) {
    if (v!.length < 6) {
      return 'password must be more than 6';
    }
    notifyListeners();
  }

  String? confirmpass(String? v) {
    if (v != pass.text) {
      return 'password is not the same';
    }
    notifyListeners();
  }

  String? userName(String? v) {
    if (v!.length < 4) {
      return 'UserName must be more than 4 letters';
    } else if (v.length > 8) {
      return "UserName must be less than 8 letters";
    }
    notifyListeners();
  }

  String? emailValidator(String? v) {
    if (!isEmail(v!)) {
      return 'invalid email syntax';
    }
    notifyListeners();
  }

  String? emailValidatorlogin(String? v) {
    if (!isEmail(v!)) {
      return 'invalid email syntax';
    }
    notifyListeners();
  }

  String? checkBoxValidator(bool? x) {
    if (!(x!)) {
      return 'you have to accept our conditions first';
    }
    notifyListeners();
  }
}

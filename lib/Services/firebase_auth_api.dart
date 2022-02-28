import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'custom_exceptions.dart';

class FirebaseAuthApi {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signIn({
    String? email,
    String? password,
    BuildContext? context,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email!, password: password!);
      print(userCredential);
      //Change Credential Provider
      //Go to Home Page

    } on FirebaseAuthException catch (e) {
      CustomAuthExceptions().handleAuthExceptions(e.code, context);
    } catch (e) {
      print("/../");
      print(e);
    }
  }
}

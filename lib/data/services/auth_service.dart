// This is the authentcation service class
// here I will handle the firebase_auth package

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseClient = FirebaseAuth.instance;

  Future<UserCredential> signInWithEmailPassword(String email, String password) async {
    return await firebaseClient.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signUpWithEmailPassword(String email, String password) async {
    return await firebaseClient.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await firebaseClient.signOut();
  }

  Future<void> forgetPassword(String email) async {
    await firebaseClient.sendPasswordResetEmail(email: email);
  }
}

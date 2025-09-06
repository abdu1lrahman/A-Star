// This is the authentcation service class
// here I will handle the subapase package

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabaseClient = Supabase.instance.client;

  Future<AuthResponse> signInWithEmailPassword(String email, String password) async {
    return await supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signUpWithEmailPassword(String email, String password, String name) async {
    return await supabaseClient.auth.signUp(
      email: email,
      password: password,
      data: {
        "name": name,
        "display_name": name,
      },
    );
  }

  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
    } catch (e) {
      debugPrint("====================$e===================");
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> forgetPassword(String email) async {
    debugPrint("Forgot password triggerd");
    await supabaseClient.auth.resetPasswordForEmail(email);
  }

  Future<void> updatePassword(String password) async {
    await supabaseClient.auth.updateUser(UserAttributes(password: password));
  }
}

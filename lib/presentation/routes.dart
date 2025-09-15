import 'package:flutter/material.dart';
import 'package:you_are_a_star/data/services/auth_gate.dart';
import 'package:you_are_a_star/presentation/screens/forget_password.dart';
import 'package:you_are_a_star/presentation/screens/home.dart';
import 'package:you_are_a_star/presentation/screens/intro.dart';
import 'package:you_are_a_star/presentation/screens/intro2.dart';
import 'package:you_are_a_star/presentation/screens/login.dart';
import 'package:you_are_a_star/presentation/screens/mainpage.dart';
import 'package:you_are_a_star/presentation/screens/signin_form_sheet.dart';
import 'package:you_are_a_star/presentation/screens/signup_form_sheet.dart';

Map<String, Widget Function(BuildContext)> routes = {
  "mainPage": (context) => const Mainpage(),
  "intro": (context) => const Intro(),
  "intro2": (context) => const Intro2(),
  "create_account": (context) => const SignUpFormSheet(),
  "signin": (context) => const SigninFormSheet(),
  "auth_gate": (context) => const AuthGate(),
  "login": (context) => const Login(),
  "home": (context) => const Home(),
  "forget_password": (context) => const ForgetPassword(),
};

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:you_are_a_star/data/services/auth_service.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:you_are_a_star/providers/prefs.dart';

class SigninFormSheet extends StatefulWidget {
  const SigninFormSheet({super.key});

  @override
  State<SigninFormSheet> createState() => _SigninFormSheetState();
}

class _SigninFormSheetState extends State<SigninFormSheet> {
  final AuthService _authService = AuthService();
  
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool obscureText = true;

  bool _isLoading = false;

  Color computeLuminance() {
    return Theme.of(context).colorScheme.primary.computeLuminance() > 0.5
        ? Colors.black
        : Colors.white;
  }

  void _submit() async {
    // Validate the form fields
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    // If the form is not valid, return without doing anything

    setState(() {
      _isLoading = true;
    });
    final String confirmMessage = S.of(context).successfully_logged_in;
    try {
      await _authService.signInWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );
      await Prefs.prefs.setString('uuid', _authService.firebaseClient.currentUser!.uid);
      Fluttertoast.showToast(
        msg: confirmMessage,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.green,
      );
      if(!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, "mainPage", (r) => false);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-credential':
          errorMessage = 'هناك خطأ في الايميل او في كلمة المرور الرجاء التأكد والمحاولة مجددا';
          break;
        case 'unknown':
          errorMessage = 'الرجاء التأكد من الاتصال بالانترنت والمحاولة مجددا (استخدم vpn)';
          break;

        default:
          errorMessage = 'An unexpected authentication error occurred.';
      }
      debugPrint("====================${e.code}=====================");
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red[400],
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
    // Save the form state
    _formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FractionallySizedBox(
        heightFactor: 0.99,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close),
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        S.of(context).login,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 3),
                      Text(S.of(context).your_journey),
                      const SizedBox(height: 3),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(S.of(context).email),
                      ),
                      const SizedBox(height: 20),
                      // Email
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                        child: TextFormField(
                          cursorColor: Colors.white,
                          style: TextStyle(color: computeLuminance()),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 0,
                              ),
                            ),
                            hintText: S.of(context).enter_your_email,
                            fillColor: Theme.of(context).colorScheme.primary,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(S.of(context).password),
                      ),
                      const SizedBox(height: 10),
                      // password
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                        child: TextFormField(
                          cursorColor: Colors.white,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _passwordController,
                          style: TextStyle(color: computeLuminance()),
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 0,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText == true ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (obscureText == true) {
                                    obscureText = false;
                                  } else {
                                    obscureText = true;
                                  }
                                });
                              },
                            ),
                            hintText: S.of(context).enter_your_password,
                            fillColor: Theme.of(context).colorScheme.primary,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter a strong password";
                            } else if (value.length < 6) {
                              return "The password most be 6 characters or more";
                            }
                            return null;
                          },
                        ),
                      ),
                      // Forgot password
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "forget_password");
                        },
                        child: Text(
                          S.of(context).forgot_password,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              hoverDuration: const Duration(seconds: 3),
                              onTap: () {
                                _submit();
                              },
                              child: Center(
                                child: Text(
                                  S.of(context).login,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: computeLuminance(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).dont_have_account,
                            style: const TextStyle(fontSize: 16),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, "create_account");
                            },
                            child: Text(
                              S.of(context).create_one,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

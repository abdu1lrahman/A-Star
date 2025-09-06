import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:you_are_a_star/data/services/auth_service.dart';
import 'package:you_are_a_star/generated/l10n.dart';

class SignUpFormSheet extends StatefulWidget {
  const SignUpFormSheet({super.key});

  @override
  State<SignUpFormSheet> createState() => _SignUpFormSheetState();
}

class _SignUpFormSheetState extends State<SignUpFormSheet> {
  final AuthService _authService = AuthService();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool _isLoading = false;

  void _submit() async {
    setState(() {
      _isLoading = true;
    });
    // Validate the form fields
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      // If the form is not valid, return without doing anything
      return;
    } else {
      try {
        await _authService.signUpWithEmailPassword(
          _emailController.text,
          _passwordController.text,
          _nameController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Successfully logged in",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
        Navigator.pushNamedAndRemoveUntil(context, "intro2", (r) => false);
      } on AuthException catch (e) {
        String errorMessage = '';
        switch (e.statusCode) {
          case '422':
            errorMessage = "Email already exists";
            break;
          case null:
            errorMessage = "Please check your internet connection";
          default:
            debugPrint(e.toString());
            errorMessage = "Unknown error";
        }

        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red[400],
        );
        setState(() {
          _isLoading = false;
        });
      }
      // If the form is valid, show a success message
    }
    // Save the form state
    _formKey.currentState!.save();
  }

  Color computeLuminance() {
    return Theme.of(context).colorScheme.primary.computeLuminance() > 0.5
        ? Colors.black
        : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 1.3,
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
                      S.of(context).create_new_account,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 3),
                    Text(S.of(context).create_your_account),
                    const SizedBox(height: 3),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(S.of(context).name1),
                    ),
                    const SizedBox(height: 3),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        controller: _nameController,
                        style: TextStyle(color: computeLuminance()),
                        decoration: InputDecoration(
                          hintText: S.of(context).enter_your_name,
                          fillColor: Theme.of(context).colorScheme.primary,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "you can't leave the name empty";
                          }
                          return null;
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(S.of(context).email),
                    ),
                    const SizedBox(height: 3),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                      child: TextFormField(
                        style: TextStyle(color: computeLuminance()),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
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
                    const SizedBox(height: 3),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                      child: TextFormField(
                        controller: _passwordController,
                        style: TextStyle(color: computeLuminance()),
                        obscureText: obscureText,
                        decoration: InputDecoration(
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
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: (_) {}),
                        const Text("I agree to the Terms & Conditions"),
                      ],
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
                                S.of(context).signup,
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
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Already have an account? Sign in"),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

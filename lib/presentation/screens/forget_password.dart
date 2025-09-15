import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:you_are_a_star/data/services/auth_service.dart';
import 'package:you_are_a_star/generated/l10n.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                S.of(context).forgot_your_password,
                style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Text(
                S.of(context).enter_your_email_address,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                ),
              ),
            ),
            // Text Form Field (Email)
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16, bottom: 4),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  label: Icon(Icons.email, color: Theme.of(context).colorScheme.primary),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            // Send Reset code button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    hoverDuration: const Duration(seconds: 3),
                    onTap: () async {
                      try {
                        debugPrint(_emailController.text.trim());
                        await AuthService().forgetPassword(_emailController.text.trim());
                        if (context.mounted) {
                          Fluttertoast.showToast(
                            toastLength: Toast.LENGTH_LONG,
                            msg: S.of(context).reset_link_sent,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                          );
                        }
                      } on Exception catch (e) {
                        debugPrint("====================${e.toString()}=============");
                      }
                    },
                    child: Center(
                      child: Text(
                        S.of(context).send_reset,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

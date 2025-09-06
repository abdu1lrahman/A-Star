import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:you_are_a_star/data/services/auth_service.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final _tokenController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Create new password",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Text(
              "Enter the reset code from your email and set a new password",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16, bottom: 4),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _tokenController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                label: Icon(Icons.vpn_key_outlined, color: Theme.of(context).colorScheme.primary),
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
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16, bottom: 4),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _passwordController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                label: Icon(Icons.lock_outline, color: Theme.of(context).colorScheme.primary),
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
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16, bottom: 4),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _password2Controller,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                label: Icon(Icons.lock_outline, color: Theme.of(context).colorScheme.primary),
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
                      await AuthService().updatePassword(_passwordController.text);
                    } on Exception catch (e) {
                      debugPrint("error=====${e.toString()}");
                    }
                  },
                  child: const Center(
                    child: Text(
                      "Reset password",
                      style: TextStyle(
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
    );
  }
}

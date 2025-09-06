import 'dart:async';

import 'package:flutter/material.dart';
import 'package:you_are_a_star/data/services/auth_service.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Timer? _timer;
  int _remainingSeconds = 120; // 2 minutes = 120 seconds
  bool _isRunning = true;

  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }

    setState(() {
      _remainingSeconds = 120; // Reset to 2 minutes
      _isRunning = true;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer!.cancel();
          _isRunning = false;
          _onTimerFinished();
        }
      });
    });
  }

  void _pauseTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _remainingSeconds = 120;
      _isRunning = false;
    });
  }

  void _onTimerFinished() {
    // This function is called when timer reaches 0:00
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Time\'s Up!'),
          content: Text('The countdown has finished.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Forgot your password?",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Text(
                "Enter your email address below and we will send you a reset code",
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
                      _startTimer();
                      try {
                        debugPrint(_emailController.text.trim());
                        await AuthService().forgetPassword(_emailController.text.trim());
                        Navigator.pushNamed(context, "create_new_password");
                      } on Exception catch (e) {
                        debugPrint("====================${e.toString()}=============");
                      }
                    },
                    child: const Center(
                      child: Text(
                        "Send Reset Code",
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
            const Text("Didn't reseve a code ?"),
            Text(
              _formatTime(_remainingSeconds),
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
                color: _remainingSeconds <= 10 ? Colors.red : Colors.black,
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

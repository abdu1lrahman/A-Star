import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:you_are_a_star/presentation/screens/signin_form_sheet.dart';
import 'package:you_are_a_star/presentation/screens/signup_form_sheet.dart';
import 'package:you_are_a_star/providers/language_provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Color computeLuminance() {
    return Theme.of(context).colorScheme.primary.computeLuminance() > 0.5
        ? Colors.black
        : const Color(0xFFBDBDBD);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          Positioned(
            height: screenHeight / 1.688,
            width: screenWidth / 0.8,
            left: -200,
            top: -170,
            child: RotationTransition(
              turns: _controller,
              child: Image.asset("assets/icons/app_icon.png"),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "A STAR",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth / 10.2,
                  color: computeLuminance(),
                ),
              ),
              SizedBox(height: screenHeight / 25.33),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  S.of(context).description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth / 21,
                    color: computeLuminance(),
                  ),
                ),
              ),
              SizedBox(height: screenHeight / 38),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      hoverDuration: const Duration(seconds: 3),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return const SigninFormSheet();
                          },
                        );
                      },
                      child: Center(
                        child: Text(
                          S.of(context).login,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 14.0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 2, color: Colors.white)),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return const SignUpFormSheet();
                          },
                        );
                      },
                      child: Center(
                        child: Text(
                          S.of(context).create_new_account,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 130),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: S.of(context).language,
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.language_outlined,
          color: Colors.white,
        ),
        onPressed: () {
          languageProvider.toggleLanguage();
        },
      ),
    );
  }
}

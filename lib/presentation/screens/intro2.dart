import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:you_are_a_star/core/theme/colors.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:you_are_a_star/presentation/providers/user_provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final PageController _pageController = PageController();
  bool _isButtonVisible = false;
  TextEditingController name = TextEditingController();

  @override
  void initState() {
    super.initState();
    name.addListener(() {
      setState(() {
        _isButtonVisible = name.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: secondColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: _pageController,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).gender,
                    style: TextStyle(fontSize: screenWidth * 0.05),
                  ),
                  Consumer<UserProvider>(
                    builder: (context, object, child) {
                      return (userProvider.userGender == true)
                          ? Icon(Icons.man, size: screenWidth * 0.5)
                          : Icon(Icons.woman, size: screenWidth * 0.5);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          userProvider.changeGender(true);
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text(
                          S.of(context).male,
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          userProvider.changeGender(false);
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        child: Text(
                          S.of(context).female,
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      S.of(context).this_info,
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).age,
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Consumer<UserProvider>(
                    builder: (context, object, child) {
                      return NumberPicker(
                        itemWidth: double.infinity,
                        minValue: 1,
                        maxValue: 100,
                        selectedTextStyle: TextStyle(
                          color: Colors.indigo,
                          fontSize: screenWidth * 0.07,
                        ),
                        value: object.userAge,
                        onChanged: (value) {
                          object.changeAge(value);
                        },
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      S.of(context).dont,
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).name,
                    style: TextStyle(fontSize: screenWidth * 0.05),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      onSubmitted: (value) {
                        userProvider.changeName(name.text);
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          "home",
                          (Route<dynamic> route) => false,
                        );
                      },
                      controller: name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _isButtonVisible,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      color: Colors.indigo,
                      child: Text(
                        S.of(context).letsgo,
                        style: TextStyle(
                          color: secondColor,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                      onPressed: () {
                        userProvider.changeName(name.text);
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          "mainPage",
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      S.of(context).enter_name,
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: 80,
            height: 100,
            color: Colors.transparent,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: const WormEffect(
                dotHeight: 16.0,
                dotWidth: 16.0,
                spacing: 16.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}

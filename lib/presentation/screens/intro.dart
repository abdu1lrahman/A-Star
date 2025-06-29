import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:you_are_a_star/core/theme/colors.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:you_are_a_star/providers/language_provider.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  late AnimationController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )..repeat();
    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() {
          _currentPage = page;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: theme1.mainColor,
      // we used stack because we have SmoothPageIndicator()
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: _pageController,
            children: [
              Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      width: screenWidth * 0.25,
                      'assets/images/flowers.png',
                    ),
                    Text(
                      S.of(context).you_are,
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                      ),
                    ),
                    Text(
                      S.of(context).wanna_be,
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: theme1.mainColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/animations/star_animation.json',
                        width: screenWidth * 0.5,
                        height: screenWidth * 0.5,
                        controller: _controller,
                        onLoaded: (composition) {
                          _controller.duration = composition.duration * 1;
                          _controller.repeat();
                        },
                      ),
                      const SizedBox(height: 13),
                      Text(
                        S.of(context).perfect,
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        S.of(context).we_are_here,
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: theme1.mainColor,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      top: _currentPage == 2 ? 0 : -200,
                      right: _currentPage == 2 ? 0 : -200,
                      child: Image.asset(
                        'assets/images/flat-lay.png',
                        height: screenWidth * 0.53,
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      bottom: _currentPage == 2 ? 0 : -200,
                      left: _currentPage == 2 ? 0 : -200,
                      child: Image.asset(
                        'assets/images/backgrounds.png',
                        height: screenWidth * 0.47,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).lets,
                          style: TextStyle(fontSize: screenWidth * 0.05),
                        ),
                        const SizedBox(height: 13.0),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          height: 45,
                          color: Colors.green,
                          child: Text(
                            S.of(context).getstarted,
                            style: TextStyle(
                              fontSize: screenWidth * 0.05,
                              color: theme1.mainColor,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, 'login');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            width: 80,
            height: 150,
            color: Colors.transparent,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: const WormEffect(
                dotHeight: 16.0,
                dotWidth: 16.0,
                spacing: 16.0,
                dotColor: Colors.grey,
                activeDotColor: Colors.green,
              ),
            ),
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
          languageProvider.changeLocale2();
        },
      ),
    );
  }
}

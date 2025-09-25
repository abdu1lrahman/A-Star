import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:you_are_a_star/core/theme/colors.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:you_are_a_star/providers/prefs.dart';
import 'package:you_are_a_star/providers/user_provider.dart';

class Intro2 extends StatefulWidget {
  const Intro2({super.key});

  @override
  State<Intro2> createState() => _Intro2State();
}

class _Intro2State extends State<Intro2> {
  final PageController _pageController = PageController();
  Set<String> selectedInterests = {};
  TextEditingController intrestController = TextEditingController();
  List<String> predefinedInterests = [
    "health",
    "sport",
    "tech",
    "books",
    "music",
    "art",
    "travel",
    "games",
    "science",
    "education",
    "history",
    "fashion",
    "psychology",
  ];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    // final languageProvider = Provider.of<LanguageProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final FirebaseFirestore firestoreClient = FirebaseFirestore.instance;
    return Scaffold(
      backgroundColor: theme1.secondColor,
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
                          ? Icon(Icons.man, size: screenWidth * 0.5, color: Colors.black)
                          : Icon(Icons.woman, size: screenWidth * 0.5, color: Colors.black);
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
                            color: Colors.indigo,
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
                            color: Colors.indigo,
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
                  const SizedBox(height: 15),
                  Text(
                    S.of(context).what_intrests,
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    S.of(context).you_can_choose,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 27.0),
                    child: Wrap(
                      spacing: 8.0,
                      children: predefinedInterests.map((interest) {
                        return ChoiceChip(
                          side: BorderSide(width: 0.5, color: Colors.grey[400]!),
                          selectedColor: Theme.of(context).colorScheme.primary,
                          label: Text(
                            S.of(context).getInterestLabel(interest),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary.computeLuminance() > 0.5
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary.computeLuminance() > 0.5
                                  ? Colors.white
                                  : Colors.grey[400],
                          checkmarkColor:
                              Theme.of(context).colorScheme.primary.computeLuminance() > 0.5
                                  ? Colors.black
                                  : Colors.white,
                          selected: selectedInterests.contains(interest),
                          onSelected: (bool selected) async {
                            setState(() {
                              if (selected) {
                                if (selectedInterests.length < 5) {
                                  selectedInterests.add(interest);
                                } else {
                                  Fluttertoast.showToast(
                                    msg: S.of(context).you_can_only_select,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                  );
                                }
                              } else {
                                selectedInterests.remove(interest);
                              }
                            });
                            Prefs.prefs.setString(
                              'intrests',
                              selectedInterests.toString(),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                    child: TextField(
                      onSubmitted: (value) {
                        final toastMessage = S.of(context).special_intrests_added;
                        Prefs.prefs.setString('special_intrests', value);
                        userProvider.changeSpecialIntrests(value);
                        Fluttertoast.showToast(msg: toastMessage);
                      },
                      controller: intrestController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xffbdbdbd)),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: S.of(context).add_your_own,
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    color: Colors.indigo,
                    child: Text(
                      S.of(context).letsgo,
                      style: TextStyle(
                        color: theme1.secondColor,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                    onPressed: () async {
                      final firebaseclient = FirebaseAuth.instance;
                      try {
                        await firestoreClient.collection("profiles").add({
                          "uuid": firebaseclient.currentUser!.uid,
                          "name": userProvider.userName,
                          "age": userProvider.userAge,
                          "gender": userProvider.userGender,
                          "intrests": selectedInterests.toString(),
                          "special_intrests": userProvider.specialIntrests,
                          "createdAt": DateTime.now().toIso8601String(),
                        });
                        debugPrint(
                            "=========firestore===========Data saved to the Database==========firestore===========");
                      if (!mounted) return;
                      Navigator.pushNamedAndRemoveUntil(context, "mainPage", (r) => false);
                      } on Exception catch (e) {
                        debugPrint(
                            "=========firestore=========error while saving data to Database==${e.toString()}==========firestore===========");
                      }
                    },
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

extension InterestLocalization on S {
  String getInterestLabel(String key) {
    switch (key) {
      case 'health':
        return health;
      case 'sport':
        return sport;
      case 'tech':
        return tech;
      case 'books':
        return books;
      case 'music':
        return music;
      case 'art':
        return art;
      case 'travel':
        return travel;
      case 'games':
        return games;
      case 'science':
        return science;
      case 'education':
        return education;
      case 'history':
        return history;
      case 'fashion':
        return fashion;
      case 'psychology':
        return psychology;
      default:
        return key;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:you_are_a_star/providers/prefs.dart';
import 'package:you_are_a_star/providers/user_provider.dart';

class Intrests extends StatefulWidget {
  const Intrests({super.key});

  @override
  State<Intrests> createState() => _IntrestsState();
}

class _IntrestsState extends State<Intrests> {
  Set<String> selectedInterests = {};
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

  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     selectedInterests = Provider.of<UserProvider>(context, listen: false).intrests!;
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).intrests)),
      body: Center(
        child: Column(
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
                    backgroundColor: Theme.of(context).colorScheme.primary.computeLuminance() > 0.5
                        ? Colors.white
                        : Colors.grey[400],
                    checkmarkColor: Theme.of(context).colorScheme.primary.computeLuminance() > 0.5
                        ? Colors.black
                        : Colors.white,
                    selected: userProvider.intrests!.contains(interest),
                    onSelected: (bool selected) async {
                      setState(() {
                        if (selected) {
                          if (selectedInterests.length < 5) {
                            userProvider.intrests!.add(interest);
                            userProvider.changeIntrests(selectedInterests.toString());
                          } else {
                            Fluttertoast.showToast(
                              msg: S.of(context).you_can_only_select,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                            );
                          }
                        } else {
                          userProvider.intrests!.remove(interest);
                        }
                      });
                      Prefs.prefs.setString(
                        'intrests',
                        userProvider.intrests!.toString(),
                      );

                      final FirebaseFirestore firestoreClient = FirebaseFirestore.instance;
                      try {
                        await firestoreClient
                            .collection("profiles")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({'intrests': selectedInterests.toString()});
                        debugPrint(
                            "=========firestore===========Updated intrests in Database==========firestore===========");
                        if (!mounted) return;
                        Navigator.pushNamedAndRemoveUntil(context, "mainPage", (r) => false);
                      } on Exception catch (e) {
                        debugPrint(
                            "=========firestore=========error while updating data to Database==${e.toString()}==========firestore===========");
                      }
                    },
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: TextField(
                onSubmitted: (value) {
                  setState(() async {
                    final toastMessage = S.of(context).special_intrests_added;
                    userProvider.changeSpecialIntrests(value);
                    Fluttertoast.showToast(msg: toastMessage);
                  });
                },
                controller: TextEditingController(text: userProvider.specialIntrests),
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
          ],
        ),
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

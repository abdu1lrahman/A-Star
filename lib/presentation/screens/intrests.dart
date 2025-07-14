import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Intrests extends StatefulWidget {
  const Intrests({super.key});

  @override
  State<Intrests> createState() => _IntrestsState();
}

class _IntrestsState extends State<Intrests> {
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

  void fetchSavedIntrests() async {
    final prefs = await SharedPreferences.getInstance();
    var response = prefs.getStringList('intrests');
    var specialIntrests = prefs.getString('special_intrests') ?? '';

    if (response != null) {
      setState(() {
        selectedInterests = response.toSet();
        intrestController.value =
            TextEditingValue(text: specialIntrests.toString());
      });
    }
  }

  @override
  void initState() {
    fetchSavedIntrests();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    fetchSavedIntrests();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
                    selectedColor: Theme.of(context).colorScheme.primary,
                    label: Text(
                      S.of(context).getInterestLabel(interest),
                      style: TextStyle(
                        color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .computeLuminance() >
                                0.5
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .computeLuminance() >
                            0.5
                        ? Colors.white
                        : Colors.grey[500],
                    checkmarkColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .computeLuminance() >
                            0.5
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
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setStringList(
                          'intrests', selectedInterests.toList());
                    },
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: TextField(
                onSubmitted: (value) {
                  setState(() async {
                    final toastMessage = S.of(context).special_intrests_added;
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('special_intrests', value);
                    Fluttertoast.showToast(msg: toastMessage);
                  });
                },
                controller: intrestController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffbdbdbd)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: S.of(context).add_your_own,
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:you_are_a_star/presentation/providers/theme_provider.dart';

class Intrests extends StatefulWidget {
  const Intrests({super.key});

  @override
  State<Intrests> createState() => _IntrestsState();
}

class _IntrestsState extends State<Intrests> {
  Set<String> selectedInterests = {};
  TextEditingController intrestController = TextEditingController();

  void fetchSavedIntrests() async {
    final prefs = await SharedPreferences.getInstance();
    var response = prefs.getStringList('intrests');
    var specialIntrests = prefs.getString('special_intrests');

    if (response != null) {
      setState(() {
        selectedInterests = response.toSet();
        intrestController.value = TextEditingValue(text: specialIntrests.toString());
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
    final themeProvider = Provider.of<ThemeProvider>(context);

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
                    selectedColor: themeProvider.currentAppTheme.thirdColor,
                    label: Text(interest),
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
                      prefs.setStringList('intrests', selectedInterests.toList());
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
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('special_intrests', value);
                    debugPrint(selectedInterests.toString());
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

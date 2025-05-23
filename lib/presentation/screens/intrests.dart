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

  void fetchSavedIntrests() async {
    final prefs = await SharedPreferences.getInstance();
    var response = prefs.getStringList('intrests');
    if (response != null) {
      setState(() {
        selectedInterests = response.toSet();
      });
    }
  }

  @override
  void initState() {
    fetchSavedIntrests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    List<String> predefinedInterests = [
      S.of(context).health,
      S.of(context).sport,
      S.of(context).tech,
      S.of(context).books,
      S.of(context).music,
      S.of(context).art,
      S.of(context).travel,
      S.of(context).games,
      S.of(context).science,
      S.of(context).education,
      S.of(context).history,
      S.of(context).fashion,
      S.of(context).psychology,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).intrests,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
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
                    label: Text(interest),
                    selected: selectedInterests.contains(interest),
                    onSelected: (bool selected) {
                      setState(
                        () {
                          if (selected) {
                            if (selectedInterests.length < 5) {
                              selectedInterests.add(interest);
                            } else {
                              Fluttertoast.showToast(
                                msg: 'You can only select 5 interests.',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                              );
                            }
                          } else {
                            selectedInterests.remove(interest);
                          }
                        },
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: TextField(
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
            TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setStringList('intrests', selectedInterests.toList());
                var response = prefs.getStringList('intrests');
                debugPrint(response.toString());
              },
              child: const Text('save your intrests'),
            ),
          ],
        ),
      ),
    );
  }
}

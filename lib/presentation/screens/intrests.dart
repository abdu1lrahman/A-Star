import 'package:flutter/material.dart';
import 'package:you_are_a_star/generated/l10n.dart';

class Intrests extends StatefulWidget {
  Intrests({super.key});

  @override
  State<Intrests> createState() => _IntrestsState();
}

class _IntrestsState extends State<Intrests> {
  Set<String> selectedInterests = {};

  bool is_selected = false;

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
                      setState(() {
                        if (selected) {
                          if (selectedInterests.length < 5) {
                            selectedInterests.add(interest);
                          } else {
                            // Show feedback: selection limit reached
                          }
                        } else {
                          selectedInterests.remove(interest);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

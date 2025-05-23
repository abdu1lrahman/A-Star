import 'package:flutter/material.dart';
import 'package:you_are_a_star/generated/l10n.dart';

class Intrests extends StatelessWidget {
  const Intrests({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).intrests,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
    );
  }
}

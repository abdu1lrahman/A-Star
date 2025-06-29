import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:you_are_a_star/providers/language_provider.dart';
import 'package:you_are_a_star/providers/user_provider.dart';

class BaseContainer extends StatelessWidget {
  final String imagepath;
  final GestureTapUpCallback function;
  final String content;
  const BaseContainer({
    super.key,
    required this.function,
    required this.imagepath,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15),
      color: Colors.white,
      child: SizedBox(
        width: 170,
        height: 170,
        child: Consumer2<LanguageProvider, UserProvider>(
          builder: (context, object, object2, child) => InkWell(
            hoverDuration: const Duration(seconds: 3),
            highlightColor: Colors.amber,
            focusColor: Colors.amber,
            splashColor: Colors.amber,
            borderRadius: BorderRadius.circular(15),
            onTapUp: function,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagepath,
                ),
                const SizedBox(height: 3),
                Text(content),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

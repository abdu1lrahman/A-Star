import 'package:flutter/material.dart';
import 'package:you_are_a_star/generated/l10n.dart';

class CustomDialog extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget title;
  const CustomDialog({super.key,required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            S.of(context).yes,
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            S.of(context).no,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}

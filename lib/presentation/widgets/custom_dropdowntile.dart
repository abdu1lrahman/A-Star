import 'package:flutter/material.dart';

class CustomDropdowntile<T> extends StatelessWidget {
  final String title;
  final T currentValue;
  final List<T> options;
  final ValueChanged<T?> onChanged;

  const CustomDropdowntile({
    super.key,
    required this.title,
    required this.currentValue,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      trailing: DropdownButton<T>(
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        value: currentValue,
        onChanged: onChanged,
        items: options.map((val) {
          return DropdownMenuItem<T>(
            value: val,
            child: Text('$val'),
          );
        }).toList(),
      ),
    );
  }
}

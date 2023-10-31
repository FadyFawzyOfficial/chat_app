import 'package:flutter/material.dart';

class MainTextField extends StatelessWidget {
  final String label;
  final Function(String)? onChanged;

  const MainTextField({
    super.key,
    required this.label,
    this.onChanged,
  });

  @override
  Widget build(context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

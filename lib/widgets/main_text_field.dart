import 'package:flutter/material.dart';

class MainTextField extends StatelessWidget {
  final String label;

  const MainTextField({super.key, required this.label});

  @override
  Widget build(context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

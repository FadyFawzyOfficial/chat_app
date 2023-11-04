import 'package:flutter/material.dart';

class MainTextFormField extends StatelessWidget {
  final String label;
  final Function(String?)? onSaved;
  final Function(String)? validator;
  final TextInputType? keyboardType;

  const MainTextFormField({
    super.key,
    required this.label,
    required this.onSaved,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(context) {
    return TextFormField(
      keyboardType: keyboardType,
      onSaved: onSaved,
      validator: (value) =>
          value == null || value.isEmpty ? 'This field is required' : null,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MainElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const MainElevatedButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
      ),
      child: Text(label),
    );
  }
}

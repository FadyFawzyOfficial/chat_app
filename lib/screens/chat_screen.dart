import 'package:flutter/material.dart';

import '../constants/strings.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              kLogo,
              height: 48,
            ),
            const Text('Chat'),
          ],
        ),
      ),
    );
  }
}

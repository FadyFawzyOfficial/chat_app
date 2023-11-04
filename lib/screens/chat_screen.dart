import 'package:flutter/material.dart';

import '../constants/strings.dart';
import '../widgets/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: ListView.builder(
        padding: const EdgeInsetsDirectional.all(16),
        itemCount: 10,
        itemBuilder: (context, index) => const ChatBubble(
          text: 'I am excellent in my work',
        ),
      ),
    );
  }
}

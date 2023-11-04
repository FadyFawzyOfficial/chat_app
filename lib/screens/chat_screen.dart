import 'package:flutter/material.dart';

import '../constants/strings.dart';
import '../widgets/chat_bubble.dart';

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
            Image.asset(kLogo, height: 48),
            const Text('Chat'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsetsDirectional.all(16),
              itemCount: 10,
              itemBuilder: (context, index) => const ChatBubble(
                text: 'I am excellent in my work',
              ),
            ),
          ),
          const MessageTextField(),
        ],
      ),
    );
  }
}

class MessageTextField extends StatelessWidget {
  const MessageTextField({super.key});

  @override
  Widget build(context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Send a message',
          suffixIcon: Icon(Icons.send_rounded),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
    );
  }
}

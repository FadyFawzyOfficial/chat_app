import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/strings.dart';
import '../widgets/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(context) {
    // Create a CollectionReference called messages that references the firestore collection
    CollectionReference messages =
        FirebaseFirestore.instance.collection('messages');
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
          MessageTextField(
            // Call the messages CollectionReference to add a new message
            onSubmitted: (message) => messages.add({'message': message}),
          ),
        ],
      ),
    );
  }
}

class MessageTextField extends StatelessWidget {
  final Function(String) onSubmitted;
  const MessageTextField({super.key, required this.onSubmitted});

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onSubmitted: onSubmitted,
        decoration: const InputDecoration(
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

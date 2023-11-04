import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/strings.dart';
import '../widgets/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(context) {
    // Create a CollectionReference called messages that references the firestore collection
    final messages = FirebaseFirestore.instance.collection(kMessagesKey);
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
            child: StreamBuilder(
              stream: messages.orderBy(kDateKey).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator.adaptive();
                } else {
                  if (snapshot.hasData) {
                    final messages = List.from(snapshot.data!.docs
                        .map((message) => message[kMessageKey]));
                    return ListView.builder(
                      padding: const EdgeInsetsDirectional.all(16),
                      itemCount: messages.length,
                      itemBuilder: (context, index) => ChatBubble(
                        text: messages[index],
                      ),
                    );
                  } else {
                    return const Text('There was an error');
                  }
                }
              },
            ),
          ),
          MessageTextField(
            // Call the messages CollectionReference to add a new message
            onSubmitted: (message) => messages.add({
                kMessageKey: message,
                kDateKey: DateTime.now(),
              }),
          ),
        ],
      ),
    );
  }
}

class MessageTextField extends StatelessWidget {
  final Function(String) onSubmitted;

  MessageTextField({super.key, required this.onSubmitted});

  final _controller = TextEditingController();

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _controller,
        onSubmitted: (value) {
          onSubmitted(value);
          _controller.clear();
        },
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

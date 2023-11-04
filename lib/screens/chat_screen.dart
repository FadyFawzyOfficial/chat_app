import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/strings.dart';
import '../models/message.dart';
import '../widgets/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final _listController = ScrollController();

  @override
  Widget build(context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;
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
              stream: messages.orderBy(kDateKey, descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator.adaptive();
                } else {
                  if (snapshot.hasData) {
                    final List<Message> messages = List.from(snapshot.data!.docs
                        .map((message) => Message.fromMap(message)));
                    return ListView.builder(
                      controller: _listController,
                      padding: const EdgeInsetsDirectional.all(16),
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) => ChatBubble(
                        text: messages[index].message,
                        isOwner: messages[index].email == email,
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
            onSubmitted: (message) {
              messages.add({
                kMessageKey: message,
                kDateKey: DateTime.now(),
                kEmailKey: email,
              });

              _listController.animateTo(
                _listController.initialScrollOffset,
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
              );
            },
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocBuilder, BlocProvider, ReadContext;

import '../constants/strings.dart';
import '../cubits/chat/chat_cubit.dart';
import '../models/message.dart';
import '../widgets/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final _listController = ScrollController();

  @override
  Widget build(context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;
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
      body: BlocProvider(
        create: (context) => ChatCubit()..messages,
        child: BlocBuilder<ChatCubit, List<Message>>(
          builder: (context, state) {
            final messages = state;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _listController,
                    padding: const EdgeInsetsDirectional.all(16),
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) => ChatBubble(
                      text: messages[index].message,
                      isOwner: messages[index].email == email,
                    ),
                  ),
                ),
                MessageTextField(
                  // Call the messages CollectionReference to add a new message
                  onSubmitted: (message) {
                    context
                        .read<ChatCubit>()
                        .sendMessage(email: email, message: message);

                    _listController.animateTo(
                      _listController.initialScrollOffset,
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn,
                    );
                  },
                ),
              ],
            );
          },
        ),
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
        decoration: InputDecoration(
          hintText: 'Send a message',
          suffixIcon: IconButton(
            onPressed: () {
              onSubmitted(_controller.text);
              _controller.clear();
            },
            icon: const Icon(Icons.send_rounded),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
    );
  }
}

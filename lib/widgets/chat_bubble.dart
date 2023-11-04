import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSender;

  const ChatBubble({
    super.key,
    required this.text,
    this.isSender = true,
  });

  @override
  Widget build(context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        margin: const EdgeInsetsDirectional.only(bottom: 16),
        padding: const EdgeInsetsDirectional.all(16),
        decoration: BoxDecoration(
          color: isSender
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).primaryColor,
          borderRadius: BorderRadiusDirectional.only(
            topEnd: const Radius.circular(16),
            topStart: const Radius.circular(16),
            bottomEnd: isSender ? const Radius.circular(16) : Radius.zero,
            bottomStart: isSender ? Radius.zero : const Radius.circular(16),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}

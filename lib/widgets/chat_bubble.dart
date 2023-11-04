import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isOwner;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isOwner,
  });

  @override
  Widget build(context) {
    return Align(
      alignment: isOwner
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Container(
        margin: const EdgeInsetsDirectional.only(bottom: 16),
        padding: const EdgeInsetsDirectional.all(16),
        decoration: BoxDecoration(
          color: isOwner
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).primaryColor,
          borderRadius: BorderRadiusDirectional.only(
            topEnd: const Radius.circular(16),
            topStart: const Radius.circular(16),
            bottomStart: isOwner ? const Radius.circular(16) : Radius.zero,
            bottomEnd: isOwner ? Radius.zero : const Radius.circular(16),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}

// lib/widgets/chatbot_button.dart
import 'package:flutter/material.dart';

class ChatbotButton extends StatelessWidget {
  final Function onPressed;

  ChatbotButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Chanciella'),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () => onPressed(),
            child: Text('Chatbot'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

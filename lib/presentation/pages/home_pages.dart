// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:innovators/presentation/widgets/books_section.dart';
import 'package:innovators/presentation/widgets/chatbot_button.dart';
import 'package:innovators/presentation/widgets/newBooks.dart';

class HomePage extends StatelessWidget {
  final Function openWebView;

  HomePage({required this.openWebView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: ChatbotButton(onPressed: () {
          openWebView('https://mediafiles.botpress.cloud/889f9bc5-8f13-465c-b1f2-d685086d844c/webchat/bot.html');
        }),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NewBooksSection(),
            BooksSection(),
          ],
        ),
      ),
      backgroundColor: Colors.black, // Set background to black
    );
  }
}

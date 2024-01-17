/*import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:intl/intl.dart';

var now = DateTime.now();
var formatter = DateFormat('dd/MM/yyyy\n      hh:mm ');
String formattedDate = formatter.format(now);

class ChatMessage extends StatelessWidget {
  ChatMessage({
    super.key,
    required this.text,
    required this.sender,
  });

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return sender == 'bot'
        ? BubbleSpecialThree(
      isSender: false,
      text: text,
      color: Color.fromARGB(255, 243, 146, 27),
      tail: true,
      textStyle: TextStyle(color: Colors.white, fontSize: 16),
    )
        : sender == 'user'
        ? BubbleSpecialTwo(
      sent: true,
      isSender: true,
      text: text,
      color: Color.fromARGB(255, 188, 185, 173),
      tail: true,
      textStyle: TextStyle(
          color: const Color.fromARGB(255, 15, 14, 14), fontSize: 16),
    )
        : Center(
        child: Container(
            color: Colors.black12,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(formattedDate),
            )));
  }
}*/

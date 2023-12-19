import 'package:_2geda/models/chat.dart';
import 'package:_2geda/pages/chatPages/conversation_page.dart';
import 'package:flutter/material.dart';

class MessageListTile extends StatelessWidget {
  final Message message;

  const MessageListTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConversationPage(),
          ),
        );
      },
      title: Text(
                message.senderName,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
      subtitle: Text(
                message.message,
                style: const TextStyle(
                  fontSize: 11.26,
                  fontWeight: FontWeight.w300,
                ),
              ),
            
          
      trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                message.time,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Color(0xff4e0ca2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    message.unreadCount.toString(),
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ));
    
  }
}

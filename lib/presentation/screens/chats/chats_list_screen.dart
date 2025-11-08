import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/message_model.dart';
import 'chat_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatsListScreen extends StatefulWidget {
  const ChatsListScreen({super.key});

  @override
  State<ChatsListScreen> createState() => _ChatsListScreenState();
}

class _ChatsListScreenState extends State<ChatsListScreen> {
  // TODO: Replace with actual chats from Firebase
  final List<Chat> _dummyChats = [
    Chat(
      id: 'chat1',
      participants: ['currentUser', 'user1'],
      lastMessage: 'Hi, are you interested in finding?',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
      otherUserName: 'Alice',
    ),
    Chat(
      id: 'chat2',
      participants: ['currentUser', 'user2'],
      lastMessage: 'Yes, I\'m interested!',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
      otherUserName: 'Bob',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: _dummyChats.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No conversations yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start swapping to chat with others',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _dummyChats.length,
              itemBuilder: (context, index) {
                final chat = _dummyChats[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.primaryNavy,
                    child: Text(
                      chat.otherUserName[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  title: Text(
                    chat.otherUserName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    chat.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  trailing: Text(
                    timeago.format(chat.lastMessageTime, locale: 'en_short'),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          chatId: chat.id,
                          otherUserName: chat.otherUserName,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

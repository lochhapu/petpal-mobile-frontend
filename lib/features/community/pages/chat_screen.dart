import 'package:flutter/material.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/chat_input_field.dart';
import '../../../core/constants/app_colors.dart';

class ChatScreen extends StatefulWidget {
  final String contactName;
  final String contactImage;

  const ChatScreen({
    super.key,
    required this.contactName,
    required this.contactImage,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Hi Chandani, I looked at Spy's symptom tracker, it seems he has worms.",
      isMe: false,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    ChatMessage(
      text: "Bring him over today or tomorrow. I will check it out.",
      isMe: false,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    ChatMessage(
      text: "Okay Doctor",
      isMe: true,
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    ChatMessage(
      text: "I will bring him over tomorrow",
      isMe: true,
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    ChatMessage(
      text: "Okay see you then!",
      isMe: false,
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    ChatMessage(
      text: "Thank you for today doc!",
      isMe: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    ChatMessage(
      text: "Thank you for coming. Keep me updated on his condition.",
      isMe: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 20)),
    ),
    ChatMessage(
      text: "Hes already feeling better!",
      isMe: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
    ),
  ];

  void _handleSendMessage(String message) {
    if (message.trim().isEmpty) return;
    
    setState(() {
      _messages.add(
        ChatMessage(
          text: message,
          isMe: true,
          timestamp: DateTime.now(),
        ),
      );
    });
  }

  void _handleImagePick() {
    // Access gallery - your friend will implement this
    print('Access gallery');
  }

  void _handleVoiceRecord() {
    // Start recording voice - your friend will implement this
    print('Start voice recording');
  }

  void _navigateToProfile() {
    // Navigate to user profile - your friend will implement this
    print('Navigate to ${widget.contactName} profile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: GestureDetector(
          onTap: _navigateToProfile,
          child: Row(
            children: [
              // Contact Avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.lightPink,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  color: AppColors.secondaryColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.contactName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Action card',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              reverse: false,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final showDate = index == 0 || 
                    _messages[index - 1].timestamp.day != message.timestamp.day;
                
                return Column(
                  children: [
                    if (showDate)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          _formatDate(message.timestamp),
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ChatMessageBubble(
                      message: message,
                      onProfileTap: _navigateToProfile,
                    ),
                  ],
                );
              },
            ),
          ),
          
          // Input Field
          ChatInputField(
            onSendMessage: _handleSendMessage,
            onImagePick: _handleImagePick,
            onVoiceRecord: _handleVoiceRecord,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Today';
    }
    return '${date.day}/${date.month}/${date.year}';
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.timestamp,
  });
}
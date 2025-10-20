import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../pages/chat_screen.dart'; // Import ChatScreen directly

class MessagesList extends StatelessWidget {
  MessagesList({super.key});

  // Mock data - your friend will replace with API data
  final List<Map<String, dynamic>> messages = const [
    {
      'id': '1',
      'contactName': 'Hyderabad Mann',
      'lastMessage': "You'll go on to hear from you!",
      'timestamp': '36 May',
      'unreadCount': 3,
      'imageUrl': 'assets/images/hyderabad.jpg',
    },
    {
      'id': '2',
      'contactName': 'Dr. Morrosse',
      'lastMessage': "You're welcome!",
      'timestamp': '13 may',
      'unreadCount': 0,
      'imageUrl': 'assets/images/dr_morrosse.jpg',
    },
    {
      'id': '3',
      'contactName': 'Pet net',
      'lastMessage': 'Visit us again!',
      'timestamp': '13 may',
      'unreadCount': 0,
      'imageUrl': 'assets/images/pet_net.jpg',
    },
    {
      'id': '4',
      'contactName': 'Toby Magdke',
      'lastMessage': 'SUR, I\'ll look into it. Something sim!...',
      'timestamp': '11 may',
      'unreadCount': 1,
      'imageUrl': 'assets/images/toby_magdke.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final message = messages[index];
        return MessageItem(
          contactName: message['contactName'],
          lastMessage: message['lastMessage'],
          timestamp: message['timestamp'],
          unreadCount: message['unreadCount'],
          imageUrl: message['imageUrl'],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  contactName: message['contactName'],
                  contactImage: message['imageUrl'],
                ),
              ),
            );
          },
        );
      }, childCount: messages.length),
    );
  }
}

class MessageItem extends StatelessWidget {
  final String contactName;
  final String lastMessage;
  final String timestamp;
  final int unreadCount;
  final String imageUrl;
  final VoidCallback onTap;

  const MessageItem({
    super.key,
    required this.contactName,
    required this.lastMessage,
    required this.timestamp,
    required this.unreadCount,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[200]!, width: 1),
          ),
        ),
        child: Row(
          children: [
            // Contact Avatar
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.lightPink,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                color: AppColors.secondaryColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),

            // Message Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        contactName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: unreadCount > 0
                              ? FontWeight.bold
                              : FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        timestamp,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: unreadCount > 0
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          lastMessage,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: unreadCount > 0
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (unreadCount > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            unreadCount.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

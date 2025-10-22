import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/notifications_list.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<NotificationItem> notifications = [
    NotificationItem(
      id: '1',
      title: 'Linda Kelvis Shepard',
      description: 'Reply to your message',
      time: 'Today',
      isRead: false,
      type: NotificationType.message,
    ),
    NotificationItem(
      id: '2',
      title: "Today's Medical History",
      description: "Today's medical history updated",
      time: '3d',
      isRead: false,
      type: NotificationType.medical,
    ),
    NotificationItem(
      id: '3',
      title: 'Barack vs Vaccination Due',
      description: 'Barack vs Heroes vaccination is due',
      time: '3d',
      isRead: false,
      type: NotificationType.vaccination,
    ),
    NotificationItem(
      id: '4',
      title: 'Very Sanderic Blot',
      description: 'Virus in contrast',
      time: '3d',
      isRead: false,
      type: NotificationType.medical,
    ),
    NotificationItem(
      id: '5',
      title: "Today's medical history",
      description: 'Updated by Dr. Mennane',
      time: '4d',
      isRead: true,
      type: NotificationType.medical,
    ),
    NotificationItem(
      id: '6',
      title: 'Jacobis Hamsler',
      description: 'Accepted your request',
      time: '4d',
      isRead: true,
      type: NotificationType.general,
    ),
    NotificationItem(
      id: '7',
      title: "Spy's Vaccination Taken",
      description: 'Updated vaccination history',
      time: '4d',
      isRead: true,
      type: NotificationType.vaccination,
    ),
    NotificationItem(
      id: '8',
      title: 'Bratan Adeptson Center',
      description: 'Confirmed appointment',
      time: '4d',
      isRead: true,
      type: NotificationType.appointment,
    ),
  ];

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  void markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification.isRead = true;
      }
    });
  }

  void markAsRead(String id) {
    setState(() {
      final notification = notifications.firstWhere((n) => n.id == id);
      notification.isRead = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          children: [
            // Profile section (left side) - Same as CustomAppBar but without onTap
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.pets,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Toby',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    Text(
                      'Goes bananas for bananas!',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'You have $unreadCount unread notifications',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          // Notifications List
          Expanded(
            child: NotificationsList(
              notifications: notifications,
              onNotificationTap: markAsRead,
            ),
          ),

          // Mark All as Read Button
          if (unreadCount > 0)
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: markAllAsRead,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Mark all as read',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

enum NotificationType { message, medical, vaccination, appointment, general }

class NotificationItem {
  final String id;
  final String title;
  final String description;
  final String time;
  bool isRead;
  final NotificationType type;

  NotificationItem({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.isRead,
    required this.type,
  });
}
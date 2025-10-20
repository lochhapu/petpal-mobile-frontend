import 'package:flutter/material.dart';
import '../../../widgets/custom_app_bar.dart';
import '../widgets/chat_header.dart';
import '../widgets/contacts_section.dart';
import '../widgets/messages_list.dart';
import '../../../core/constants/app_colors.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: const CustomAppBar(), body: const ChatScreen());
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        return false; // Let the scroll continue
      },
      child: CustomScrollView(
        slivers: [
          // Header Section
          SliverToBoxAdapter(
            child: Column(
              children: [
                const ChatHeader(),
                const ContactsSection(),
                // Messages Title
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Messages',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),

          // Messages List
          MessagesList(),
        ],
      ),
    );
  }
}

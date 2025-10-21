import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/contact_selection_panel.dart'; // We'll create this

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  void _showNewChatPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the panel to take most of the screen
      backgroundColor: Colors.transparent,
      builder: (context) => const ContactSelectionPanel(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Title and New Chat Button
          Row(
            children: [
              const Text(
                'Chat',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => _showNewChatPanel(context),
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Search Bar
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search here...',
                hintStyle: TextStyle(
                  color: Colors.grey[600],
                  height: 1.0,
                ),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 15,
                ),
                isDense: true,
              ),
              onChanged: (value) {
                // Your friend will implement search functionality
              },
            ),
          ),
        ],
      ),
    );
  }
}
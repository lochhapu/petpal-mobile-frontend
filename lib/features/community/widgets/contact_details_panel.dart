import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ContactDetailsPanel extends StatelessWidget {
  final Map<String, dynamic> contact;
  final VoidCallback onClose;
  final VoidCallback? onMessage;
  final VoidCallback? onCall;

  const ContactDetailsPanel({
    super.key,
    required this.contact,
    required this.onClose,
    this.onMessage,
    this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 40), // For balance
              Text(
                'Contact Info',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: AppColors.primaryColor,
                ),
                onPressed: onClose,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 40,
                  minHeight: 40,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Contact Avatar and Name
          Center(
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.lightPink,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person,
                    color: AppColors.secondaryColor,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  contact['name'] ?? 'Contact Name',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Contact Details
          _buildDetailRow(
            icon: Icons.email_outlined,
            title: 'Email',
            value: contact['email'] ?? 'hydrabad.moke@gmail.com',
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            icon: Icons.phone_outlined,
            title: 'Phone',
            value: contact['phone'] ?? '+94 256 8909',
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            icon: Icons.location_on_outlined,
            title: 'Location',
            value: contact['location'] ?? 'Hydrabad Mann',
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            icon: Icons.pets_outlined,
            title: 'Pet',
            value: contact['pet'] ?? 'Brown husky',
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            icon: Icons.cake_outlined,
            title: 'Pet Breed',
            value: contact['petBreed'] ?? 'Bury',
          ),

          const SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onMessage ?? () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Message'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: onCall ?? () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    side: BorderSide(color: AppColors.primaryColor),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Call'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: AppColors.secondaryColor,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.lightBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ContactListItem extends StatelessWidget {
  final String name;
  final String email;
  final bool isOnline;
  final String lastSeen;
  final VoidCallback onTap;

  const ContactListItem({
    super.key,
    required this.name,
    required this.email,
    required this.isOnline,
    required this.lastSeen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.lightBlue.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            // Contact Avatar
            Stack(
              children: [
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
                if (isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColors.onlineIndicator,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),

            // Contact Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.lightBlue,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Last Seen/Status
            Text(
              lastSeen,
              style: TextStyle(
                fontSize: 10,
                color: isOnline ? AppColors.onlineIndicator : Colors.grey,
                fontWeight: isOnline ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
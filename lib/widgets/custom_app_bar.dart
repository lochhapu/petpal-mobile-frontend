import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import 'profile_overlay.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  OverlayEntry? _overlayEntry;

  void showProfileOverlay() {
    // Remove any existing overlay first
    hideProfileOverlay();

    _overlayEntry = OverlayEntry(
      builder: (context) => ProfileOverlay(onClose: hideProfileOverlay),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void hideProfileOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    hideProfileOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void goToNotifications() {
      Navigator.pushNamed(context, '/notifications');
    }

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          // Profile section (left side)
          GestureDetector(
            onTap: showProfileOverlay,
            child: Row(
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
          ),

          const Spacer(),

          // Notification icon (right side)
          IconButton(
            onPressed: goToNotifications,
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_outlined,
                color: Colors.grey[700],
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../core/constants/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(), // Using your custom app bar
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                'Your Profile',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 30),

              // User Info Section
              Center(
                child: Column(
                  children: [
                    // Profile Icon
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.lightPink,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.secondaryColor.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Name
                    Text(
                      'Chandani Lochana',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Email
                    Text(
                      'chandi.lochana@gmail.com',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primaryColor.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Buttons Section
              _buildProfileButton(
                icon: Icons.visibility_outlined,
                text: 'Preview Profile',
                onTap: () {
                  // Backend will implement
                  print('Preview Profile tapped');
                },
              ),
              const SizedBox(height: 16),

              _buildProfileButton(
                icon: Icons.pets_outlined,
                text: 'Manage Pets',
                onTap: () {
                  // Backend will implement
                  print('Manage Pets tapped');
                },
              ),
              const SizedBox(height: 16),

              _buildProfileButton(
                icon: Icons.history_outlined,
                text: 'Account History',
                onTap: () {
                  // Backend will implement
                  print('Account History tapped');
                },
              ),
              const SizedBox(height: 16),

              _buildProfileButton(
                icon: Icons.edit_outlined,
                text: 'Edit Account',
                onTap: () {
                  // Backend will implement
                  print('Edit Account tapped');
                },
              ),
              const SizedBox(height: 16),

              // Logout button (with different styling)
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                ),
                child: TextButton(
                  onPressed: () {
                    // Backend will implement logout
                    print('Logout tapped');
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout_outlined, color: Colors.red, size: 24),
                      const SizedBox(width: 12),
                      Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.lightPink,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.secondaryColor.withOpacity(0.2)),
      ),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.secondaryColor, size: 24),
            const SizedBox(width: 16),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.primaryColor.withOpacity(0.5),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

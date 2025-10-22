import 'package:flutter/material.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../core/constants/app_colors.dart';
import '../../../widgets/profile_preview_overlay.dart';
import '../../../core/models/user_profile_model.dart';
import 'manage_pets_page.dart';
import 'edit_account_page.dart';
import '../../authentication/pages/sign_in_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Mock data - this will come from your backend
  UserProfile get _currentUserProfile {
    return UserProfile(
      name: 'Chandani Lochana',
      email: 'chandi.lochana@gmail.com',
      phone: '+94 256 8909',
      pets: [
        Pet(name: 'Toby', description: 'Goes bananas for bananas!'),
        Pet(name: 'Spy', description: 'Freaking psychopath!'),
        Pet(name: 'Bazuka', description: 'Ugliest cutie of all time'),
      ],
      imageUrl: null,
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Logout',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
              ),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                _performLogout(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _performLogout(BuildContext context) {
    // TODO: BACKEND IMPLEMENTATION NEEDED HERE
    // 1. Call your authentication service logout method
    // 2. Clear any local storage (tokens, user data, etc.)
    // 3. Handle any cleanup operations

    print('BACKEND: Implement logout logic here');

    // After backend logout is successful, navigate to sign in page
    // This clears the navigation stack so user can't go back to authenticated pages
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
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
                  // Show profile preview overlay
                  showProfilePreview(
                    context: context,
                    userProfile: _currentUserProfile,
                    isCurrentUser: true,
                  );
                },
              ),
              const SizedBox(height: 16),

              _buildProfileButton(
                icon: Icons.pets_outlined,
                text: 'Manage Pets',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ManagePetsPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              _buildProfileButton(
                icon: Icons.edit_outlined,
                text: 'Edit Account',
                onTap: () {
                  // Navigate to Edit Account page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditAccountPage(userProfile: _currentUserProfile),
                    ),
                  ).then((updatedProfile) {
                    if (updatedProfile != null) {
                      // Handle the updated profile here
                      print(
                        'Profile updated: ${(updatedProfile as UserProfile).name}',
                      );
                      // You would typically update your state here
                    }
                  });
                },
              ),
              const SizedBox(height: 16),

              // Logout button
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                ),
                child: TextButton(
                  // TODO: BACKEND - This shows logout confirmation dialog
                  // The actual logout happens in _performLogout method
                  onPressed: () => _showLogoutConfirmation(context),
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

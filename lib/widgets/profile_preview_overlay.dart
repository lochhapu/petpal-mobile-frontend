import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/models/user_profile_model.dart'; // Import from models

class ProfilePreviewOverlay extends StatelessWidget {
  final UserProfile userProfile;
  final bool isCurrentUser;
  final VoidCallback? onSendRequest;
  final VoidCallback onClose;

  const ProfilePreviewOverlay({
    super.key,
    required this.userProfile,
    required this.isCurrentUser,
    this.onSendRequest,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close button
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: AppColors.primaryColor.withOpacity(0.6),
                  ),
                  onPressed: onClose,
                ),
              ),

              const SizedBox(height: 8),

              // Profile Picture
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
                child: userProfile.imageUrl != null
                    ? ClipOval(
                        child: Image.network(
                          userProfile.imageUrl!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(
                        Icons.person,
                        size: 40,
                        color: AppColors.secondaryColor,
                      ),
              ),

              const SizedBox(height: 20),

              // Name
              Text(
                userProfile.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),

              const SizedBox(height: 8),

              // Email
              Text(
                userProfile.email,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryColor.withOpacity(0.7),
                ),
              ),

              const SizedBox(height: 4),

              // Phone Number
              Text(
                userProfile.phone,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryColor.withOpacity(0.7),
                ),
              ),

              const SizedBox(height: 24),

              // Pets List
              if (userProfile.pets.isNotEmpty) ...[
                const Divider(color: AppColors.navBarInactive, height: 1),
                const SizedBox(height: 16),

                ...userProfile.pets.map((pet) => _buildPetItem(pet)).toList(),
              ],

              const SizedBox(height: 24),

              // Send Request Button (only show if not current user)
              if (!isCurrentUser) ...[
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: onSendRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Send Request',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPetItem(Pet pet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pet icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.lightPink,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.pets, size: 20, color: AppColors.secondaryColor),
          ),

          const SizedBox(width: 12),

          // Pet info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pet.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  pet.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Helper function to show the profile preview
void showProfilePreview({
  required BuildContext context,
  required UserProfile userProfile,
  bool isCurrentUser = false,
  VoidCallback? onSendRequest,
}) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (context) => ProfilePreviewOverlay(
      userProfile: userProfile,
      isCurrentUser: isCurrentUser,
      onSendRequest: onSendRequest,
      onClose: () => Navigator.of(context).pop(),
    ),
  );
}

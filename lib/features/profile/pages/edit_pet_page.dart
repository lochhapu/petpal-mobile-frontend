import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/models/user_profile_model.dart';

class EditPetPage extends StatelessWidget {
  final Pet pet;
  final bool isNewPet;

  const EditPetPage({super.key, required this.pet, this.isNewPet = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          isNewPet ? 'Add New Pet' : 'Edit Profile',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Picture Section
            _buildProfilePicture(),
            const SizedBox(height: 30),

            // Form Fields
            _buildFormField(
              label: 'Name',
              initialValue: pet.name,
              icon: Icons.pets,
            ),
            const SizedBox(height: 20),

            _buildFormField(
              label: 'Species',
              initialValue: pet.species ?? 'Cat',
              icon: Icons.category,
            ),
            const SizedBox(height: 20),

            _buildFormField(
              label: 'Breed',
              initialValue: pet.breed ?? 'Burmese',
              icon: Icons.emoji_nature,
            ),
            const SizedBox(height: 20),

            _buildFormField(
              label: 'Birth',
              initialValue: pet.birth ?? '2nd Jan 2022',
              icon: Icons.cake,
            ),
            const SizedBox(height: 20),

            _buildFormField(
              label: 'Gender',
              initialValue: pet.gender ?? 'Male',
              icon: Icons.male,
            ),
            const SizedBox(height: 20),

            _buildFormField(
              label: 'Adopted?',
              initialValue: pet.adopted ?? 'Boston Adoption, Batharamula',
              icon: Icons.home,
            ),
            const SizedBox(height: 20),

            _buildFormField(
              label: 'Short description',
              initialValue: pet.description,
              icon: Icons.description,
              maxLines: 2,
            ),
            const SizedBox(height: 20),

            _buildFormField(
              label: 'Habits',
              initialValue: pet.habits ?? 'Loves fish, hates to take medicine.',
              icon: Icons.favorite,
              maxLines: 3,
            ),
            const SizedBox(height: 40),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  print('Save tapped for ${pet.name}');
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.lightPink,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.secondaryColor.withOpacity(0.3),
              width: 2,
            ),
          ),
          child: Icon(Icons.pets, size: 50, color: AppColors.secondaryColor),
        ),
        const SizedBox(height: 16),
        Text(
          'Change Photo',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.secondaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFormField({
    required String label,
    required String initialValue,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.secondaryColor.withOpacity(0.2),
            ),
          ),
          child: TextFormField(
            initialValue: initialValue,
            maxLines: maxLines,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: InputBorder.none,
              prefixIcon: Icon(icon, color: AppColors.secondaryColor),
              suffixIcon: Icon(
                Icons.edit_outlined,
                color: AppColors.primaryColor.withOpacity(0.5),
                size: 20,
              ),
            ),
            style: const TextStyle(fontSize: 16, color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}

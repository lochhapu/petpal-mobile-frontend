import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/models/user_profile_model.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({super.key});

  @override
  State<AddPetPage> createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final _nameController = TextEditingController();
  final _speciesController = TextEditingController();
  final _breedController = TextEditingController();
  final _birthController = TextEditingController();
  final _genderController = TextEditingController();
  final _adoptedController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _habitsController = TextEditingController();

  String _selectedSpecies = 'Dog';
  String _selectedGender = 'Male';

  @override
  void dispose() {
    _nameController.dispose();
    _speciesController.dispose();
    _breedController.dispose();
    _birthController.dispose();
    _genderController.dispose();
    _adoptedController.dispose();
    _descriptionController.dispose();
    _habitsController.dispose();
    super.dispose();
  }

  void _savePet() {
    if (_formKey.currentState!.validate()) {
      // Create new pet object
      final newPet = Pet(
        name: _nameController.text,
        description: _descriptionController.text,
        species: _speciesController.text.isNotEmpty
            ? _speciesController.text
            : _selectedSpecies,
        breed: _breedController.text,
        birth: _birthController.text,
        gender: _genderController.text.isNotEmpty
            ? _genderController.text
            : _selectedGender,
        adopted: _adoptedController.text,
        habits: _habitsController.text,
      );

      // Here you would typically save to your backend
      print('New pet created: ${newPet.name}');

      // Navigate back to manage pets page
      Navigator.of(context).pop(newPet);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Add New Pet',
          style: TextStyle(
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Profile Picture Section
              _buildProfilePicture(),
              const SizedBox(height: 30),

              // Name Field
              _buildFormField(
                label: 'Name *',
                controller: _nameController,
                icon: Icons.pets,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter pet name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Species Field with Dropdown
              _buildSpeciesDropdown(),
              const SizedBox(height: 20),

              // Breed Field
              _buildFormField(
                label: 'Breed',
                controller: _breedController,
                icon: Icons.emoji_nature,
                hintText: 'e.g., Golden Retriever, Persian, etc.',
              ),
              const SizedBox(height: 20),

              // Birth Date Field
              _buildFormField(
                label: 'Birth Date',
                controller: _birthController,
                icon: Icons.cake,
                hintText: 'e.g., 15th Mar 2021',
              ),
              const SizedBox(height: 20),

              // Gender Field with Dropdown
              _buildGenderDropdown(),
              const SizedBox(height: 20),

              // Adoption Field
              _buildFormField(
                label: 'Adoption Info',
                controller: _adoptedController,
                icon: Icons.home,
                hintText: 'e.g., Local Shelter, Friend gave, etc.',
                maxLines: 2,
              ),
              const SizedBox(height: 20),

              // Description Field
              _buildFormField(
                label: 'Short Description *',
                controller: _descriptionController,
                icon: Icons.description,
                hintText: 'Tell us about your pet\'s personality',
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Habits Field
              _buildFormField(
                label: 'Habits & Preferences',
                controller: _habitsController,
                icon: Icons.favorite,
                hintText:
                    'e.g., Loves treats, hates baths, favorite toys, etc.',
                maxLines: 3,
              ),
              const SizedBox(height: 40),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _savePet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Add Pet',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
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
          child: Icon(
            Icons.add_photo_alternate_outlined,
            size: 40,
            color: AppColors.secondaryColor,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Add Photo',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.secondaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSpeciesDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Species *',
          style: TextStyle(
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButtonFormField<String>(
              value: _selectedSpecies,
              icon: Icon(
                Icons.arrow_drop_down,
                color: AppColors.secondaryColor,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.category,
                  color: AppColors.secondaryColor,
                ),
              ),
              items:
                  [
                    'Dog',
                    'Cat',
                    'Bird',
                    'Rabbit',
                    'Hamster',
                    'Fish',
                    'Other',
                  ].map((String species) {
                    return DropdownMenuItem<String>(
                      value: species,
                      child: Text(species),
                    );
                  }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSpecies = newValue!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gender *',
          style: TextStyle(
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButtonFormField<String>(
              value: _selectedGender,
              icon: Icon(
                Icons.arrow_drop_down,
                color: AppColors.secondaryColor,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.male, color: AppColors.secondaryColor),
              ),
              items: ['Male', 'Female', 'Unknown'].map((String gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedGender = newValue!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    String? hintText,
    int maxLines = 1,
    String? Function(String?)? validator,
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
            controller: controller,
            maxLines: maxLines,
            validator: validator,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: InputBorder.none,
              hintText: hintText,
              prefixIcon: Icon(icon, color: AppColors.secondaryColor),
            ),
            style: const TextStyle(fontSize: 16, color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}

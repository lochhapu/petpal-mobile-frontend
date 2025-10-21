import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/models/user_profile_model.dart';

class EditAccountPage extends StatefulWidget {
  final UserProfile userProfile;

  const EditAccountPage({super.key, required this.userProfile});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String _selectedGender = 'Female';

  @override
  void initState() {
    super.initState();
    // Initialize form fields with current user data
    _initializeForm();
  }

  void _initializeForm() {
    // Split the name into first and last name
    final nameParts = widget.userProfile.name.split(' ');
    _firstNameController.text = nameParts.isNotEmpty ? nameParts[0] : '';
    _lastNameController.text = nameParts.length > 1
        ? nameParts.sublist(1).join(' ')
        : '';

    _birthController.text = '18th Sept 2003'; // Default value from your design
    _emailController.text = widget.userProfile.email;
    _phoneController.text = widget.userProfile.phone;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Create updated user profile
      final updatedProfile = UserProfile(
        name: '${_firstNameController.text} ${_lastNameController.text}'.trim(),
        email: _emailController.text,
        phone: _phoneController.text,
        pets: widget.userProfile.pets,
        imageUrl: widget.userProfile.imageUrl,
      );

      // Here you would typically save to your backend
      print('Profile updated: ${updatedProfile.name}');

      // Navigate back to profile page
      Navigator.of(context).pop(updatedProfile);
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
          'Edit Profile',
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

              // First Name Field
              _buildFormField(
                label: 'First name',
                controller: _firstNameController,
                icon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Last Name Field
              _buildFormField(
                label: 'Last name',
                controller: _lastNameController,
                icon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter last name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Birth Date Field
              _buildFormField(
                label: 'Birth',
                controller: _birthController,
                icon: Icons.cake_outlined,
                hintText: 'e.g., 18th Sept 2003',
              ),
              const SizedBox(height: 20),

              // Gender Field with Dropdown
              _buildGenderDropdown(),
              const SizedBox(height: 20),

              // Email Field
              _buildFormField(
                label: 'Email',
                controller: _emailController,
                icon: Icons.email_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email address';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Phone Number Field
              _buildFormField(
                label: 'Phone Number',
                controller: _phoneController,
                icon: Icons.phone_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _saveProfile,
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
          child: widget.userProfile.imageUrl != null
              ? ClipOval(
                  child: Image.network(
                    widget.userProfile.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                )
              : Icon(Icons.person, size: 50, color: AppColors.secondaryColor),
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

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gender',
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
                prefixIcon: Icon(
                  Icons.transgender,
                  color: AppColors.secondaryColor,
                ),
              ),
              items: ['Female', 'Male', 'Other'].map((String gender) {
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

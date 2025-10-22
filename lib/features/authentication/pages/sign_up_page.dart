import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../../app.dart'; // Import the main App widget

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
              ),
              const SizedBox(height: 20),

              // Create account text
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign up to get started',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryColor.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 40),

              // Full name field
              _buildFormField(
                label: 'Full Name',
                icon: Icons.person_outlined,
                hintText: 'Enter your full name',
              ),
              const SizedBox(height: 20),

              // Email field
              _buildFormField(
                label: 'Email',
                icon: Icons.email_outlined,
                hintText: 'Enter your email',
              ),
              const SizedBox(height: 20),

              // Password field
              _buildFormField(
                label: 'Password',
                icon: Icons.lock_outlined,
                hintText: 'Create a password',
                isPassword: true,
              ),
              const SizedBox(height: 20),

              // Confirm password field
              _buildFormField(
                label: 'Confirm Password',
                icon: Icons.lock_outlined,
                hintText: 'Confirm your password',
                isPassword: true,
              ),
              const SizedBox(height: 30),

              // Sign Up button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: BACKEND - Replace with actual authentication
                    // For now, navigate to main app with bottom nav bar
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const App()),
                      (Route<dynamic> route) => false,
                    );
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
                    'Sign Up',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Divider with "or"
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: AppColors.primaryColor.withOpacity(0.3),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'or',
                      style: TextStyle(
                        color: AppColors.primaryColor.withOpacity(0.5),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: AppColors.primaryColor.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Already have account button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.secondaryColor,
                    side: BorderSide(
                      color: AppColors.secondaryColor.withOpacity(0.5),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Already have an account? Sign In',
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

  Widget _buildFormField({
    required String label,
    required IconData icon,
    required String hintText,
    bool isPassword = false,
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
            obscureText: isPassword,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: InputBorder.none,
              hintText: hintText,
              prefixIcon: Icon(icon, color: AppColors.secondaryColor),
              suffixIcon: isPassword
                  ? IconButton(
                      onPressed: () {
                        // Toggle password visibility
                      },
                      icon: Icon(
                        Icons.visibility_outlined,
                        color: AppColors.primaryColor.withOpacity(0.5),
                      ),
                    )
                  : null,
            ),
            style: const TextStyle(fontSize: 16, color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}

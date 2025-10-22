import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../../app.dart'; // Import the main App widget
import 'sign_up_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

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
              // Back button and Skip button
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
                  ),
                  const Spacer(),
                  // TEMPORARY: Skip button for testing - REMOVE LATER
                  TextButton(
                    onPressed: () {
                      // TODO: BACKEND - Replace with actual authentication
                      // For now, navigate to main app with bottom nav bar
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const App()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.secondaryColor,
                    ),
                    child: const Text(
                      'Skip for now',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Welcome text
              const Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to continue',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryColor.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 40),

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
                hintText: 'Enter your password',
                isPassword: true,
              ),
              const SizedBox(height: 16),

              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Backend will implement
                    print('Forgot password tapped');
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.secondaryColor,
                  ),
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Sign In button
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
                    'Sign In',
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

              // Create new account button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ),
                    );
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
                    'Create New Account',
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

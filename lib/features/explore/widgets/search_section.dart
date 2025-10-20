import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Explore: Only The Best For You!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            'What are you looking for?',
            style: TextStyle(fontSize: 14, color: AppColors.primaryColor),
          ),

          const SizedBox(height: 16),

          // Search Bar - Fixed text alignment
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.secondaryColor.withOpacity(0.3),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              // Wrap with Center to ensure vertical alignment
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for clinics, stores, shelters...',
                  hintStyle: TextStyle(
                    color: AppColors.primaryColor.withOpacity(0.5),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.secondaryColor,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ), // Center the text vertically
                  isDense: true, // Reduces the height of the input
                ),
                style: const TextStyle(
                  fontSize: 16, // Ensure consistent text size
                ),
                textAlignVertical: TextAlignVertical
                    .center, // Explicitly center text vertically
                onChanged: (value) {
                  // Backend will implement search
                },
                onSubmitted: (value) {
                  // Backend will implement search submission
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

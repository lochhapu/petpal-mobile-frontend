import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class TrackerButtons extends StatelessWidget {
  const TrackerButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        const Text(
          'Trackers',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 16),

        // Buttons Row
        Row(
          children: [
            Expanded(
              child: _buildTrackerButton(
                title: 'Symptom Tracker',
                onTap: () {
                  // Navigate to Symptom Tracker
                  print('Navigate to Symptom Tracker');
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTrackerButton(
                title: 'Treatment Tracker',
                onTap: () {
                  // Navigate to Treatment Tracker
                  print('Navigate to Treatment Tracker');
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrackerButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.lightPink,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.secondaryColor.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

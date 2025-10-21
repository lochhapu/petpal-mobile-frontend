import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../pages/symptom_tracker_page.dart';
import '../pages/treatment_tracker_page.dart'; // Add this import

class TrackerButtons extends StatelessWidget {
  const TrackerButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: _buildTrackerButton(
              title: 'Treatment Tracker',
              onPressed: () {
                // Navigate to treatment tracker page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TreatmentTrackerPage(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildTrackerButton(
              title: 'Symptom Tracker',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SymptomTrackerPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackerButton({
    required String title,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.lightPink,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.secondaryColor.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}

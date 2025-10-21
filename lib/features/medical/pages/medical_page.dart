import 'package:flutter/material.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/treatment_plans_section.dart';
import '../widgets/tracker_buttons.dart';
import '../widgets/medical_history_section.dart';

class MedicalPage extends StatelessWidget {
  const MedicalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBar(), // Using your custom app bar
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Medical Records',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),

            // Treatment Plans Section with vertical scroll
            const Expanded(flex: 2, child: TreatmentPlansSection()),

            const SizedBox(height: 16),

            // Tracker Buttons
            const TrackerButtons(),

            const SizedBox(height: 16),

            // Medical History Section with vertical scroll
            const Expanded(flex: 3, child: MedicalHistorySection()),
          ],
        ),
      ),
    );
  }
}
  
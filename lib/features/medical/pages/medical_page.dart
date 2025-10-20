import 'package:flutter/material.dart';
import '../../../widgets/custom_app_bar.dart';
import '../widgets/treatment_plans_section.dart';
import '../widgets/medical_history_section.dart';
import '../widgets/tracker_buttons.dart';
import '../../../core/constants/app_colors.dart';

class MedicalPage extends StatelessWidget {
  const MedicalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: const MedicalContent(),
    );
  }
}

class MedicalContent extends StatelessWidget {
  const MedicalContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Medical',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ),

          // Treatment Plans Section
          const TreatmentPlansSection(),
          const SizedBox(height: 24),

          // Tracker Buttons
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TrackerButtons(),
          ),
          const SizedBox(height: 24),

          // Medical History Section
          const MedicalHistorySection(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
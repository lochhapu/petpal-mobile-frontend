import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class TreatmentPlansSection extends StatelessWidget {
  const TreatmentPlansSection({super.key});

  // Mock data - your friend will replace with API
  final List<Map<String, dynamic>> treatmentPlans = const [
    {
      'doctor': 'Dr. Mewes',
      'medicine': 'Worm medicine',
      'description':
          'Give him the given pill 3 times a day after meals. Morning, afternoon and evening.',
    },
    {
      'doctor': 'Dr. Mewes',
      'medicine': 'Mite shots',
      'description':
          'Bring him over once a week and give him the shot for three weeks.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Treatment Plans',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 16),

          Expanded(
            child: ListView.builder(
              itemCount: treatmentPlans.length,
              itemBuilder: (context, index) {
                final plan = treatmentPlans[index];
                return _buildTreatmentPlanItem(
                  doctor: plan['doctor'],
                  medicine: plan['medicine'],
                  description: plan['description'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreatmentPlanItem({
    required String doctor,
    required String medicine,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightPink,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.secondaryColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                doctor,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            medicine,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.lightBlue,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

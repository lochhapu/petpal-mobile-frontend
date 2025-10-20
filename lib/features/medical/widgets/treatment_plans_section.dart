import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class TreatmentPlansSection extends StatelessWidget {
  const TreatmentPlansSection({super.key});

  // Mock data - your friend will replace with API data
  final List<Map<String, dynamic>> treatmentPlans = const [
    {
      'id': '1',
      'doctorName': 'Dr. Mirima',
      'treatmentName': 'Worm medicine',
      'instructions': 'Give him the given pill 3 times a day after meals. Morning, afternoon and evening.',
    },
    {
      'id': '2',
      'doctorName': 'Dr. Mirima',
      'treatmentName': 'Time shots',
      'instructions': 'Bring him over once a week and give him the shot for three weeks.',
    },
    {
      'id': '3',
      'doctorName': 'Dr. Johnson',
      'treatmentName': 'Vitamin Supplements',
      'instructions': 'Give one vitamin tablet daily with morning meal for the next 30 days.',
    },
    {
      'id': '4',
      'doctorName': 'Dr. Smith',
      'treatmentName': 'Dental Cleaning',
      'instructions': 'Schedule dental cleaning appointment within the next two weeks.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          const Text(
            'Treatment Plans',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 16),

          // Treatment Plans List with Internal Scrolling
          Container(
            height: 300, // Fixed height to enable internal scrolling
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: treatmentPlans.isEmpty
                ? const Center(
                    child: Text(
                      'No treatment plans available',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: treatmentPlans.length,
                    itemBuilder: (context, index) {
                      final plan = treatmentPlans[index];
                      return TreatmentPlanCard(
                        doctorName: plan['doctorName'],
                        treatmentName: plan['treatmentName'],
                        instructions: plan['instructions'],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class TreatmentPlanCard extends StatelessWidget {
  final String doctorName;
  final String treatmentName;
  final String instructions;

  const TreatmentPlanCard({
    super.key,
    required this.doctorName,
    required this.treatmentName,
    required this.instructions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightPink,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.secondaryColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor Name
          Text(
            doctorName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 8),

          // Treatment Name
          Text(
            treatmentName,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 8),

          // Instructions
          Text(
            instructions,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
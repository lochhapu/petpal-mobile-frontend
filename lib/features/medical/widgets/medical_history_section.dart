import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class MedicalHistorySection extends StatelessWidget {
  const MedicalHistorySection({super.key});

  // Mock data - your friend will replace with API data
  final List<Map<String, dynamic>> medicalHistory = const [
    {
      'id': '1',
      'doctorName': 'Dr. Mirima | Zoe Fna 2014',
      'treatmentName': 'Worm Medicine',
      'description': 'Toby was diagnosed with Worms. Received de-worming medicine.',
    },
    {
      'id': '2',
      'doctorName': 'Dr. Monewell | Siza Jan 2004',
      'treatmentName': 'Second Official Check Up',
      'description': 'Toby received his second check up. We have the second stage of vaccination planned.',
    },
    {
      'id': '3',
      'doctorName': 'Dr. Anderson | March 2023',
      'treatmentName': 'Annual Checkup',
      'description': 'Routine annual checkup completed. All vitals are normal and healthy.',
    },
    {
      'id': '4',
      'doctorName': 'Dr. Wilson | November 2022',
      'treatmentName': 'Vaccination Update',
      'description': 'Updated all required vaccinations. Next due in one year.',
    },
    {
      'id': '5',
      'doctorName': 'Dr. Parker | July 2022',
      'treatmentName': 'Dental Examination',
      'description': 'Teeth cleaning and dental checkup completed. No issues found.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title and View Full History Button
          Row(
            children: [
              const Text(
                'Medical History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Navigate to full medical history
                  print('View full medical history');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: const Text(
                  'View Full History',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Medical History List with Internal Scrolling
          Container(
            height: 300, // Fixed height to enable internal scrolling
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: medicalHistory.isEmpty
                ? const Center(
                    child: Text(
                      'No medical history available',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: medicalHistory.length,
                    itemBuilder: (context, index) {
                      final history = medicalHistory[index];
                      return MedicalHistoryCard(
                        doctorName: history['doctorName'],
                        treatmentName: history['treatmentName'],
                        description: history['description'],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class MedicalHistoryCard extends StatelessWidget {
  final String doctorName;
  final String treatmentName;
  final String description;

  const MedicalHistoryCard({
    super.key,
    required this.doctorName,
    required this.treatmentName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor Name and Date
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

          // Description
          Text(
            description,
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
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../pages/full_medical_history_page.dart'; // Add this import

class MedicalHistorySection extends StatelessWidget {
  const MedicalHistorySection({super.key});

  // Mock data - your friend will replace with API data
  final List<Map<String, dynamic>> medicalHistory = const [
    {
      'id': '1',
      'doctorName': 'Dr. Mirima | Zoe Fna 2014',
      'treatmentName': 'Worm Medicine',
      'description':
          'Toby was diagnosed with Worms. Received de-worming medicine.',
    },
    {
      'id': '2',
      'doctorName': 'Dr. Monewell | Siza Jan 2004',
      'treatmentName': 'Second Official Check Up',
      'description':
          'Toby received his second check up. We have the second stage of vaccination planned.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Medical History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              Container(
                height: 36,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FullMedicalHistoryPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: const Text(
                    'View Full History',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: medicalHistory.isEmpty
                  ? const Center(
                      child: Text(
                        'No medical history available',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
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
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doctorName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            treatmentName,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

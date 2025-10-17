import 'package:flutter/material.dart';
import 'vaccination_card.dart';
import '../../../core/constants/app_colors.dart';

class VaccinationsList extends StatelessWidget {
  const VaccinationsList({super.key});

  // Mock data - your friend will replace this with API data
  final List<Map<String, dynamic>> vaccinations = const [
    {
      'id': '1',
      'vaccineName': 'Toby\'s Rabies Vaccination Due',
      'timeRange': 'Within 2 weeks',
      'doctorName': 'Dr. Monroore',
      'vetImage': 'assets/images/dr_monroore.jpg',
    },
    {
      'id': '2',
      'vaccineName': 'Bazuka\'s Herpes Vaccination Due',
      'timeRange': 'Within 3 days',
      'doctorName': 'Dr. Mentos',
      'vetImage': 'assets/images/dr_mentos.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: vaccinations.length,
            itemBuilder: (context, index) {
              final vaccination = vaccinations[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: VaccinationCard(
                  vaccineName: vaccination['vaccineName'],
                  timeRange: vaccination['timeRange'],
                  doctorName: vaccination['doctorName'],
                  vetImage: vaccination['vetImage'],
                  onTap: () {
                    // Navigation to vaccination details - your friend will implement
                    print('Navigate to vaccination ${vaccination['id']}');
                  },
                ),
              );
            },
          ),
        ),

        // "Show for all pets" button
        Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Your friend will implement this
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primaryColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: AppColors.primaryColor.withOpacity(0.3),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'Show for all pets',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}

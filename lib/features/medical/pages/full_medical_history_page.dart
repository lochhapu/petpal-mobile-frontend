import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../widgets/custom_app_bar.dart';
import 'treatment_detail_page.dart';

class FullMedicalHistoryPage extends StatefulWidget {
  const FullMedicalHistoryPage({super.key});

  @override
  State<FullMedicalHistoryPage> createState() => _FullMedicalHistoryPageState();
}

class _FullMedicalHistoryPageState extends State<FullMedicalHistoryPage> {
  // Mock data - your friend will replace with API
  final List<Map<String, dynamic>> medicalHistory = [
    {
      'id': '1',
      'doctor': 'Dr. Mentos',
      'date': '2nd Feb 2024',
      'title': 'Worm medicine',
      'description': 'Toby was diagnosed with Worms. Received de-worming medicine.',
      'treatmentDetails': {
        'medicine': 'Worm Medication',
        'description': 'Expels Deworming Tablets',
        'startDate': '12-Jun-2023',
        'endDate': '16-Jun-2023',
        'schedule': [
          {'day': 'Day 1', 'morning': true, 'afternoon': false, 'evening': false},
          {'day': 'Day 2', 'morning': false, 'afternoon': false, 'evening': false},
          {'day': 'Day 3', 'morning': false, 'afternoon': false, 'evening': false},
          {'day': 'Day 4', 'morning': false, 'afternoon': false, 'evening': false},
        ],
      },
    },
    {
      'id': '2',
      'doctor': 'Dr. Momore',
      'date': '15th Jan 2024',
      'title': 'Second official check up',
      'description': 'Toby received his second check up. We have the second stage of vaccinations planned.',
    },
    {
      'id': '3',
      'doctor': 'Dr. Mentos',
      'date': '1st Jan 2024',
      'title': 'First official check up',
      'description': 'Toby received his first official check up. We have the first stage of vaccinations planned.',
    },
  ];

  final List<String> longTermIssues = [
    'Consistent toe infection.',
  ];

  final List<String> allergies = [
    'Canned fish.',
  ];

  void _showTreatmentDetails(Map<String, dynamic> treatment) {
    if (treatment['treatmentDetails'] != null) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => TreatmentDetailPage(
          treatment: treatment['treatmentDetails'],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Medical History',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 8),

              // Click to view treatments note
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.lightPink,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.secondaryColor.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.secondaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Click to view treatments.',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Medical History List - VERTICALLY SCROLLABLE
              Expanded(
                child: ListView(
                  children: [
                    // Medical History Items
                    ...medicalHistory.map((history) => _buildMedicalHistoryItem(history)).toList(),

                    const SizedBox(height: 24),

                    // Long term issues section
                    _buildSection(
                      title: 'Long term issues:',
                      items: longTermIssues,
                    ),

                    const SizedBox(height: 20),

                    // Allergies section
                    _buildSection(
                      title: 'Allergies:',
                      items: allergies,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMedicalHistoryItem(Map<String, dynamic> history) {
    final hasTreatment = history['treatmentDetails'] != null;
    
    return GestureDetector(
      onTap: hasTreatment ? () => _showTreatmentDetails(history) : null,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.lightBlue.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${history['doctor']} | ${history['date']}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
                if (hasTreatment)
                  Icon(
                    Icons.medical_services,
                    color: AppColors.secondaryColor,
                    size: 16,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              history['title'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              history['description'],
              style: TextStyle(
                fontSize: 14,
                color: AppColors.lightBlue,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required List<String> items}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightPink,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.secondaryColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: const BoxDecoration(
                    color: AppColors.secondaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }
}
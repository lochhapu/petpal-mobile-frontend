import 'package:flutter/material.dart';
import '../pages/vaccination_details_page.dart';
import '../../../core/constants/app_colors.dart';

class VaccinationCard extends StatelessWidget {
  final String vaccineName;
  final String timeRange;
  final String doctorName;
  final String vetImage;
  final VoidCallback onTap;

  const VaccinationCard({
    super.key,
    required this.vaccineName,
    required this.timeRange,
    required this.doctorName,
    required this.vetImage,
    required this.onTap,
  });

  Color _getTimeRangeColor(String timeRange) {
    if (timeRange.toLowerCase().contains('days')) {
      return Colors.orange; // Urgent - orange
    } else if (timeRange.toLowerCase().contains('weeks')) {
      return Colors.blue; // Upcoming - blue
    }
    return AppColors.primaryColor; // Default
  }

  @override
  Widget build(BuildContext context) {
    final timeRangeColor = _getTimeRangeColor(timeRange);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VaccinationDetailPage(
              doctorName: doctorName,
              clinicName: _extractClinicName(doctorName), // Helper method
              vaccineName: vaccineName,
              timeRange: timeRange,
              vetImage: vetImage,
              isVerified: true, // This would come from backend
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Veterinarian Image
            Container(
              width: 80,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: Icon(
                Icons.person,
                color: AppColors.primaryColor.withOpacity(0.5),
                size: 40,
              ),
            ),

            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vaccineName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: timeRangeColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            timeRange,
                            style: TextStyle(
                              fontSize: 12,
                              color: timeRangeColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          doctorName,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _extractClinicName(String doctorName) {
  // Simple extraction - backend would provide proper clinic name
  if (doctorName.contains('Monroore')) return 'Hope Veterinary, Battaramula';
  if (doctorName.contains('Mentos')) return 'Hope Veterinary, Battaramula';
  return 'Local Veterinary Clinic'; // Default
}

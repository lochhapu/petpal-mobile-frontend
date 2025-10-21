import 'package:flutter/material.dart';
import '../pages/appointment_details_page.dart';
import '../../../core/constants/app_colors.dart';

class AppointmentCard extends StatelessWidget {
  final String clinicName;
  final String date;
  final String status;
  final Color statusColor;
  final String appointmentNumber;
  final String clinicImage;
  final VoidCallback onTap;

  const AppointmentCard({
    super.key,
    required this.clinicName,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.appointmentNumber,
    required this.clinicImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AppointmentDetailPage(
              clinicName: clinicName,
              address: _extractAddress(clinicName),
              status: status,
              date: date,
              appointmentNumber: appointmentNumber,
              doctorName: 'Dr. Robert Monroore',
              slotTime: date, // Or extract just the time part
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
            // Clinic Image
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
                Icons.business,
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
                      clinicName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              fontSize: 12,
                              color: statusColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          appointmentNumber,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
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

String _extractAddress(String clinicName) {
  // Simple extraction - backend would provide proper address
  if (clinicName.contains('Bartharamula')) return 'Bartharamula, Colombo';
  if (clinicName.contains('Boston')) return 'Boston, MA';
  if (clinicName.contains('Wijerama')) return 'Wijerama, Colombo';
  return 'Colombo, Sri Lanka'; // Default
}

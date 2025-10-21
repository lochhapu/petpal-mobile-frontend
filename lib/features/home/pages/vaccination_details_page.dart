import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class VaccinationDetailPage extends StatelessWidget {
  final String doctorName;
  final String clinicName;
  final String vaccineName;
  final String timeRange;
  final String vetImage;
  final bool isVerified;

  const VaccinationDetailPage({
    super.key,
    required this.doctorName,
    required this.clinicName,
    required this.vaccineName,
    required this.timeRange,
    required this.vetImage,
    required this.isVerified,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Vaccination',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Header Section - No tap effect here
              _buildDoctorHeader(),
              const SizedBox(height: 30),

              // About Vaccination Section - No tap effect here
              _buildAboutVaccination(),
              const SizedBox(height: 30),

              // Action Buttons - These should have tap effects
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorHeader() {
    final timeRangeColor = _getTimeRangeColor(timeRange);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightPink,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.secondaryColor.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Veterinarian Image - No GestureDetector here
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 40),
          ),
          const SizedBox(width: 16),

          // Doctor Info - No GestureDetector here
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor Name and Verification
                Row(
                  children: [
                    Text(
                      doctorName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (isVerified)
                      Icon(Icons.verified, color: Colors.blue, size: 18),
                  ],
                ),
                const SizedBox(height: 4),

                // Clinic Name
                Text(
                  clinicName,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryColor.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 8),

                // Vaccine Name
                Text(
                  vaccineName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),

                // Time Range
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutVaccination() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About vaccination',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          _getVaccineDescription(vaccineName),
          style: TextStyle(
            fontSize: 14,
            color: AppColors.primaryColor.withOpacity(0.8),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        // Message Doctor Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Backend will implement message doctor
              print('Message Doctor: $doctorName');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Message Doctor',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Set Appointment Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              // Backend will implement set appointment
              print('Set appointment with $doctorName');
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryColor,
              side: BorderSide(
                color: AppColors.secondaryColor.withOpacity(0.3),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.white,
            ),
            child: const Text(
              'Set appointment',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Call and Message Clinic Buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  // Backend will implement call clinic
                  print('Call clinic: $clinicName');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryColor,
                  side: BorderSide(
                    color: AppColors.secondaryColor.withOpacity(0.3),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.call_outlined, size: 20),
                    SizedBox(width: 8),
                    Text('Call clinic'),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  // Backend will implement message clinic
                  print('Message clinic: $clinicName');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryColor,
                  side: BorderSide(
                    color: AppColors.secondaryColor.withOpacity(0.3),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.message_outlined, size: 20),
                    SizedBox(width: 8),
                    Text('Message clinic'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Helper Methods
  Color _getTimeRangeColor(String timeRange) {
    if (timeRange.toLowerCase().contains('days')) {
      return Colors.orange;
    } else if (timeRange.toLowerCase().contains('weeks')) {
      return Colors.blue;
    }
    return AppColors.primaryColor;
  }

  String _getVaccineDescription(String vaccineName) {
    switch (vaccineName.toLowerCase()) {
      case 'rabies vaccination':
        return 'The rabies vaccine is an important shot that protects your pet from the deadly rabies virus. It also helps keep your family and community safe. Please make sure your pet receives it on schedule for full protection.';
      case 'herpes vaccination':
        return 'The herpes vaccine helps protect your pet from viral infections that can cause respiratory issues and other health problems. Regular vaccination is recommended for optimal protection.';
      default:
        return 'This vaccination is essential for your pet\'s health and wellbeing. It provides protection against common diseases and helps maintain their immune system. Please consult with your veterinarian for specific details.';
    }
  }
}

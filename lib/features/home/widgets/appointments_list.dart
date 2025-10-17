import 'package:flutter/material.dart';
import 'appointment_card.dart';
import '../../../core/constants/app_colors.dart';

class AppointmentsList extends StatelessWidget {
  const AppointmentsList({super.key});

  // Mock data - thusathmi can replace with real API data
  final List<Map<String, dynamic>> appointments = const [
    {
      'id': '1',
      'clinicName': 'Hope Veterinary, Bartharamula',
      'date': 'Monday 12th May @ 12:30 PM',
      'status': 'Pending',
      'statusColor': Colors.orange,
      'appointmentNumber': '#23',
      'clinicImage': 'assets/images/hope_vet.jpg', // real images here
    },
    {
      'id': '2',
      'clinicName': 'Boston Adoption Center',
      'date': 'Sunday 11th May @ 03:00 PM',
      'status': 'Confirmed',
      'statusColor': Colors.green,
      'appointmentNumber': '#47',
      'clinicImage': 'assets/images/boston_adoption.jpg',
    },
    {
      'id': '3',
      'clinicName': 'Free Bird Veterinary, Wijerama',
      'date': 'Sunday 10th May @ 09:30 AM',
      'status': 'Canceled',
      'statusColor': Colors.red,
      'appointmentNumber': '#5',
      'clinicImage': 'assets/images/free_bird_vet.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: AppointmentCard(
                  clinicName: appointment['clinicName'],
                  date: appointment['date'],
                  status: appointment['status'],
                  statusColor: appointment['statusColor'],
                  appointmentNumber: appointment['appointmentNumber'],
                  clinicImage: appointment['clinicImage'],
                  onTap: () {
                    // Navigation to appointment details - TODO
                    print('Navigate to appointment ${appointment['id']}');
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
              // Have to implement this
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

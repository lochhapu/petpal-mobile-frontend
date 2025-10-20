import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'place_card.dart';

class PinnedPlacesSection extends StatelessWidget {
  const PinnedPlacesSection({super.key});

  // Mock data - backend will replace this
  final List<Map<String, dynamic>> pinnedPlaces = const [
    {
      'id': '1',
      'title': 'Hope veterinary',
      'address': 'Batharamula, Colombo',
      'status': 'Open Now',
      'hours': 'Closes 8:30 PM',
      'rating': 4.9,
      'type': 'Clinic',
      'icon': 'clinic',
    },
    {
      'id': '2',
      'title': 'Free Bird Stores',
      'address': 'Malabe, Colombo',
      'status': 'Close',
      'hours': 'Opens 7:30 AM',
      'rating': 4.3,
      'type': 'Store',
      'icon': 'store',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header with "Show for all pets" button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Pinned Places',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Backend will implement this
                },
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.secondaryColor,
                ),
                child: const Text(
                  'Show for all pets',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Horizontal scrollable cards
          SizedBox(
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: pinnedPlaces.length,
              itemBuilder: (context, index) {
                final place = pinnedPlaces[index];
                return PlaceCard(
                  title: place['title'],
                  address: place['address'],
                  status: place['status'],
                  hours: place['hours'],
                  rating: place['rating'],
                  type: place['type'],
                  icon: place['icon'],
                  onTap: () {
                    // Backend will implement navigation
                    print('Navigate to ${place['title']}');
                  },
                  showType: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

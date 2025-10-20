import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'place_card.dart';

class RecentSearchesSection extends StatelessWidget {
  const RecentSearchesSection({super.key});

  // Mock data - backend will replace this
  final List<Map<String, dynamic>> recentSearches = const [
    {
      'id': '1',
      'title': 'Hope veterinary',
      'address': 'Batharamula, Colombo',
      'status': 'Open Now',
      'hours': 'Closes 8:30 PM',
      'rating': 4.3,
      'type': 'Clinic',
      'icon': 'clinic',
    },
    {
      'id': '2',
      'title': 'Pet net',
      'address': 'Malabe, Colombo',
      'status': 'Close',
      'hours': 'Opens 7:30 AM',
      'rating': 4.3,
      'type': 'Store',
      'icon': 'store',
    },
    {
      'id': '3',
      'title': 'Vie\'s Buddies',
      'address': 'Colombo',
      'status': 'Open Now',
      'hours': 'Closes 9:00 PM',
      'rating': 4.3,
      'type': 'Shelter',
      'icon': 'view',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Searches',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),

          const SizedBox(height: 16),

          // Horizontal scrollable cards
          SizedBox(
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recentSearches.length,
              itemBuilder: (context, index) {
                final place = recentSearches[index];
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

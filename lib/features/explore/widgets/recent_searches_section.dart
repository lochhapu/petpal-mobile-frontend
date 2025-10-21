import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'place_card.dart';
import '../pages/place_detail_page.dart'; // Add this import

class RecentSearchesSection extends StatefulWidget {
  const RecentSearchesSection({super.key});

  @override
  State<RecentSearchesSection> createState() => _RecentSearchesSectionState();
}

class _RecentSearchesSectionState extends State<RecentSearchesSection> {
  // Mock data - backend will replace this
  List<Map<String, dynamic>> recentSearches = [
    {
      'id': '1',
      'title': 'Hope veterinary',
      'address': 'Batharamula, Colombo',
      'status': 'Open Now',
      'hours': 'Closes 8:30 PM',
      'rating': 4.3,
      'type': 'Clinic',
      'icon': 'clinic',
      'isPinned': false,
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
      'isPinned': false,
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
      'isPinned': false,
    },
  ];

  void _togglePin(int index) {
    setState(() {
      recentSearches[index]['isPinned'] = !recentSearches[index]['isPinned'];
      print(
        '${recentSearches[index]['title']} ${recentSearches[index]['isPinned'] ? 'pinned' : 'unpinned'}',
      );
    });
  }

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
                  isPinned: place['isPinned'],
                  onTap: () {
                    // Navigate to place detail page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaceDetailPage(
                          placeName: place['title'],
                          placeType: place['type'],
                          address: place['address'],
                          status: place['status'],
                          hours: place['hours'],
                          rating: place['rating'],
                        ),
                      ),
                    );
                  },
                  onPinPressed: () => _togglePin(index),
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

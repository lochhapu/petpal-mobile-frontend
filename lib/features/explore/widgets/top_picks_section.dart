import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'place_card.dart';
import '../pages/place_detail_page.dart'; // Add this import

class TopPicksSection extends StatefulWidget {
  const TopPicksSection({super.key});

  @override
  State<TopPicksSection> createState() => _TopPicksSectionState();
}

class _TopPicksSectionState extends State<TopPicksSection> {
  // Mock data for top picks
  final List<Map<String, dynamic>> topPicks = [
    {
      'id': '3',
      'title': 'Animal Rescue Center',
      'address': 'Kandy',
      'status': 'Open Now',
      'hours': 'Closes 6:00 PM',
      'rating': 4.7,
      'type': 'Shelter',
      'icon': 'shelter',
      'isPinned': false,
    },
    {
      'id': '4',
      'title': 'Pet Paradise Store',
      'address': 'Gampaha',
      'status': 'Open Now',
      'hours': 'Closes 9:00 PM',
      'rating': 4.5,
      'type': 'Store',
      'icon': 'store',
      'isPinned': false,
    },
    // Add more places...
  ];

  void _togglePin(int index) {
    setState(() {
      topPicks[index]['isPinned'] = !topPicks[index]['isPinned'];
      print(
        '${topPicks[index]['title']} ${topPicks[index]['isPinned'] ? 'pinned' : 'unpinned'}',
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
            'Top Picks For You',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: topPicks.length,
              itemBuilder: (context, index) {
                final place = topPicks[index];
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

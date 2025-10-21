import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'place_card.dart';
import '../pages/place_detail_page.dart'; // Add this import

class PinnedPlacesSection extends StatefulWidget {
  const PinnedPlacesSection({super.key});

  @override
  State<PinnedPlacesSection> createState() => _PinnedPlacesSectionState();
}

class _PinnedPlacesSectionState extends State<PinnedPlacesSection> {
  // Mock data - backend will replace this
  List<Map<String, dynamic>> pinnedPlaces = [
    {
      'id': '1',
      'title': 'Hope veterinary',
      'address': 'Batharamula, Colombo',
      'status': 'Open Now',
      'hours': 'Closes 8:30 PM',
      'rating': 4.9,
      'type': 'Clinic',
      'icon': 'clinic',
      'isPinned': true,
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
      'isPinned': true,
    },
  ];

  void _togglePin(int index) {
    setState(() {
      pinnedPlaces[index]['isPinned'] = !pinnedPlaces[index]['isPinned'];

      // If unpinned, remove from the list after a short delay for smooth animation
      if (!pinnedPlaces[index]['isPinned']) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            setState(() {
              pinnedPlaces.removeAt(index);
            });
          }
        });
      }
    });
  }

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
            child: pinnedPlaces.isEmpty
                ? const Center(
                    child: Text(
                      'No pinned places yet',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.builder(
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

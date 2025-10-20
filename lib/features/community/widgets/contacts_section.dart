import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ContactsSection extends StatelessWidget {
  const ContactsSection({super.key});

  // Mock data - your friend will replace with API data
  final List<Map<String, dynamic>> contacts = const [
    {
      'id': '1',
      'name': 'Jason',
      'image': 'assets/images/jason.jpg',
      'isOnline': true,
    },
    {
      'id': '2', 
      'name': 'Dr. Slim',
      'image': 'assets/images/dr_hyderabad.jpg',
      'isOnline': false,
    },
    {
      'id': '3',
      'name': 'Dr. Mentos', 
      'image': 'assets/images/dr_mentos.jpg',
      'isOnline': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Contacts',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 12),
        
        // Horizontal Contacts List with fixed height
        SizedBox(
          height: 90, // Fixed height to prevent overflow
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16, right: 16),
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return ContactItem(
                name: contact['name'],
                imageUrl: contact['image'],
                isOnline: contact['isOnline'],
                onTap: () {
                  // Navigate to chat with this contact
                  print('Start chat with ${contact['name']}');
                },
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class ContactItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final bool isOnline;
  final VoidCallback onTap;

  const ContactItem({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.isOnline,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        width: 60, // Reduced width
        child: Column(
          children: [
            // Contact Avatar with Online Indicator
            Stack(
              children: [
                Container(
                  width: 50, // Reduced size
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.lightPink,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person,
                    color: AppColors.secondaryColor,
                    size: 24,
                  ),
                ),
                if (isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12, // Reduced size
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            // Contact Name
            Text(
              name,
              style: const TextStyle(
                fontSize: 11, // Smaller font
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'contact_details_panel.dart'; // Add this import

class ContactsSection extends StatefulWidget {
  const ContactsSection({super.key});

  @override
  State<ContactsSection> createState() => _ContactsSectionState();
}

class _ContactsSectionState extends State<ContactsSection> {
  OverlayEntry? _contactDetailsOverlay;

  // Enhanced mock data with contact details
  final List<Map<String, dynamic>> contacts = const [
    {
      'id': '1',
      'name': 'Jason',
      'image': 'assets/images/jason.jpg',
      'isOnline': true,
      'email': 'jason.petowner@gmail.com',
      'phone': '+94 256 8909',
      'location': 'Hydrabad Mann',
      'pet': 'Brown husky',
      'petBreed': 'Bury',
    },
    {
      'id': '2', 
      'name': 'Dr. Slim',
      'image': 'assets/images/dr_hyderabad.jpg',
      'isOnline': false,
      'email': 'hydrabad.moke@gmail.com',
      'phone': '+94 256 8909',
      'location': 'Hydrabad Mann',
      'pet': 'Brown husky',
      'petBreed': 'Bury',
    },
    {
      'id': '3',
      'name': 'Dr. Mentos', 
      'image': 'assets/images/dr_mentos.jpg',
      'isOnline': true,
      'email': 'dr.mentos@vetclinic.com',
      'phone': '+94 256 8909',
      'location': 'Hydrabad Mann',
      'pet': 'Brown husky',
      'petBreed': 'Bury',
    },
  ];

  void _showContactDetails(BuildContext context, Map<String, dynamic> contact) {
    // Remove any existing overlay first
    _hideContactDetails();

    _contactDetailsOverlay = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Background dim
          GestureDetector(
            onTap: _hideContactDetails,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Contact details panel
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ContactDetailsPanel(
                contact: contact,
                onClose: _hideContactDetails,
                onMessage: () {
                  _hideContactDetails();
                  // Navigate to chat screen - your friend can implement this
                  print('Start chat with ${contact['name']}');
                },
                onCall: () {
                  _hideContactDetails();
                  // Initiate call - your friend can implement this
                  print('Call ${contact['name']}');
                },
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_contactDetailsOverlay!);
  }

  void _hideContactDetails() {
    _contactDetailsOverlay?.remove();
    _contactDetailsOverlay = null;
  }

  @override
  void dispose() {
    _hideContactDetails();
    super.dispose();
  }

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
          height: 90,
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
                  _showContactDetails(context, contact);
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
        width: 60,
        child: Column(
          children: [
            // Contact Avatar with Online Indicator
            Stack(
              children: [
                Container(
                  width: 50,
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
                      width: 12,
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
                fontSize: 11,
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
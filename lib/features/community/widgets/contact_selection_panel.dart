import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'contact_list_item.dart';
import '../pages/chat_screen.dart';

class ContactSelectionPanel extends StatefulWidget {
  const ContactSelectionPanel({super.key});

  @override
  State<ContactSelectionPanel> createState() => _ContactSelectionPanelState();
}

class _ContactSelectionPanelState extends State<ContactSelectionPanel> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredContacts = [];

  // Mock contacts data - your friend will replace with API
  final List<Map<String, dynamic>> _allContacts = [
    {
      'id': '1',
      'name': 'Jason',
      'email': 'jason.petowner@gmail.com',
      'isOnline': true,
      'lastSeen': '2 mins ago',
    },
    {
      'id': '2',
      'name': 'Dr. Slim',
      'email': 'hydrabad.moke@gmail.com',
      'isOnline': false,
      'lastSeen': '12 mins ago',
    },
    {
      'id': '3',
      'name': 'Dr. Mentos',
      'email': 'dr.mentos@vetclinic.com',
      'isOnline': true,
      'lastSeen': 'Online',
    },
    {
      'id': '4',
      'name': 'Sarah Wilson',
      'email': 'sarah.wilson@email.com',
      'isOnline': false,
      'lastSeen': '1 hour ago',
    },
    {
      'id': '5',
      'name': 'Mike Johnson',
      'email': 'mike.johnson@email.com',
      'isOnline': true,
      'lastSeen': 'Online',
    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredContacts = _allContacts;
    _searchController.addListener(_filterContacts);
  }

  void _filterContacts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredContacts = _allContacts;
      } else {
        _filteredContacts = _allContacts.where((contact) {
          return contact['name'].toLowerCase().contains(query) ||
              contact['email'].toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  void _startChat(BuildContext context, Map<String, dynamic> contact) {
    // Close the panel first
    Navigator.pop(context);

    // Then navigate to chat screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          contactName: contact['name'],
          contactImage: '', // Your friend can add image URLs
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8, // 80% of screen height
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Row(
            children: [
              const Text(
                'New Chat',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close, color: AppColors.primaryColor),
              ),
            ],
          ),

          // Search Bar
          Container(
            height: 50,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search contacts...',
                hintStyle: TextStyle(color: Colors.grey[600], height: 1.0),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 15,
                ),
                isDense: true,
              ),
            ),
          ),

          // Contacts List
          Expanded(
            child: _filteredContacts.isEmpty
                ? const Center(
                    child: Text(
                      'No contacts found',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredContacts.length,
                    itemBuilder: (context, index) {
                      final contact = _filteredContacts[index];
                      return ContactListItem(
                        name: contact['name'],
                        email: contact['email'],
                        isOnline: contact['isOnline'],
                        lastSeen: contact['lastSeen'],
                        onTap: () => _startChat(context, contact),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

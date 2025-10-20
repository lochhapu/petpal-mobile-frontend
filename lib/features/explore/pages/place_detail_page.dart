import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class PlaceDetailPage extends StatelessWidget {
  final String placeName;
  final String placeType;
  final String address;
  final String status;
  final String hours;
  final double rating;

  const PlaceDetailPage({
    super.key,
    required this.placeName,
    required this.placeType,
    required this.address,
    required this.status,
    required this.hours,
    required this.rating,
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
            Navigator.pop(context); // Go back to explore page
          },
        ),
        title: Text(
          'About place',
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
              // Place Header Section
              _buildPlaceHeader(),
              const SizedBox(height: 30),

              // About Us Section
              _buildAboutUsSection(),
              const SizedBox(height: 30),

              // Book a Slot Section
              _buildBookSlotSection(),
              const SizedBox(height: 30),

              // Reviews Section
              _buildReviewsSection(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightPink,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.secondaryColor.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          // Main content row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Place Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getIconForType(placeType),
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 12),

              // Place Info - Made flexible
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      placeName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                      maxLines: 2, // Allow title to wrap
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      address,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryColor.withOpacity(0.7),
                      ),
                      maxLines: 2, // Allow address to wrap
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(status).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              fontSize: 12,
                              color: _getStatusColor(status),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          hours,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primaryColor.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Action Buttons - Moved to a separate row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    // Backend will implement call functionality
                    print('Call $placeName');
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.call_outlined,
                        color: AppColors.secondaryColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Call',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 20,
                color: AppColors.secondaryColor.withOpacity(0.3),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    // Backend will implement message functionality
                    print('Message $placeName');
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.message_outlined,
                        color: AppColors.secondaryColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Message',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAboutUsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About us',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Our veterinary clinic is dedicated to providing compassionate and professional care for your pets. We offer a wide range of services including check-ups, vaccinations, treatments, and preventive care to keep our furry friends healthy and happy. With a caring team and a welcoming environment, we treat every pet as part of our family.',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.primaryColor.withOpacity(0.8),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildBookSlotSection() {
    // Dummy data - backend will replace
    final availableDays = ['Tomorrow', 'Friday', 'Saturday'];
    final availableDoctors = ['Any', 'Dr. Smith', 'Dr. Johnson', 'Dr. Brown'];
    final availableSlots = [
      '9:00 AM',
      '10:30 AM',
      '1:00 PM',
      '3:30 PM',
      '5:00 PM',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Book a slot',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 20),

        // Day and Doctor Selector
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select day:',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.secondaryColor.withOpacity(0.3),
                      ),
                    ),
                    child: DropdownButton<String>(
                      value: availableDays[0],
                      isExpanded: true,
                      underline: const SizedBox(),
                      items: availableDays.map((String day) {
                        return DropdownMenuItem<String>(
                          value: day,
                          child: Text(day),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        // Backend will implement
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Doctor:',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.secondaryColor.withOpacity(0.3),
                      ),
                    ),
                    child: DropdownButton<String>(
                      value: availableDoctors[0],
                      isExpanded: true,
                      underline: const SizedBox(),
                      items: availableDoctors.map((String doctor) {
                        return DropdownMenuItem<String>(
                          value: doctor,
                          child: Text(doctor),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        // Backend will implement
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Slots Available Text
        const Text(
          'Slots available tomorrow:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 16),

        // Time Slots Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.5,
          ),
          itemCount: availableSlots.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.lightPink,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.secondaryColor.withOpacity(0.3),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  // Backend will implement slot selection
                  print('Selected slot: ${availableSlots[index]}');
                },
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.all(8),
                ),
                child: Text(
                  availableSlots[index],
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildReviewsSection() {
    // Dummy reviews - backend will replace
    final reviews = [
      {
        'user': 'Toby Maguire',
        'rating': 4.5,
        'comment': 'They cured my dog!',
        'time': '6 days ago',
      },
      {
        'user': 'Chandani Hapu',
        'rating': 4.0,
        'comment':
            'Great service, my cat had a rash and the doctors were very nice and they charge fairly as well',
        'time': '2 weeks ago',
      },
      {
        'user': 'Hydrabad Ganster',
        'rating': 4.0,
        'comment': 'My canine got cured yo!',
        'time': '1 month ago',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reviews',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 16),

        // Overall Rating
        Row(
          children: [
            const Text(
              'Overall:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.star, color: Colors.amber, size: 20),
            Icon(Icons.star, color: Colors.amber, size: 20),
            Icon(Icons.star, color: Colors.amber, size: 20),
            Icon(Icons.star, color: Colors.amber, size: 20),
            Icon(Icons.star_half, color: Colors.amber, size: 20),
            const SizedBox(width: 8),
            Text(
              rating.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        /*
        Text(
          '#5E16TB', // Some identifier - backend will provide
          style: TextStyle(
            fontSize: 14,
            color: AppColors.primaryColor.withOpacity(0.6),
          ),
        ),
        */
        const SizedBox(height: 20),

        // Individual Reviews
        Column(
          children: reviews.map((review) {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.secondaryColor.withOpacity(0.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        review['user'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            review['rating'].toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Icon(Icons.star, color: Colors.amber, size: 16),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Comment
                  Text(
                    review['comment'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primaryColor.withOpacity(0.8),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Time
                  Text(
                    review['time'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primaryColor.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),

        // Rate Us Button
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 16),
          child: ElevatedButton(
            onPressed: () {
              // Backend will implement rating functionality
              print('Rate us button pressed');
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
              'Rate Us',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  // Helper methods
  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'clinic':
        return Icons.local_hospital;
      case 'store':
        return Icons.store;
      case 'shelter':
        return Icons.pets;
      default:
        return Icons.place;
    }
  }

  Color _getStatusColor(String status) {
    if (status.toLowerCase().contains('open')) {
      return Colors.green;
    } else if (status.toLowerCase().contains('close')) {
      return Colors.red;
    }
    return Colors.orange;
  }
}

import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class PlaceDetailPage extends StatefulWidget {
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
  State<PlaceDetailPage> createState() => _PlaceDetailPageState();
}

class _PlaceDetailPageState extends State<PlaceDetailPage> {
  int _selectedRating = 0;
  final TextEditingController _reviewController = TextEditingController();
  bool _isSubmittingReview = false;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _submitReview() {
    if (_selectedRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a rating'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSubmittingReview = true;
    });

    final reviewData = {
      'rating': _selectedRating,
      'comment': _reviewController.text,
      'placeId': widget.placeName,
    };

    print('Submitting review: $reviewData');

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isSubmittingReview = false;
        _selectedRating = 0;
        _reviewController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Review submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  void _showTimeSlotBookingOverlay(BuildContext context, String selectedTime) {
    // Create an OverlayEntry
    OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => _TimeSlotBookingOverlay(
        selectedTime: selectedTime,
        clinicName: widget.placeName,
        onClose: () {
          overlayEntry?.remove();
        },
        onSubmit: (time, reason) {
          print('Booking confirmed for $time with reason: $reason');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Appointment booked for $time!'),
              backgroundColor: Colors.green,
            ),
          );
        },
      ),
    );

    // Insert the overlay into the Overlay
    Overlay.of(context).insert(overlayEntry);
  }

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
            Navigator.pop(context);
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
                  _getIconForType(widget.placeType),
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
                      widget.placeName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.address,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryColor.withOpacity(0.7),
                      ),
                      maxLines: 2,
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
                            color: _getStatusColor(
                              widget.status,
                            ).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            widget.status,
                            style: TextStyle(
                              fontSize: 12,
                              color: _getStatusColor(widget.status),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          widget.hours,
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

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    print('Call ${widget.placeName}');
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
                    print('Message ${widget.placeName}');
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
                      onChanged: (String? newValue) {},
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
                      onChanged: (String? newValue) {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        const Text(
          'Slots available tomorrow:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 16),

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
                  _showTimeSlotBookingOverlay(context, availableSlots[index]);
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
              widget.rating.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Write Review Section
        _buildReviewInputSection(),
        const SizedBox(height: 30),

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
                  Text(
                    review['comment'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primaryColor.withOpacity(0.8),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
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
      ],
    );
  }

  Widget _buildReviewInputSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightPink,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.secondaryColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Write a Review',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 16),

          // Star Rating
          const Text(
            'How would you rate this place?',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),

          // Star Selection
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedRating = index + 1;
                  });
                },
                child: Icon(
                  index < _selectedRating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 40,
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Text(
            _selectedRating == 0
                ? 'Select rating'
                : '$_selectedRating out of 5',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.primaryColor.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 16),

          // Review Comment
          const Text(
            'Your review',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.secondaryColor.withOpacity(0.3),
              ),
            ),
            child: TextField(
              controller: _reviewController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Share your experience...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Submit Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isSubmittingReview ? null : _submitReview,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                disabledBackgroundColor: AppColors.secondaryColor.withOpacity(
                  0.5,
                ),
              ),
              child: _isSubmittingReview
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Submit Review',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
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

// Time Slot Booking Overlay - Added as a private class in the same file
class _TimeSlotBookingOverlay extends StatefulWidget {
  final String selectedTime;
  final String clinicName;
  final VoidCallback onClose;
  final Function(String, String) onSubmit;

  const _TimeSlotBookingOverlay({
    required this.selectedTime,
    required this.clinicName,
    required this.onClose,
    required this.onSubmit,
  });

  @override
  State<_TimeSlotBookingOverlay> createState() =>
      __TimeSlotBookingOverlayState();
}

class __TimeSlotBookingOverlayState extends State<_TimeSlotBookingOverlay> {
  final TextEditingController _reasonController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _submitBooking() {
    if (_reasonController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide a reason for your appointment'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final bookingData = {
      'time': widget.selectedTime,
      'clinic': widget.clinicName,
      'reason': _reasonController.text.trim(),
    };

    print('Submitting booking: $bookingData');

    Future.delayed(const Duration(seconds: 2), () {
      widget.onSubmit(widget.selectedTime, _reasonController.text.trim());
      widget.onClose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClose,
      behavior: HitTestBehavior.opaque,
      child: Material(
        color: Colors.transparent,
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Book Appointment',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          IconButton(
                            onPressed: widget.onClose,
                            icon: const Icon(Icons.close, size: 24),
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${widget.clinicName} • ${widget.selectedTime}',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryColor.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Reason Input
                      const Text(
                        'Reason for appointment',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Let the clinic know why you\'re booking this appointment',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryColor.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.secondaryColor.withOpacity(0.3),
                          ),
                        ),
                        child: TextField(
                          controller: _reasonController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            hintText:
                                'e.g., Regular check-up, vaccination, health concern...',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This will be sent to the clinic to help them prepare for your visit',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primaryColor.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: widget.onClose,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.primaryColor,
                                side: BorderSide(
                                  color: AppColors.secondaryColor.withOpacity(
                                    0.3,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _isSubmitting ? null : _submitBooking,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondaryColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                disabledBackgroundColor: AppColors
                                    .secondaryColor
                                    .withOpacity(0.5),
                              ),
                              child: _isSubmitting
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'Confirm Booking',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

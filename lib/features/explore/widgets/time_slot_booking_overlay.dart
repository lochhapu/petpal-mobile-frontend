import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class TimeSlotBookingOverlay extends StatefulWidget {
  final String selectedTime;
  final String clinicName;
  final VoidCallback onClose;
  final Function(String, String) onSubmit;

  const TimeSlotBookingOverlay({
    super.key,
    required this.selectedTime,
    required this.clinicName,
    required this.onClose,
    required this.onSubmit,
  });

  @override
  State<TimeSlotBookingOverlay> createState() => _TimeSlotBookingOverlayState();
}

class _TimeSlotBookingOverlayState extends State<TimeSlotBookingOverlay> {
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

    // Backend will implement actual submission
    final bookingData = {
      'time': widget.selectedTime,
      'clinic': widget.clinicName,
      'reason': _reasonController.text.trim(),
    };

    print('Submitting booking: $bookingData');

    // Simulate API call delay
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

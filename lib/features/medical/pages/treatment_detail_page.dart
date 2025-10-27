import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class TreatmentDetailPage extends StatelessWidget {
  final Map<String, dynamic> treatment;

  const TreatmentDetailPage({super.key, required this.treatment});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.all(20),
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

          // Header with close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 40),
              Text(
                'Treatment Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: AppColors.primaryColor),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Treatment Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.lightPink,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.secondaryColor.withOpacity(0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  treatment['medicine'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  treatment['description'],
                  style: TextStyle(fontSize: 14, color: AppColors.lightBlue),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildDateInfo('Started:', treatment['startDate']),
                    const SizedBox(width: 20),
                    _buildDateInfo('Ended:', treatment['endDate']),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Treatment Schedule
          const Text(
            'Treatment Schedule',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 16),

          // Schedule Table
          Expanded(child: _buildScheduleTable(treatment['schedule'])),
        ],
      ),
    );
  }

  Widget _buildScheduleTable(List<dynamic> schedule) {
    return Column(
      children: [
        // Table Header
        Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Day',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14, // Added explicit font size
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Morning',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12, // Reduced from default
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Afternoon',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12, // Reduced from default
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Evening',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12, // Reduced from default
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Table Rows
        Expanded(
          child: ListView.builder(
            itemCount: schedule.length,
            itemBuilder: (context, index) {
              final day = schedule[index];
              return Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        color: index % 2 == 0 ? Colors.white : Colors.grey[50],
                        child: Text(
                          day['day'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: _buildCheckbox(day['morning']),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: _buildCheckbox(day['afternoon']),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: _buildCheckbox(day['evening']),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCheckbox(bool isChecked) {
    return Center(
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          border: Border.all(
            color: isChecked ? AppColors.secondaryColor : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
          color: isChecked ? AppColors.secondaryColor : Colors.transparent,
        ),
        child: isChecked
            ? const Icon(Icons.check, size: 16, color: Colors.white)
            : null,
      ),
    );
  }

  Widget _buildDateInfo(String label, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: AppColors.lightBlue)),
        const SizedBox(height: 4),
        Text(
          date,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}

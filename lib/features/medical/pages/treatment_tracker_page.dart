import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../widgets/custom_app_bar.dart';

class TreatmentTrackerPage extends StatefulWidget {
  const TreatmentTrackerPage({super.key});

  @override
  State<TreatmentTrackerPage> createState() => _TreatmentTrackerPageState();
}

class _TreatmentTrackerPageState extends State<TreatmentTrackerPage> {
  // Mock data - your friend will replace with API calls
  final List<Map<String, dynamic>> treatmentPlans = [
    {
      'id': '1',
      'doctor': 'Dr. Mewes',
      'medicine': 'Worm medicine',
      'description':
          'Give him the given pill 3 times a day after meals. Morning, afternoon and evening.',
      'schedule': [
        {
          'day': 'Day 1',
          'morning': false,
          'afternoon': false,
          'evening': false,
        },
        {
          'day': 'Day 2',
          'morning': false,
          'afternoon': false,
          'evening': false,
        },
        {
          'day': 'Day 3',
          'morning': false,
          'afternoon': false,
          'evening': false,
        },
        {
          'day': 'Day 4',
          'morning': false,
          'afternoon': false,
          'evening': false,
        },
      ],
      'startDate': '2024-01-15',
      'endDate': '2024-01-18',
    },
    {
      'id': '2',
      'doctor': 'Dr. Mewes',
      'medicine': 'Mite shots',
      'description':
          'Bring him over once a week and give him the shot for three weeks.',
      'schedule': [
        {'week': 'Week 1', 'completed': false},
        {'week': 'Week 2', 'completed': false},
        {'week': 'Week 3', 'completed': false},
      ],
      'startDate': '2024-01-20',
      'endDate': '2024-02-10',
    },
  ];

  Map<String, dynamic>? selectedTreatment;

  // API: Your friend will implement this to update treatment progress
  void _updateTreatmentProgress(int dayIndex, String timeSlot) {
    if (selectedTreatment == null) return;

    setState(() {
      final schedule = selectedTreatment!['schedule'];
      if (schedule[dayIndex].containsKey(timeSlot)) {
        schedule[dayIndex][timeSlot] = !schedule[dayIndex][timeSlot];
      }
    });

    // TODO: Call API to update treatment progress
    print(
      'API Call: Update treatment progress for ${selectedTreatment!['medicine']}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Treatment Tracker',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Track your pet\'s treatment progress',
                    style: TextStyle(fontSize: 16, color: AppColors.lightBlue),
                  ),
                ],
              ),
            ),

            // Treatment Plans List - FIXED OVERFLOW
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Treatment Plans',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Treatment Plans List
                    SizedBox(
                      height: 120, // Fixed height to prevent overflow
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: treatmentPlans.length,
                        itemBuilder: (context, index) {
                          final plan = treatmentPlans[index];
                          return _buildTreatmentPlanCard(plan, index);
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Selected Treatment Details
                    Expanded(child: _buildTreatmentDetails()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTreatmentPlanCard(Map<String, dynamic> plan, int index) {
    final isSelected = selectedTreatment?['id'] == plan['id'];

    return Container(
      width: 280, // Fixed width for horizontal scrolling
      margin: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTreatment = plan;
          });
          // TODO: Your friend can add API call to fetch detailed treatment data
          print(
            'API Call: Fetch detailed treatment data for ${plan['medicine']}',
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.lightPink : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? AppColors.secondaryColor
                  : AppColors.lightBlue.withOpacity(0.3),
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      plan['doctor'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                plan['medicine'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Expanded(
                child: Text(
                  plan['description'],
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.lightBlue,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTreatmentDetails() {
    if (selectedTreatment == null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.lightBlue.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.medical_services_outlined,
              size: 48,
              color: AppColors.lightBlue.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'Select a treatment plan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose a treatment plan from above to view details and track progress',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: AppColors.lightBlue),
            ),
          ],
        ),
      );
    }

    final treatment = selectedTreatment!;
    final isDailySchedule =
        treatment['schedule'].isNotEmpty &&
        treatment['schedule'][0].containsKey('morning');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightBlue.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Treatment Header
          Text(
            treatment['medicine'],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            treatment['description'],
            style: TextStyle(
              fontSize: 14,
              color: AppColors.lightBlue,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),

          // Treatment Schedule
          const Text(
            'Treatment Schedule',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 12),

          // Schedule Table
          if (isDailySchedule)
            _buildDailyScheduleTable(treatment['schedule'])
          else
            _buildWeeklySchedule(treatment['schedule']),
        ],
      ),
    );
  }

  Widget _buildDailyScheduleTable(List<dynamic> schedule) {
    return Expanded(
      child: Column(
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
            child: const Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Day',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Morning',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Afternoon',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Evening',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          color: index % 2 == 0
                              ? Colors.white
                              : Colors.grey[50],
                          child: Text(
                            day['day'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: GestureDetector(
                            onTap: () =>
                                _updateTreatmentProgress(index, 'morning'),
                            child: _buildCheckbox(day['morning']),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: GestureDetector(
                            onTap: () =>
                                _updateTreatmentProgress(index, 'afternoon'),
                            child: _buildCheckbox(day['afternoon']),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: GestureDetector(
                            onTap: () =>
                                _updateTreatmentProgress(index, 'evening'),
                            child: _buildCheckbox(day['evening']),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklySchedule(List<dynamic> schedule) {
    return Expanded(
      child: ListView.builder(
        itemCount: schedule.length,
        itemBuilder: (context, index) {
          final week = schedule[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      week['completed'] = !week['completed'];
                    });
                  },
                  child: _buildCheckbox(week['completed']),
                ),
                const SizedBox(width: 16),
                Text(
                  week['week'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCheckbox(bool isChecked) {
    return Container(
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
    );
  }
}

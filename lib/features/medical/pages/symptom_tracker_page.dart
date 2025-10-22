import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class SymptomTrackerPage extends StatefulWidget {
  const SymptomTrackerPage({super.key});

  @override
  State<SymptomTrackerPage> createState() => _SymptomTrackerPageState();
}

class _SymptomTrackerPageState extends State<SymptomTrackerPage> {
  // Mock data - your friend will replace with API calls
  List<Map<String, dynamic>> symptoms = [
    {
      'id': '1',
      'symptom': 'Vomited his breakfast',
      'dateTime': '2025-09-20 07:45 AM',
      'isEditing': false,
    },
    {
      'id': '2',
      'symptom': 'Refused to eat food',
      'dateTime': '2025-09-21 6:20 AM',
      'isEditing': false,
    },
    {
      'id': '3',
      'symptom': 'Very inactive and sleepy',
      'dateTime': '2025-09-22 11:30 AM',
      'isEditing': false,
    },
    {
      'id': '4',
      'symptom': 'Eat restress and mouth dry',
      'dateTime': '2025-09-23 08:10 PM',
      'isEditing': false,
    },
  ];

  bool isEditMode = false;
  final TextEditingController _symptomController = TextEditingController();

  @override
  void dispose() {
    _symptomController.dispose();
    super.dispose();
  }

  // API: Your friend will implement this to add symptom
  void _addSymptom() {
    if (_symptomController.text.trim().isEmpty) return;

    setState(() {
      symptoms.insert(0, {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'symptom': _symptomController.text.trim(),
        'dateTime': _formatDateTime(DateTime.now()),
        'isEditing': false,
      });
      _symptomController.clear();
    });

    // TODO: Call API to save symptom - your friend will implement
    print('API Call: Add symptom - ${_symptomController.text}');
  }

  // API: Your friend will implement this to update symptom
  void _updateSymptom(int index, String newSymptom) {
    if (newSymptom.trim().isEmpty) return;

    setState(() {
      symptoms[index]['symptom'] = newSymptom.trim();
      symptoms[index]['isEditing'] = false;
    });

    // TODO: Call API to update symptom - your friend will implement
    print('API Call: Update symptom - $newSymptom');
  }

  // API: Your friend will implement this to delete symptom
  void _deleteSymptom(int index) {
    final symptomToDelete = symptoms[index];

    setState(() {
      symptoms.removeAt(index);
    });

    // TODO: Call API to delete symptom - your friend will implement
    print('API Call: Delete symptom - ${symptomToDelete['symptom']}');
  }

  String _formatDateTime(DateTime dateTime) {
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final period = dateTime.hour < 12 ? 'AM' : 'PM';
    final minute = dateTime.minute.toString().padLeft(2, '0');

    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} $hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          children: [
            // Profile section (left side) - Same as CustomAppBar but without onTap
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.pets,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Toby',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    Text(
                      'Goes bananas for bananas!',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Symptom Tracker',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter your pets symptoms here.',
                style: TextStyle(fontSize: 16, color: AppColors.lightBlue),
              ),
              const SizedBox(height: 24),

              // Add Symptom Input
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.lightBlue.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _symptomController,
                        decoration: const InputDecoration(
                          hintText: 'Enter symptom...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        onSubmitted: (_) => _addSymptom(),
                      ),
                    ),
                    IconButton(
                      onPressed: _addSymptom,
                      icon: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Edit Mode Toggle - FIXED OVERFLOW
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Symptoms',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 120, // Prevent overflow
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isEditMode = !isEditMode;
                          // Exit all edit modes when toggling edit mode
                          for (var symptom in symptoms) {
                            symptom['isEditing'] = false;
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isEditMode
                            ? AppColors.primaryColor
                            : AppColors.secondaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        minimumSize:
                            Size.zero, // Remove minimum size constraints
                      ),
                      child: Text(
                        isEditMode
                            ? 'Done'
                            : 'Edit', // Shorter text to prevent overflow
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Symptoms Table Header
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
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'Symptoms',
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
                          'Date & Time',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 60), // Space for action buttons
                  ],
                ),
              ),

              // Symptoms List
              Expanded(
                child: ListView.builder(
                  itemCount: symptoms.length,
                  itemBuilder: (context, index) {
                    final symptom = symptoms[index];
                    return _buildSymptomRow(symptom, index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSymptomRow(Map<String, dynamic> symptom, int index) {
    final TextEditingController editController = TextEditingController(
      text: symptom['symptom'],
    );

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          // Symptom Column (Editable)
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(12),
              color: index % 2 == 0 ? Colors.white : Colors.grey[50],
              child: symptom['isEditing']
                  ? TextField(
                      controller: editController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(8),
                        isDense: true,
                      ),
                      onSubmitted: (value) => _updateSymptom(index, value),
                    )
                  : Text(
                      symptom['symptom'],
                      style: const TextStyle(color: AppColors.primaryColor),
                    ),
            ),
          ),

          // Date & Time Column
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              color: index % 2 == 0 ? Colors.white : Colors.grey[50],
              child: Text(
                symptom['dateTime'],
                style: TextStyle(color: AppColors.lightBlue, fontSize: 12),
              ),
            ),
          ),

          // Action Buttons Column - FIXED OVERFLOW
          Container(
            width: 60, // Slightly wider to prevent overflow
            color: index % 2 == 0 ? Colors.white : Colors.grey[50],
            child: isEditMode
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Edit/Save Button
                      IconButton(
                        onPressed: () {
                          if (symptom['isEditing']) {
                            _updateSymptom(index, editController.text);
                          } else {
                            setState(() {
                              symptom['isEditing'] = true;
                            });
                          }
                        },
                        icon: Icon(
                          symptom['isEditing'] ? Icons.check : Icons.edit,
                          color: symptom['isEditing']
                              ? Colors.green
                              : AppColors.primaryColor,
                          size: 18,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 30,
                          minHeight: 30,
                        ),
                      ),

                      // Delete Button
                      IconButton(
                        onPressed: () => _deleteSymptom(index),
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 18,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 30,
                          minHeight: 30,
                        ),
                      ),
                    ],
                  )
                : const SizedBox(width: 60),
          ),
        ],
      ),
    );
  }
}
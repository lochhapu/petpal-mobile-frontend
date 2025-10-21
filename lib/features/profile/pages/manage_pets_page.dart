import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../core/models/user_profile_model.dart';
import 'edit_pet_page.dart';
import 'add_pet_page.dart';

class ManagePetsPage extends StatelessWidget {
  const ManagePetsPage({super.key});

  // Mock data with complete pet information
  List<Pet> get _userPets {
    return [
      Pet(
        name: 'Toby',
        description: 'Goes bananas for bananas!',
        species: 'Dog',
        breed: 'Golden Retriever',
        birth: '15th Mar 2021',
        gender: 'Male',
        adopted: 'Local Shelter, Colombo',
        habits: 'Loves playing fetch, hates baths',
      ),
      Pet(
        name: 'Bazuka',
        description: 'Ugliest cutie of all time',
        species: 'Cat',
        breed: 'Persian',
        birth: '2nd Jan 2022',
        gender: 'Male',
        adopted: 'Boston Adoption, Batharamula',
        habits: 'Loves fish, hates to take medicine',
      ),
      Pet(
        name: 'Spy',
        description: 'Freaking psychopath!',
        species: 'Cat',
        breed: 'Burmese',
        birth: '10th Jun 2020',
        gender: 'Female',
        adopted: 'Friend gave, Kandy',
        habits: 'Very active at night, loves chasing lasers',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Your pets',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pets List
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _userPets.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final pet = _userPets[index];
                  return _buildPetCard(pet, context);
                },
              ),
              const SizedBox(height: 30),

              // Add New Pet Button
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.lightPink,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.secondaryColor.withOpacity(0.2),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    // Navigate to AddPetPage and wait for result
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddPetPage(),
                      ),
                    ).then((newPet) {
                      if (newPet != null) {
                        // Handle the new pet here
                        print('New pet added: ${(newPet as Pet).name}');
                        // You would typically update your state here
                      }
                    });
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: AppColors.secondaryColor,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Add new pet',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
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

  Widget _buildPetCard(Pet pet, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.secondaryColor.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Pet Icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.lightPink,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.secondaryColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.pets,
                size: 24,
                color: AppColors.secondaryColor,
              ),
            ),
            const SizedBox(width: 16),

            // Pet Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pet.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pet.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primaryColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),

            // Edit Button
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.lightPink,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.secondaryColor.withOpacity(0.2),
                ),
              ),
              child: IconButton(
                onPressed: () {
                  print('Editing ${pet.name}'); // Debug print
                  // Navigate to EditPetPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPetPage(pet: pet),
                    ),
                  ).then((_) {
                    print('Returned from EditPetPage'); // Debug print
                  });
                },
                icon: Icon(
                  Icons.edit_outlined,
                  color: AppColors.secondaryColor,
                  size: 20,
                ),
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

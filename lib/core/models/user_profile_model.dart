// lib/core/models/user_profile_model.dart
class UserProfile {
  final String name;
  final String email;
  final String phone;
  final List<Pet> pets;
  final String? imageUrl;

  const UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.pets,
    this.imageUrl,
  });
}

class Pet {
  final String name;
  final String description;
  final String? species;
  final String? breed;
  final String? birth;
  final String? gender;
  final String? adopted;
  final String? habits;
  final String? imageUrl;

  const Pet({
    required this.name,
    required this.description,
    this.species,
    this.breed,
    this.birth,
    this.gender,
    this.adopted,
    this.habits,
    this.imageUrl,
  });

  // Create a copyWith method for easier updates
  Pet copyWith({
    String? name,
    String? description,
    String? species,
    String? breed,
    String? birth,
    String? gender,
    String? adopted,
    String? habits,
    String? imageUrl,
  }) {
    return Pet(
      name: name ?? this.name,
      description: description ?? this.description,
      species: species ?? this.species,
      breed: breed ?? this.breed,
      birth: birth ?? this.birth,
      gender: gender ?? this.gender,
      adopted: adopted ?? this.adopted,
      habits: habits ?? this.habits,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

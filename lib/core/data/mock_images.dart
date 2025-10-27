class MockImages {
  // Veterinary clinic images
  static const String vet1 = 'assets/images/vets/vet1.jpg';
  static const String vet2 = 'assets/images/vets/vet2.jpg';
  static const String vet3 = 'assets/images/vets/vet3.jpg';

  // Doctor profile images
  static const String doctor1 = 'assets/images/doctors/doctor1.jpg';
  static const String doctor2 = 'assets/images/doctors/doctor2.jpg';
  static const String doctor3 = 'assets/images/doctors/doctor3.jpg';

  // Pet images
  static const String petDog1 = 'assets/images/pets/dog1.jpg';
  static const String petDog2 = 'assets/images/pets/dog2.jpg';
  static const String petCat1 = 'assets/images/pets/cat1.jpg';

  // Lists for random selection
  static final List<String> vetImages = [vet1, vet2, vet3];
  static final List<String> doctorImages = [doctor1, doctor2, doctor3];
  static final List<String> petImages = [petDog1, petDog2, petCat1];

  // Get random images
  static String get randomVet =>
      vetImages[DateTime.now().millisecond % vetImages.length];
  static String get randomDoctor =>
      doctorImages[DateTime.now().millisecond % doctorImages.length];
  static String get randomPet =>
      petImages[DateTime.now().millisecond % petImages.length];
}

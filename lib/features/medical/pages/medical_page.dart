import 'package:flutter/material.dart';
import '../../../../widgets/custom_app_bar.dart';

class MedicalPage extends StatelessWidget {
  const MedicalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(), // No context needed now
      body: Center(
        child: Text(
          'Medical Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../widgets/custom_app_bar.dart';
import '../widgets/upcoming_tabs.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(), // No context needed now
      body: UpcomingTabs(),
    );
  }
}

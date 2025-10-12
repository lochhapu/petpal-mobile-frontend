import 'package:flutter/material.dart';
import 'core/themes/app_theme.dart';
import 'routing/route_names.dart';
import 'widgets/custom_bottom_nav_bar.dart';
import 'features/home/pages/home_page.dart';
import 'features/medical/pages/medical_page.dart';
import 'features/community/pages/community_page.dart';
import 'features/explore/pages/explore_page.dart';
import 'features/profile/pages/profile_page.dart';
import 'features/notifications/pages/notifications_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    MedicalPage(),
    CommunityPage(),
    ExplorePage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetPal',
      theme: AppTheme.lightTheme,
      // Use home for the main app with bottom navigation
      home: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
        ),
      ),
      // Add routes for other pages like notifications
      routes: {
        RouteNames.notifications: (context) => const NotificationsPage(),
      },
    );
  }
}

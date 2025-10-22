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
import 'features/authentication/pages/welcome_page.dart';

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
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // Start with WelcomePage as home
      home: const WelcomePage(),
      // Add routes for authentication and main app
      routes: {
        RouteNames.notifications: (context) => const NotificationsPage(),
        // You can add more named routes here if needed
      },
      // Optional: You can also use onGenerateRoute for more complex routing
    );
  }
}

// Helper method to navigate to main app (for use in sign in/sign up pages)
void navigateToMainApp(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const MainApp()),
    (Route<dynamic> route) => false,
  );
}

// Separate widget for the main app with bottom navigation
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
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
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

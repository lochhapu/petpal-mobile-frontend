import 'package:flutter/material.dart';
import '../features/home/pages/home_page.dart';
import '../features/medical/pages/medical_page.dart';
import '../features/community/pages/community_page.dart';
import '../features/explore/pages/explore_page.dart';
import '../features/profile/pages/profile_page.dart';
import '../features/notifications/pages/notifications_page.dart';
import 'route_names.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case RouteNames.medical:
        return MaterialPageRoute(builder: (_) => const MedicalPage());
      case RouteNames.community:
        return MaterialPageRoute(builder: (_) => const CommunityPage());
      case RouteNames.explore:
        return MaterialPageRoute(builder: (_) => const ExplorePage());
      case RouteNames.profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case RouteNames.notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

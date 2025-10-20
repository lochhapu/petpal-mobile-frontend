import 'package:flutter/material.dart';
import '../../../widgets/custom_app_bar.dart';
import '../widgets/pinned_places_section.dart';
import '../widgets/search_section.dart';
import '../widgets/recent_searches_section.dart';
import '../widgets/top_picks_section.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pinned Places Section
            const PinnedPlacesSection(),

            // Search Section
            const SearchSection(),

            // Recent Searches Section
            const RecentSearchesSection(),

            // Top Picks Section
            const TopPicksSection(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../models/destination.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/destination_card.dart';
import '../../widgets/primary_button.dart';
import '../destination/destination_detail_screen.dart';

class SavedPlacesScreen extends StatefulWidget {
  const SavedPlacesScreen({super.key});

  @override
  State<SavedPlacesScreen> createState() => _SavedPlacesScreenState();
}

class _SavedPlacesScreenState extends State<SavedPlacesScreen> {
  late List<Destination> _savedDestinations;

  @override
  void initState() {
    super.initState();
    _savedDestinations = Destination.sampleDestinations.where((d) => d.isSaved).toList();
  }

  void _removeDestination(String id) {
    setState(() {
      _savedDestinations.removeWhere((d) => d.id == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Removed from your saved places'),
        backgroundColor: AppColors.charcoal,
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved places'),
        actions: [
          if (_savedDestinations.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Center(
                child: Text(
                  '${_savedDestinations.length} places',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.forest,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: _savedDestinations.isEmpty
          // Empty State (Figma: Saved - empty collection)
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: const BoxDecoration(
                        color: AppColors.sage,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.bookmark_outline_rounded,
                        color: AppColors.forest,
                        size: 48,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Your collection is empty',
                      textAlign: TextAlign.center,
                      style: AppTypography.cardHeading.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Explore national parks, waterfalls and mountains, then tap the bookmark icon to save them for your trip.',
                      textAlign: TextAlign.center,
                      style: AppTypography.body.copyWith(color: AppColors.muted),
                    ),
                    const SizedBox(height: 32),
                    PrimaryButton(
                      label: 'Explore Uganda',
                      icon: Icons.explore_rounded,
                      onPressed: () {
                        // Switch to Explore Tab via DefaultTabController or ancestor navigation
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                    ),
                  ],
                ),
              ),
            )
          // Saved Destinations List
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              itemCount: _savedDestinations.length,
              itemBuilder: (context, index) {
                final destination = _savedDestinations[index];
                return DestinationCard(
                  destination: destination,
                  onBookmarkToggle: () => _removeDestination(destination.id),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DestinationDetailScreen(destination: destination),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

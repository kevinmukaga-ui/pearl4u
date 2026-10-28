import 'package:flutter/material.dart';
import '../../models/category.dart';
import '../../models/destination.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/destination_card.dart';
import '../../widgets/status_pill.dart';
import 'filter_sheet.dart';
import '../destination/destination_detail_screen.dart';
import '../profile/profile_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _selectedRegion = 'All Regions';
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterSheet(
        selectedRegion: _selectedRegion,
        selectedCategory: _selectedCategory == 'All' ? 'All Categories' : _selectedCategory,
        onApply: (region, category) {
          setState(() {
            _selectedRegion = region;
            _selectedCategory = category == 'All Categories' ? 'All' : category;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final destinations = Destination.sampleDestinations.where((d) {
      final matchesSearch = _searchQuery.isEmpty ||
          d.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          d.region.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          d.category.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesCategory = _selectedCategory == 'All' || d.category == _selectedCategory;
      final matchesRegion = _selectedRegion == 'All Regions' || d.region == _selectedRegion;

      return matchesSearch && matchesCategory && matchesRegion;
    }).toList();

    final featuredDestination = Destination.sampleDestinations.firstWhere(
      (d) => d.isFeatured,
      orElse: () => Destination.sampleDestinations.first,
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: AppColors.sage,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.eco_rounded,
                color: AppColors.forest,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Pearl4U',
              style: AppTypography.cardHeading.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person_outline_rounded, color: AppColors.jungle, size: 20),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Headline
            Text(
              'Discover Uganda.',
              style: AppTypography.pageTitle,
            ),
            const SizedBox(height: 16),

            // Search Bar & Filter Button
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) => setState(() => _searchQuery = val),
                      decoration: InputDecoration(
                        hintText: 'Where do you want to explore?',
                        hintStyle: AppTypography.body.copyWith(
                          color: AppColors.muted,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(Icons.search_rounded, color: AppColors.forest),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.forest,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.tune_rounded, color: AppColors.white),
                    onPressed: _openFilterSheet,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Categories Horizontal Scroll
            SizedBox(
              height: 42,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryChip('All', Icons.explore_outlined),
                  ...DestinationCategory.categories.map((c) {
                    return _buildCategoryChip(c.name, c.icon);
                  }),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Featured Hero Card (Murchison Falls)
            if (_searchQuery.isEmpty && _selectedCategory == 'All' && _selectedRegion == 'All Regions') ...[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DestinationDetailScreen(
                        destination: featuredDestination,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                        child: Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Image.network(
                                featuredDestination.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (ctx, err, stack) => Container(
                                  color: AppColors.forest,
                                  child: const Center(
                                    child: Icon(Icons.waterfall_chart, size: 48, color: AppColors.white),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 12,
                              left: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.ochre,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'FEATURED',
                                  style: AppTypography.eyebrow.copyWith(
                                    color: AppColors.jungle,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.white.withOpacity(0.9),
                                  shape: BoxShape.circle,
                                ),
                                child: const IconButton(
                                  icon: Icon(Icons.bookmark_rounded, color: AppColors.ochre, size: 20),
                                  onPressed: null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${featuredDestination.region}  •  ${featuredDestination.category}',
                              style: AppTypography.caption.copyWith(color: AppColors.muted),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              featuredDestination.name,
                              style: AppTypography.sectionHeading.copyWith(fontSize: 20),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              featuredDestination.description,
                              style: AppTypography.body.copyWith(
                                color: AppColors.charcoal.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
            ],

            // Popular places Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Popular places', style: AppTypography.sectionHeading),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'View all',
                    style: AppTypography.actionLabel.copyWith(color: AppColors.forest),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            if (destinations.isEmpty) ...[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Icon(Icons.search_off_rounded, size: 48, color: AppColors.muted),
                    const SizedBox(height: 12),
                    Text('No destinations found', style: AppTypography.cardHeading),
                    const SizedBox(height: 4),
                    Text(
                      'Try resetting your search or filter options.',
                      style: AppTypography.caption,
                    ),
                  ],
                ),
              ),
            ] else ...[
              ...destinations.map((d) {
                return DestinationCard(
                  destination: d,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DestinationDetailScreen(destination: d),
                      ),
                    );
                  },
                );
              }),
            ],

            const SizedBox(height: 20),

            // Wildlife discovery banner
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.jungle, AppColors.forest],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'THE WILD SIDE',
                          style: AppTypography.eyebrow.copyWith(color: AppColors.ochre),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Discover Wildlife',
                          style: AppTypography.cardHeading.copyWith(color: AppColors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Meet the species that call Uganda home.',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.ivory.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.pets_rounded, color: AppColors.white, size: 28),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, IconData icon) {
    final isSelected = _selectedCategory == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutBack,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.forest : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.forest : AppColors.border,
            width: isSelected ? 1.5 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.forest.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? AppColors.white : AppColors.forest,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? AppColors.white : AppColors.charcoal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

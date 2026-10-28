import 'package:flutter/material.dart';
import '../../models/destination.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import 'filter_sheet.dart';
import '../destination/destination_detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All Places';
  String _selectedRegion = 'All Regions';
  String _searchQuery = '';
  final Set<String> _favouriteIds = {'murchison', 'bwindi'};

  final List<String> _interestCategories = [
    'All Places',
    'National Parks',
    'Wildlife',
    'Waterfalls',
    'Lakes',
    'Mountains',
    'Cultural Sites',
  ];

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
        selectedCategory: _selectedCategory == 'All Places' ? 'All Categories' : _selectedCategory,
        onApply: (region, category) {
          setState(() {
            _selectedRegion = region;
            _selectedCategory = category == 'All Categories' ? 'All Places' : category;
          });
        },
      ),
    );
  }

  String _getCategoryEyebrow(Destination d) {
    if (d.id == 'bwindi') return 'PRIMATES & FOREST';
    if (d.id == 'queen_elizabeth') return 'CLASSIC SAFARI';
    if (d.id == 'bunyonyi' || d.category == 'Lakes') return 'LAKESIDE ESCAPE';
    if (d.id == 'sipi_falls' || d.category == 'Waterfalls') return 'WATERFALL TRAILS';
    if (d.category == 'Mountains') return 'ALPINE ADVENTURE';
    if (d.category == 'Cultural Sites') return 'HERITAGE & ROYALTY';
    return d.category.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final allDestinations = Destination.sampleDestinations;

    final filteredDestinations = allDestinations.where((d) {
      final matchesSearch = _searchQuery.isEmpty ||
          d.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          d.region.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          d.category.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesCategory = _selectedCategory == 'All Places' ||
          d.category == _selectedCategory ||
          (_selectedCategory == 'Wildlife' && (d.category == 'National Parks' || d.category == 'Wildlife'));

      final matchesRegion = _selectedRegion == 'All Regions' || d.region == _selectedRegion;

      return matchesSearch && matchesCategory && matchesRegion;
    }).toList();

    final featuredDestination = allDestinations.firstWhere(
      (d) => d.id == 'murchison',
      orElse: () => allDestinations.first,
    );

    // Popular attractions list (excluding featured in default view)
    final popularDestinations = filteredDestinations.where((d) => d.id != featuredDestination.id).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F5), // Ivory cream background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Header Bar (Figma Exact)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                      color: Color(0xFF143E2C),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.eco_rounded,
                      color: AppColors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pearl4U',
                        style: AppTypography.cardHeading.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          letterSpacing: -0.4,
                          color: const Color(0xFF143E2C),
                        ),
                      ),
                      Text(
                        'Discover Uganda. Your Way.',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.charcoal.withOpacity(0.65),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_on_outlined, size: 14, color: AppColors.forest),
                        const SizedBox(width: 4),
                        Text(
                          'Uganda',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.jungle.withOpacity(0.85),
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Icon(Icons.keyboard_arrow_down_rounded, size: 14, color: AppColors.forest),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 2. Eyebrow & Title Section (Figma Exact)
              Row(
                children: const [
                  Icon(Icons.star_rounded, color: AppColors.ochre, size: 14),
                  SizedBox(width: 4),
                  Text(
                    'YOUR NEXT ADVENTURE',
                    style: TextStyle(
                      color: AppColors.ochre,
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'Explore the Pearl\nof Africa',
                style: TextStyle(
                  fontSize: 28,
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'serif',
                  color: Color(0xFF143E2C),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Welcome! Find a little wonder, wherever you go.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.charcoal.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 18),

              // 3. Search Bar + Filter Button (Figma Exact)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (val) => setState(() => _searchQuery = val),
                        decoration: const InputDecoration(
                          hintText: 'Search places, parks, waterfalls...',
                          hintStyle: TextStyle(fontSize: 13, color: AppColors.muted),
                          prefixIcon: Icon(Icons.search_rounded, color: AppColors.muted, size: 20),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: _openFilterSheet,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.tune_rounded, color: Color(0xFF143E2C), size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // 4. "Browse by interest" header & chips (Figma Exact)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Browse by interest',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF143E2C),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Swipe for more',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.charcoal.withOpacity(0.55),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Icon(Icons.arrow_forward_rounded, size: 12, color: AppColors.charcoal.withOpacity(0.55)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Category Filter Chips
              SizedBox(
                height: 36,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _interestCategories.length,
                  itemBuilder: (context, index) {
                    final cat = _interestCategories[index];
                    final isSelected = _selectedCategory == cat;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategory = cat),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF143E2C) : AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? const Color(0xFF143E2C) : AppColors.border,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isSelected) ...[
                              const Icon(Icons.check, size: 13, color: AppColors.white),
                              const SizedBox(width: 4),
                            ],
                            Text(
                              cat,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                color: isSelected ? AppColors.white : AppColors.charcoal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // 5. "A place to begin" Featured Card (Figma Exact)
              if (_searchQuery.isEmpty && _selectedCategory == 'All Places' && _selectedRegion == 'All Regions') ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'A place to begin',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'serif',
                        color: Color(0xFF143E2C),
                      ),
                    ),
                    Text(
                      'FEATURED',
                      style: TextStyle(
                        fontSize: 11,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w700,
                        color: AppColors.ochre,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Image Stack
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(19)),
                        child: Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 16 / 9.5,
                              child: Hero(
                                tag: 'dest-${featuredDestination.id}',
                                child: Image.network(
                                  featuredDestination.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    color: AppColors.forest,
                                    child: const Icon(Icons.waterfall_chart, size: 48, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),

                            // Top Left: "THE PEARL'S NILE GEM" Badge
                            Positioned(
                              top: 12,
                              left: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF143E2C).withOpacity(0.92),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(Icons.auto_awesome, color: AppColors.ochre, size: 12),
                                    SizedBox(width: 4),
                                    Text(
                                      'THE PEARL\'S NILE GEM',
                                      style: TextStyle(
                                        color: AppColors.ochre,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Top Right: Favourite Heart Button
                            Positioned(
                              top: 12,
                              right: 12,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (_favouriteIds.contains(featuredDestination.id)) {
                                      _favouriteIds.remove(featuredDestination.id);
                                    } else {
                                      _favouriteIds.add(featuredDestination.id);
                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    color: AppColors.white.withOpacity(0.92),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    _favouriteIds.contains(featuredDestination.id)
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                    color: _favouriteIds.contains(featuredDestination.id)
                                        ? const Color(0xFFE53935)
                                        : const Color(0xFF143E2C),
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),

                            // Bottom Left: Tag pills
                            Positioned(
                              bottom: 12,
                              left: 12,
                              child: Row(
                                children: [
                                  _buildSmallImageTag('Wildlife'),
                                  const SizedBox(width: 6),
                                  _buildSmallImageTag('Waterfalls'),
                                  const SizedBox(width: 6),
                                  _buildSmallImageTag('Adventure'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Card Content
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              featuredDestination.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF143E2C),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined, size: 13, color: AppColors.forest),
                                const SizedBox(width: 3),
                                Text(
                                  featuredDestination.region,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.charcoal.withOpacity(0.65),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              featuredDestination.description,
                              style: TextStyle(
                                fontSize: 13,
                                height: 1.4,
                                color: AppColors.charcoal.withOpacity(0.75),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Full-width Explore Destination Button
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
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF143E2C),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Explore Destination',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    Icon(Icons.north_east_rounded, color: AppColors.white, size: 16),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
              ],

              // 6. "Popular attractions" Section (Figma Exact Compact Cards)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular attractions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'serif',
                      color: Color(0xFF143E2C),
                    ),
                  ),
                  Text(
                    '${popularDestinations.length.toString().padLeft(2, '0')} PLACES',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.charcoal.withOpacity(0.55),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Extraordinary places. Unforgettable stories.',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.charcoal.withOpacity(0.65),
                ),
              ),
              const SizedBox(height: 14),

              // Compact Horizontal Card List (Figma Exact)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: popularDestinations.length,
                itemBuilder: (context, index) {
                  final dest = popularDestinations[index];
                  final isFav = _favouriteIds.contains(dest.id);
                  final eyebrow = _getCategoryEyebrow(dest);

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DestinationDetailScreen(destination: dest),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Left: Square rounded photo
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: SizedBox(
                              width: 84,
                              height: 84,
                              child: Hero(
                                tag: 'dest-${dest.id}',
                                child: Image.network(
                                  dest.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    color: AppColors.sage,
                                    child: const Icon(Icons.landscape, color: AppColors.forest),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Center Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  eyebrow,
                                  style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF143E2C),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  dest.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF143E2C),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on_outlined, size: 12, color: AppColors.muted),
                                    const SizedBox(width: 2),
                                    Expanded(
                                      child: Text(
                                        dest.region,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: AppColors.charcoal.withOpacity(0.65),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: const [
                                    Text(
                                      'Discover',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF143E2C),
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                    Icon(Icons.arrow_forward_rounded, size: 13, color: Color(0xFF143E2C)),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Right: Favourite Heart Button
                          IconButton(
                            icon: Icon(
                              isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                              color: isFav ? const Color(0xFFE53935) : AppColors.muted,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                if (isFav) {
                                  _favouriteIds.remove(dest.id);
                                } else {
                                  _favouriteIds.add(dest.id);
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // 7. Footer Quote (Figma Exact)
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.eco_outlined, size: 14, color: AppColors.forest),
                    const SizedBox(width: 6),
                    Text(
                      'Tread lightly. Take home a little wonder.',
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: AppColors.charcoal.withOpacity(0.65),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSmallImageTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.55),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

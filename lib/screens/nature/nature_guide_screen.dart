import 'package:flutter/material.dart';
import '../../models/species.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import 'species_detail_screen.dart';

class NatureGuideScreen extends StatefulWidget {
  const NatureGuideScreen({super.key});

  @override
  State<NatureGuideScreen> createState() => _NatureGuideScreenState();
}

class _NatureGuideScreenState extends State<NatureGuideScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final Set<String> _bookmarkedSpecies = {'gorilla', 'crane'};

  final List<String> _categories = [
    'All',
    'Mammals',
    'Birds',
    'Reptiles',
    'Plants',
    'Trees',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final speciesList = Species.sampleSpecies.where((s) {
      final matchesCategory = _selectedCategory == 'All' || s.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          s.commonName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          s.habitat.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          s.category.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

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
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                      color: AppColors.forest,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.eco_rounded,
                      color: AppColors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Pearl4U',
                    style: AppTypography.cardHeading.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      letterSpacing: -0.4,
                      color: AppColors.jungle,
                    ),
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
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 2. Title Section (Figma Exact)
              Text(
                'Discover Uganda\'s\nNature',
                style: const TextStyle(
                  fontSize: 28,
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'serif',
                  color: Color(0xFF143E2C),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Meet the incredible wildlife and plants of the Pearl of Africa.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: AppColors.charcoal.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 18),

              // 3. Search Bar (Figma Exact Pill)
              Container(
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
                    hintText: 'Search animals, birds, plants...',
                    hintStyle: TextStyle(fontSize: 14, color: AppColors.muted),
                    prefixIcon: Icon(Icons.search_rounded, color: AppColors.muted, size: 20),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 4. Category Filter Chips (Figma Exact)
              SizedBox(
                height: 36,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final cat = _categories[index];
                    final isSelected = _selectedCategory == cat;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategory = cat),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF143E2C) : AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? const Color(0xFF143E2C) : AppColors.border,
                          ),
                        ),
                        child: Text(
                          cat,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected ? AppColors.white : AppColors.charcoal,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // 5. "Did You Know?" Banner Card (Figma Exact)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF143E2C), // Dark Forest
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.jungle.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.auto_awesome, color: AppColors.ochre, size: 16),
                              SizedBox(width: 6),
                              Text(
                                'Did You Know?',
                                style: TextStyle(
                                  color: AppColors.ochre,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'The grey crowned crane is Uganda\'s national bird—and appears on its flag.',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 13,
                              height: 1.35,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: SizedBox(
                        width: 72,
                        height: 72,
                        child: Image.network(
                          'https://images.unsplash.com/photo-1549608276-5786777e6587?auto=format&fit=crop&w=400&q=80',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: AppColors.forest,
                            child: const Icon(Icons.pets, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 6. Section Header (Wild wonders + count)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Text(
                    'Wild wonders',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'serif',
                      color: Color(0xFF143E2C),
                    ),
                  ),
                  Text(
                    '${speciesList.length} species to discover',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.charcoal.withOpacity(0.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // 7. 2-Column Grid of Wildlife Cards (Figma Exact)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.76,
                ),
                itemCount: speciesList.length,
                itemBuilder: (context, index) {
                  final species = speciesList[index];
                  final isBookmarked = _bookmarkedSpecies.contains(species.id);

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SpeciesDetailScreen(species: species),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top Image with bookmark
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(17)),
                            child: Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1.18,
                                  child: Hero(
                                    tag: 'species-${species.id}',
                                    child: Image.network(
                                      species.imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        color: AppColors.sage,
                                        child: const Icon(Icons.pets, color: AppColors.forest),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (isBookmarked) {
                                          _bookmarkedSpecies.remove(species.id);
                                        } else {
                                          _bookmarkedSpecies.add(species.id);
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: AppColors.white.withOpacity(0.92),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.12),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                                        size: 16,
                                        color: isBookmarked ? AppColors.forest : AppColors.jungle,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Text Content
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  species.commonName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF143E2C),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  children: [
                                    Icon(
                                      species.category == 'Plants' || species.category == 'Trees'
                                          ? Icons.eco_outlined
                                          : (species.category == 'Birds' ? Icons.flutter_dash : Icons.pets_outlined),
                                      size: 11,
                                      color: AppColors.forest,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      species.category.endsWith('s')
                                          ? species.category.substring(0, species.category.length - 1)
                                          : species.category,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.forest,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  species.habitat,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.charcoal.withOpacity(0.65),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 28),

              // 8. Footer Quote (Figma Exact)
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.eco_outlined, size: 14, color: AppColors.forest),
                    const SizedBox(width: 6),
                    Text(
                      'Discover with care. Leave nature wild.',
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
}

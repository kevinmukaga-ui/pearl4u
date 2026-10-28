import 'package:flutter/material.dart';
import '../../models/species.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/status_pill.dart';
import 'species_detail_screen.dart';

class NatureGuideScreen extends StatefulWidget {
  const NatureGuideScreen({super.key});

  @override
  State<NatureGuideScreen> createState() => _NatureGuideScreenState();
}

class _NatureGuideScreenState extends State<NatureGuideScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = ['All', 'Primates', 'Birds', 'Mammals', 'Plants'];

  @override
  Widget build(BuildContext context) {
    final speciesList = Species.sampleSpecies.where((s) {
      if (_selectedCategory == 'All') return true;
      return s.category == _selectedCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nature Guide'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title & Introduction
            Text(
              'Uganda\'s Biodiversity',
              style: AppTypography.pageTitle,
            ),
            const SizedBox(height: 6),
            Text(
              'Explore over 1,000 bird species, endangered primates, and equatorial wildlife across ecosystems.',
              style: AppTypography.body.copyWith(color: AppColors.muted),
            ),
            const SizedBox(height: 18),

            // Category Filter Chips
            SizedBox(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = _selectedCategory == cat;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = cat),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.forest : AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? AppColors.forest : AppColors.border,
                        ),
                      ),
                      child: Text(
                        cat,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected ? AppColors.white : AppColors.charcoal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Species Cards List
            ...speciesList.map((species) {
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
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          width: 84,
                          height: 84,
                          child: Hero(
                            tag: 'species-' + species.id,
                            child: Image.network(
                              species.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, err, stack) => Container(
                                color: AppColors.sage,
                                child: const Icon(Icons.pets, color: AppColors.forest),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                StatusPill(
                                  label: species.conservationStatus,
                                  backgroundColor: species.conservationStatus == 'Endangered'
                                      ? AppColors.ochre.withOpacity(0.3)
                                      : AppColors.sage,
                                  textColor: AppColors.jungle,
                                ),
                                const Spacer(),
                                const Icon(Icons.chevron_right_rounded, color: AppColors.muted, size: 20),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              species.commonName,
                              style: AppTypography.cardHeading.copyWith(fontSize: 16),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              species.scientificName,
                              style: AppTypography.scientificName,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              species.habitat,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.caption,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../models/species.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/status_pill.dart';

class SpeciesDetailScreen extends StatelessWidget {
  final Species species;

  const SpeciesDetailScreen({super.key, required this.species});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.85),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_rounded, color: AppColors.jungle, size: 20),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'species-' + species.id,
                    child: Image.network(
                      species.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, err, stack) => Container(
                        color: AppColors.forest,
                        child: const Center(
                          child: Icon(Icons.pets, size: 64, color: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.transparent,
                          Colors.black.withOpacity(0.75),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StatusPill(
                          label: 'IUCN: ${species.conservationStatus}',
                          backgroundColor: AppColors.ochre,
                          textColor: AppColors.jungle,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          species.commonName,
                          style: AppTypography.pageTitle.copyWith(
                            color: AppColors.white,
                            fontSize: 26,
                          ),
                        ),
                        Text(
                          species.scientificName,
                          style: AppTypography.scientificName.copyWith(
                            color: AppColors.ivory.withOpacity(0.9),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Habitat & Category Overview
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.forest_outlined, color: AppColors.forest, size: 24),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Natural Habitat', style: AppTypography.caption),
                              const SizedBox(height: 2),
                              Text(
                                species.habitat,
                                style: AppTypography.cardHeading.copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Species Description
                  Text('About the Species', style: AppTypography.sectionHeading),
                  const SizedBox(height: 8),
                  Text(
                    species.description,
                    style: AppTypography.body.copyWith(
                      color: AppColors.charcoal,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Where to See in Uganda
                  Text('Where to Encounter', style: AppTypography.sectionHeading),
                  const SizedBox(height: 12),
                  ...species.primaryLocations.map((loc) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.pin_drop_outlined, color: AppColors.forest, size: 20),
                          const SizedBox(width: 10),
                          Text(loc, style: AppTypography.body.copyWith(fontWeight: FontWeight.w500)),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.muted),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 24),

                  // Fun Fact Card
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.sage.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.forest.withOpacity(0.2)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.lightbulb_outline_rounded, color: AppColors.forest, size: 24),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Did You Know?',
                                style: AppTypography.cardHeading.copyWith(
                                  fontSize: 15,
                                  color: AppColors.jungle,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                species.funFact,
                                style: AppTypography.body.copyWith(
                                  color: AppColors.charcoal,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 36),

                  PrimaryButton(
                    label: 'Explore Guided Safaris',
                    icon: Icons.travel_explore_rounded,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Wildlife guides and tracking permits info...'),
                          backgroundColor: AppColors.forest,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

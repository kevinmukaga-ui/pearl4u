import 'package:flutter/material.dart';
import '../../models/destination.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/status_pill.dart';

class DestinationDetailScreen extends StatefulWidget {
  final Destination destination;

  const DestinationDetailScreen({super.key, required this.destination});

  @override
  State<DestinationDetailScreen> createState() => _DestinationDetailScreenState();
}

class _DestinationDetailScreenState extends State<DestinationDetailScreen> {
  late bool _isSaved;

  @override
  void initState() {
    super.initState();
    _isSaved = widget.destination.isSaved;
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.destination;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Collapsible Image App Bar
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
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.85),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                    color: _isSaved ? AppColors.ochre : AppColors.jungle,
                    size: 20,
                  ),
                ),
                onPressed: () {
                  setState(() => _isSaved = !_isSaved);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(_isSaved ? 'Saved to your places' : 'Removed from saved'),
                      duration: const Duration(seconds: 1),
                      backgroundColor: AppColors.forest,
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'dest-',
                    child: Image.network(
                      d.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, err, stack) => Container(
                        color: AppColors.forest,
                        child: const Center(
                          child: Icon(Icons.landscape, size: 60, color: AppColors.white),
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
                          Colors.black.withOpacity(0.3),
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
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
                          label: d.category,
                          backgroundColor: AppColors.ochre,
                          textColor: AppColors.jungle,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          d.name,
                          style: AppTypography.pageTitle.copyWith(
                            color: AppColors.white,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Detail Content Body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location and Rating Row
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: AppColors.forest, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        d.region,
                        style: AppTypography.actionLabel.copyWith(
                          color: AppColors.charcoal,
                          fontSize: 13,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.star_rounded, color: AppColors.ochre, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        '${d.rating}',
                        style: AppTypography.actionLabel.copyWith(color: AppColors.jungle),
                      ),
                      const SizedBox(width: 4),
                      Text('(${d.reviewsCount})', style: AppTypography.caption),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Quick Info Highlights Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildFactColumn(Icons.calendar_month_outlined, 'Best Season', 'Dec - Feb'),
                        Container(width: 1, height: 36, color: AppColors.border),
                        _buildFactColumn(Icons.access_time_rounded, 'Avg. Visit', '2 - 3 Days'),
                        Container(width: 1, height: 36, color: AppColors.border),
                        _buildFactColumn(Icons.shield_outlined, 'Status', 'Protected'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Overview / Editorial
                  Text('Overview', style: AppTypography.sectionHeading),
                  const SizedBox(height: 8),
                  Text(
                    d.description,
                    style: AppTypography.body.copyWith(
                      color: AppColors.charcoal,
                      height: 1.5,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Top Activities
                  if (d.activities.isNotEmpty) ...[
                    Text('Experiences & Activities', style: AppTypography.sectionHeading),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: d.activities.map((act) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.sage.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.forest.withOpacity(0.2)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.check_circle_outline_rounded, size: 16, color: AppColors.forest),
                              const SizedBox(width: 6),
                              Text(
                                act,
                                style: AppTypography.actionLabel.copyWith(
                                  color: AppColors.jungle,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Directions & Navigation Handoff Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: AppColors.sage,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.navigation_rounded, color: AppColors.forest),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Navigate with External Maps', style: AppTypography.cardHeading.copyWith(fontSize: 15)),
                              const SizedBox(height: 2),
                              Text('Open Google Maps or Apple Maps', style: AppTypography.caption),
                            ],
                          ),
                        ),
                        const Icon(Icons.open_in_new_rounded, size: 18, color: AppColors.muted),
                      ],
                    ),
                  ),
                  const SizedBox(height: 36),

                  // Bottom Action CTA
                  PrimaryButton(
                    label: 'Plan Your Visit',
                    icon: Icons.explore_rounded,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tourism permit and booking guide opening...'),
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

  Widget _buildFactColumn(IconData icon, String title, String subtitle) {
    return Column(
      children: [
        Icon(icon, size: 20, color: AppColors.forest),
        const SizedBox(height: 6),
        Text(title, style: AppTypography.caption.copyWith(fontSize: 11)),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: AppTypography.actionLabel.copyWith(
            color: AppColors.jungle,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

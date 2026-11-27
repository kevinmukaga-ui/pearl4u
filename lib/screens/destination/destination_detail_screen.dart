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

                  // 7. Callout Card 2: "Leave a lighter footprint"
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.sage,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.eco_outlined,
                            color: AppColors.forest,
                            size: 22,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Leave a lighter footprint',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.forest,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Keep wildlife wild: give animals space, take litter with you and follow your guides advice. Protected habitats depend on thoughtful visitors.',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF2D3748),
                                    height: 1.4,
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

                  // 8. Section: "Find your way"
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Find your way',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E2922),
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Custom Stylized Illustrated Map Card
                        Container(
                          width: double.infinity,
                          height: 160,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5EDE3),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFD6E3D3), width: 1.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Stack(
                              children: [
                                // River curve graphic
                                Positioned.fill(
                                  child: CustomPaint(
                                    painter: _IllustrativeMapPainter(),
                                  ),
                                ),

                                // Top left title label
                                Positioned(
                                  top: 14,
                                  left: 14,
                                  child: Text(
                                    d.name,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.forest,
                                    ),
                                  ),
                                ),

                                // Center Pin badge
                                Positioned(
                                  top: 64,
                                  left: 0,
                                  right: 0,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 32,
                                        height: 32,
                                        decoration: const BoxDecoration(
                                          color: AppColors.forest,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        d.name.split(' ').take(2).join(' '),
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.forest,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Bottom left watermark
                                const Positioned(
                                  bottom: 12,
                                  left: 14,
                                  child: Text(
                                    'Illustrative map · not live',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFF5A6860),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Subtitle note
                        const Text(
                          'Illustrative map · not live. Location shown is approximate.',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF7A8880),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 9. Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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

class _IllustrativeMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final river = Path()
      ..moveTo(size.width * 0.12, size.height * 0.78)
      ..cubicTo(
        size.width * 0.32,
        size.height * 0.56,
        size.width * 0.52,
        size.height * 0.92,
        size.width * 0.88,
        size.height * 0.28,
      );

    canvas.drawPath(
      river,
      Paint()
        ..color = const Color(0xFFB7D7CE)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _IllustrativeMapPainter oldDelegate) => false;
}

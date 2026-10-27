import 'package:flutter/material.dart';
import '../../models/destination.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/status_pill.dart';
import '../destination/destination_detail_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Destination _selectedDestination = Destination.sampleDestinations.first;
  String _activeCategory = 'All';

  final List<Destination> _destinations = Destination.sampleDestinations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Simulated Interactive Map Canvas (Uganda Topography)
          Container(
            color: const Color(0xFFE5EDE3), // Gentle topographic green-ivory
            child: CustomPaint(
              size: Size.infinite,
              painter: _UgandaMapPainter(),
            ),
          ),

          // Map Pins
          SafeArea(
            child: Stack(
              children: [
                ..._destinations.map((dest) {
                  // Position markers visually across Uganda region representation
                  double topRatio = 0.35;
                  double leftRatio = 0.45;

                  if (dest.id == 'murchison') {
                    topRatio = 0.28;
                    leftRatio = 0.48;
                  } else if (dest.id == 'rwenzori') {
                    topRatio = 0.48;
                    leftRatio = 0.22;
                  } else if (dest.id == 'queen_elizabeth') {
                    topRatio = 0.58;
                    leftRatio = 0.28;
                  } else if (dest.id == 'bwindi') {
                    topRatio = 0.72;
                    leftRatio = 0.24;
                  } else if (dest.id == 'bunyonyi') {
                    topRatio = 0.76;
                    leftRatio = 0.36;
                  }

                  final isSelected = _selectedDestination.id == dest.id;

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return Positioned(
                        top: constraints.maxHeight * topRatio,
                        left: constraints.maxWidth * leftRatio,
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _selectedDestination = dest);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                padding: EdgeInsets.all(isSelected ? 10 : 7),
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColors.forest : AppColors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.jungle.withOpacity(isSelected ? 0.3 : 0.15),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                  border: Border.all(
                                    color: isSelected ? AppColors.ochre : AppColors.forest,
                                    width: isSelected ? 2.5 : 1.5,
                                  ),
                                ),
                                child: Icon(
                                  Icons.location_on_rounded,
                                  size: isSelected ? 22 : 16,
                                  color: isSelected ? AppColors.white : AppColors.forest,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppColors.white.withOpacity(0.92),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.08),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  dest.name.split(' ').first,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                                    color: isSelected ? AppColors.forest : AppColors.charcoal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),

                // Top Controls & Header Bar
                Positioned(
                  top: 12,
                  left: 20,
                  right: 20,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.jungle.withOpacity(0.07),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.explore_outlined, color: AppColors.forest),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Explore Uganda Map',
                                style: AppTypography.cardHeading.copyWith(fontSize: 16),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.sage,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${_destinations.length} Sites',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.forest,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Quick Category Toggle
                      SizedBox(
                        height: 36,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildFilterChip('All'),
                            _buildFilterChip('National Parks'),
                            _buildFilterChip('Waterfalls'),
                            _buildFilterChip('Mountains'),
                            _buildFilterChip('Lakes'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Floating Map Bottom Attraction Preview (Figma: Raised preview y 4, blur 16)
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.jungle.withOpacity(0.12),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child: Image.network(
                                _selectedDestination.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (ctx, err, stack) => Container(
                                  color: AppColors.forest,
                                  child: const Icon(Icons.landscape, color: Colors.white),
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
                                      label: _selectedDestination.category,
                                      backgroundColor: AppColors.sage,
                                      textColor: AppColors.forest,
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.star_rounded, size: 16, color: AppColors.ochre),
                                    const SizedBox(width: 2),
                                    Text(
                                      '${_selectedDestination.rating}',
                                      style: AppTypography.caption.copyWith(
                                        color: AppColors.jungle,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  _selectedDestination.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.cardHeading.copyWith(fontSize: 16),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _selectedDestination.region,
                                  style: AppTypography.caption,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton.filled(
                            style: IconButton.styleFrom(
                              backgroundColor: AppColors.forest,
                              foregroundColor: AppColors.white,
                            ),
                            icon: const Icon(Icons.arrow_forward_rounded, size: 20),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DestinationDetailScreen(
                                    destination: _selectedDestination,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _activeCategory == label;
    return GestureDetector(
      onTap: () => setState(() => _activeCategory = label),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.forest : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColors.white : AppColors.charcoal,
          ),
        ),
      ),
    );
  }
}

class _UgandaMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintWater = Paint()
      ..color = const Color(0xFFC7DEED)
      ..style = PaintingStyle.fill;

    // Draw Lake Victoria representation in southeastern region
    final lakeVictoriaPath = Path()
      ..moveTo(size.width * 0.45, size.height * 0.68)
      ..quadraticBezierTo(size.width * 0.65, size.height * 0.60, size.width * 0.85, size.height * 0.70)
      ..quadraticBezierTo(size.width * 0.90, size.height * 0.90, size.width * 0.60, size.height * 0.95)
      ..quadraticBezierTo(size.width * 0.40, size.height * 0.85, size.width * 0.45, size.height * 0.68)
      ..close();
    canvas.drawPath(lakeVictoriaPath, paintWater);

    // Draw Lake Albert & Nile route representation in northwest
    final lakeAlbertPath = Path()
      ..moveTo(size.width * 0.20, size.height * 0.30)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.25, size.width * 0.35, size.height * 0.20)
      ..lineTo(size.width * 0.30, size.height * 0.38)
      ..close();
    canvas.drawPath(lakeAlbertPath, paintWater);

    // Gentle contour lines
    final paintContour = Paint()
      ..color = const Color(0xFFD6E4D3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(Offset(size.width * 0.25, size.height * 0.50), 60, paintContour);
    canvas.drawCircle(Offset(size.width * 0.30, size.height * 0.70), 40, paintContour);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

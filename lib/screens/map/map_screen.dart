import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' hide Path;
import '../../models/destination.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/status_pill.dart';
import '../destination/destination_detail_screen.dart';

enum MapLayerStyle {
  streets,
  satellite,
  terrain,
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  final MapController _mapController = MapController();
  Destination _selectedDestination = Destination.sampleDestinations.first;
  String _activeCategory = 'All';
  MapLayerStyle _currentLayerStyle = MapLayerStyle.streets;

  // Center of Uganda coordinates
  static const LatLng _ugandaCenter = LatLng(1.3733, 32.2903);
  static const double _initialZoom = 7.2;

  final List<Destination> _allDestinations = Destination.sampleDestinations;

  List<Destination> get _filteredDestinations {
    if (_activeCategory == 'All') return _allDestinations;
    return _allDestinations.where((d) {
      if (_activeCategory == 'National Parks') return d.category == 'National Parks';
      if (_activeCategory == 'Waterfalls') return d.category == 'Waterfalls' || d.name.contains('Falls');
      if (_activeCategory == 'Mountains') return d.category == 'Mountains';
      if (_activeCategory == 'Wildlife') return d.category == 'Wildlife';
      if (_activeCategory == 'Lakes') return d.category == 'Lakes';
      return true;
    }).toList();
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final camera = _mapController.camera;
    final latTween = Tween<double>(
      begin: camera.center.latitude,
      end: destLocation.latitude,
    );
    final lngTween = Tween<double>(
      begin: camera.center.longitude,
      end: destLocation.longitude,
    );
    final zoomTween = Tween<double>(
      begin: camera.zoom,
      end: destZoom,
    );

    final controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    final animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOutCubic,
    );

    controller.addListener(() {
      _mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  String _getTileUrl() {
    switch (_currentLayerStyle) {
      case MapLayerStyle.satellite:
        return 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}';
      case MapLayerStyle.terrain:
        return 'https://tile.opentopomap.org/{z}/{x}/{y}.png';
      case MapLayerStyle.streets:
      default:
        return 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final destinations = _filteredDestinations;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Google-Style Interactive Map (Pinch to zoom, pan, full Uganda detail)
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _ugandaCenter,
              initialZoom: _initialZoom,
              minZoom: 5.5,
              maxZoom: 17.0,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: _getTileUrl(),
                userAgentPackageName: 'com.pearl4u.app',
                maxZoom: 19,
              ),
              MarkerLayer(
                markers: destinations.map((dest) {
                  final isSelected = _selectedDestination.id == dest.id;
                  final latLng = LatLng(dest.latitude, dest.longitude);

                  return Marker(
                    point: latLng,
                    width: isSelected ? 120 : 80,
                    height: isSelected ? 80 : 60,
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _selectedDestination = dest);
                        _animatedMapMove(latLng, 9.5);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Pin badge
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            padding: EdgeInsets.symmetric(
                              horizontal: isSelected ? 10 : 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.forest : AppColors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? AppColors.ochre : AppColors.forest,
                                width: isSelected ? 2 : 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  size: isSelected ? 18 : 14,
                                  color: isSelected ? AppColors.ochre : AppColors.forest,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    dest.name.split(' ').first,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: isSelected ? 12 : 10,
                                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                                      color: isSelected ? AppColors.white : AppColors.jungle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Pin arrow stem
                          CustomPaint(
                            size: const Size(12, 6),
                            painter: _PinTrianglePainter(
                              color: isSelected ? AppColors.forest : AppColors.white,
                              strokeColor: isSelected ? AppColors.ochre : AppColors.forest,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          // 2. Top Header & Search Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.travel_explore_rounded, color: AppColors.forest, size: 24),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Explore Uganda',
                                style: AppTypography.cardHeading.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                '${destinations.length} Interactive Destinations',
                                style: AppTypography.caption.copyWith(fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                        // Layer Selector Button
                        PopupMenuButton<MapLayerStyle>(
                          icon: const Icon(Icons.layers_rounded, color: AppColors.forest),
                          tooltip: 'Change Map Style',
                          onSelected: (style) {
                            setState(() => _currentLayerStyle = style);
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: MapLayerStyle.streets,
                              child: Row(
                                children: [
                                  Icon(Icons.map_rounded, color: AppColors.forest),
                                  SizedBox(width: 8),
                                  Text('Street Map'),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: MapLayerStyle.satellite,
                              child: Row(
                                children: [
                                  Icon(Icons.satellite_alt_rounded, color: AppColors.forest),
                                  SizedBox(width: 8),
                                  Text('Satellite Imagery'),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: MapLayerStyle.terrain,
                              child: Row(
                                children: [
                                  Icon(Icons.terrain_rounded, color: AppColors.forest),
                                  SizedBox(width: 8),
                                  Text('Topographic Terrain'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Category Filter Chips
                  SizedBox(
                    height: 36,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildFilterChip('All'),
                        _buildFilterChip('National Parks'),
                        _buildFilterChip('Waterfalls'),
                        _buildFilterChip('Mountains'),
                        _buildFilterChip('Wildlife'),
                        _buildFilterChip('Lakes'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

          // 3. Google Maps Style Zoom & Recenter Controls (Floating Right)
          Positioned(
            right: 16,
            bottom: 230,
            child: Column(
              children: [
                _buildMapFloatingButton(
                  icon: Icons.add,
                  tooltip: 'Zoom In',
                  onTap: () {
                    final currentZoom = _mapController.camera.zoom;
                    _mapController.move(_mapController.camera.center, currentZoom + 1);
                  },
                ),
                const SizedBox(height: 8),
                _buildMapFloatingButton(
                  icon: Icons.remove,
                  tooltip: 'Zoom Out',
                  onTap: () {
                    final currentZoom = _mapController.camera.zoom;
                    _mapController.move(_mapController.camera.center, currentZoom - 1);
                  },
                ),
                const SizedBox(height: 8),
                _buildMapFloatingButton(
                  icon: Icons.my_location_rounded,
                  tooltip: 'Recenter Uganda',
                  onTap: () {
                    _animatedMapMove(_ugandaCenter, _initialZoom);
                  },
                ),
              ],
            ),
          ),

          // 4. Floating Destination Preview Card (Bottom)
          Positioned(
            bottom: 24,
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
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
                        width: 85,
                        height: 85,
                        child: Image.network(
                          _selectedDestination.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, err, stack) => Container(
                            color: AppColors.forest,
                            child: const Icon(Icons.landscape, color: Colors.white, size: 36),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
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
                            style: AppTypography.cardHeading.copyWith(fontSize: 15),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _selectedDestination.region,
                            style: AppTypography.caption.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.forest,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.all(12),
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
    );
  }

  Widget _buildMapFloatingButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Tooltip(
          message: tooltip,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(icon, color: AppColors.jungle, size: 20),
            ),
          ),
        ),
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
              color: Colors.black.withOpacity(0.08),
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

class _PinTrianglePainter extends CustomPainter {
  final Color color;
  final Color strokeColor;

  _PinTrianglePainter({required this.color, required this.strokeColor});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

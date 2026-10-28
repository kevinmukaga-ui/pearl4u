import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'status_pill.dart';

class DestinationCard extends StatefulWidget {
  final Destination destination;
  final VoidCallback onTap;
  final VoidCallback? onBookmarkToggle;

  const DestinationCard({
    super.key,
    required this.destination,
    required this.onTap,
    this.onBookmarkToggle,
  });

  @override
  State<DestinationCard> createState() => _DestinationCardState();
}

class _DestinationCardState extends State<DestinationCard> with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _scaleAnimation;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _isSaved = widget.destination.isSaved;
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 140),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.975).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant DestinationCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.destination.isSaved != widget.destination.isSaved) {
      setState(() => _isSaved = widget.destination.isSaved);
    }
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final destination = widget.destination;

    return GestureDetector(
      onTapDown: (_) => _pressController.forward(),
      onTapUp: (_) => _pressController.reverse(),
      onTapCancel: () => _pressController.reverse(),
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: AppColors.jungle.withOpacity(0.06),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Image with rounded top corners
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(19)),
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9.5,
                      child: Hero(
                        tag: 'dest-${destination.id}',
                        child: Image.network(
                          destination.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: AppColors.sage,
                            child: const Center(
                              child: Icon(Icons.terrain_rounded, size: 48, color: AppColors.forest),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Bookmark toggle with animated scale
                    Positioned(
                      top: 12,
                      right: 12,
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _isSaved = !_isSaved);
                          if (widget.onBookmarkToggle != null) {
                            widget.onBookmarkToggle!();
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(0.92),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: AnimatedScale(
                            scale: _isSaved ? 1.15 : 1.0,
                            duration: const Duration(milliseconds: 150),
                            curve: Curves.easeOutBack,
                            child: Icon(
                              _isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                              color: _isSaved ? AppColors.ochre : AppColors.jungle,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      left: 12,
                      child: StatusPill(
                        label: destination.category,
                        backgroundColor: AppColors.white.withOpacity(0.95),
                        textColor: AppColors.jungle,
                      ),
                    ),
                  ],
                ),
              ),

              // Content details
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destination.region.toUpperCase(),
                      style: AppTypography.eyebrow.copyWith(
                        color: AppColors.forest,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      destination.name,
                      style: AppTypography.cardHeading.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      destination.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.body.copyWith(
                        color: AppColors.charcoal.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, size: 18, color: AppColors.ochre),
                        const SizedBox(width: 4),
                        Text(
                          '${destination.rating}',
                          style: AppTypography.actionLabel.copyWith(
                            color: AppColors.jungle,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${destination.reviewsCount} reviews)',
                          style: AppTypography.caption,
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.sage.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Explore',
                                style: AppTypography.actionLabel.copyWith(
                                  color: AppColors.forest,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.arrow_forward_rounded, size: 14, color: AppColors.forest),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'status_pill.dart';

class DestinationCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with rounded top corners
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      color: AppColors.sage.withOpacity(0.5),
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
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          destination.isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                          color: destination.isSaved ? AppColors.ochre : AppColors.jungle,
                          size: 20,
                        ),
                        onPressed: onBookmarkToggle,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: StatusPill(
                      label: destination.category,
                      backgroundColor: AppColors.white.withOpacity(0.92),
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
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    destination.name,
                    style: AppTypography.cardHeading,
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
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, size: 18, color: AppColors.ochre),
                      const SizedBox(width: 4),
                      Text(
                        '${destination.rating}',
                        style: AppTypography.actionLabel.copyWith(
                          color: AppColors.jungle,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${destination.reviewsCount} reviews)',
                        style: AppTypography.caption,
                      ),
                      const Spacer(),
                      Text(
                        'Explore details',
                        style: AppTypography.actionLabel.copyWith(
                          color: AppColors.forest,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward_rounded, size: 14, color: AppColors.forest),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

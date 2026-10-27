import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class StatusPill extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;

  const StatusPill({
    super.key,
    required this.label,
    this.backgroundColor = AppColors.sage,
    this.textColor = AppColors.jungle,
    this.icon,
  });

  const StatusPill.ochre({
    super.key,
    required this.label,
    this.icon,
  })  : backgroundColor = AppColors.ochre,
        textColor = AppColors.jungle;

  const StatusPill.forest({
    super.key,
    required this.label,
    this.icon,
  })  : backgroundColor = AppColors.forest,
        textColor = AppColors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Pearl4U Typography Scale
/// Direct implementation of Figma type scale (Inter font family)
class AppTypography {
  AppTypography._();

  static const TextStyle welcomeDisplay = TextStyle(
    fontSize: 40,
    height: 45 / 40,
    fontWeight: FontWeight.w800,
    color: AppColors.jungle,
    letterSpacing: -0.5,
  );

  static const TextStyle pageTitle = TextStyle(
    fontSize: 28,
    height: 31 / 28,
    fontWeight: FontWeight.w700,
    color: AppColors.jungle,
    letterSpacing: -0.3,
  );

  static const TextStyle sectionHeading = TextStyle(
    fontSize: 22,
    height: 28 / 22,
    fontWeight: FontWeight.w700,
    color: AppColors.jungle,
    letterSpacing: -0.2,
  );

  static const TextStyle cardHeading = TextStyle(
    fontSize: 18,
    height: 24 / 18,
    fontWeight: FontWeight.w600,
    color: AppColors.jungle,
  );

  static const TextStyle body = TextStyle(
    fontSize: 15,
    height: 22 / 15,
    fontWeight: FontWeight.w400,
    color: AppColors.charcoal,
  );

  static const TextStyle actionLabel = TextStyle(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    height: 17 / 12,
    fontWeight: FontWeight.w500,
    color: AppColors.muted,
  );

  static const TextStyle eyebrow = TextStyle(
    fontSize: 11,
    height: 16 / 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
    color: AppColors.forest,
  );

  static const TextStyle scientificName = TextStyle(
    fontSize: 13,
    fontStyle: FontStyle.italic,
    color: AppColors.muted,
  );
}

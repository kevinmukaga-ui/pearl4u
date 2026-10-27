import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/secondary_button.dart';
import 'sign_in_screen.dart';
import '../main_nav_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient / Landscape Artwork Simulation
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0F382A), // Deep Jungle
                  Color(0xFF174D38), // Forest
                  Color(0xFF2E6349),
                  AppColors.ivory,
                ],
                stops: [0.0, 0.45, 0.75, 1.0],
              ),
            ),
          ),

          // Legibility Scrim
          Container(
            color: Colors.black.withOpacity(0.15),
          ),

          // Foreground Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  // Pearl4U Identity (Sprout + Wordmark)
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.ivory.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.eco_rounded,
                          color: AppColors.forest,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Pearl4U',
                        style: AppTypography.cardHeading.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Eyebrow and Tagline
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 2,
                        color: AppColors.ochre,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'YOURS TO DISCOVER',
                        style: AppTypography.eyebrow.copyWith(
                          color: AppColors.ochre,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Discover the Pearl\nof Africa.',
                    style: AppTypography.welcomeDisplay.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "From the power of the Nile to the quiet of the forest. Explore Uganda's places, wildlife, and living landscapes.",
                    style: AppTypography.body.copyWith(
                      color: AppColors.ivory.withOpacity(0.9),
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 36),

                  // Action Buttons
                  PrimaryButton(
                    label: 'Start Exploring',
                    icon: Icons.arrow_forward_rounded,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainNavScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  SecondaryButton(
                    label: 'Sign In',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // Subtitle
                  Center(
                    child: Text(
                      'Explore freely. Sign in to keep your saved places.',
                      textAlign: TextAlign.center,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.charcoal.withOpacity(0.7),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

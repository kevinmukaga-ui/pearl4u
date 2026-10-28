import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import 'edit_profile_screen.dart';
import '../auth/welcome_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile & account'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          children: [
            // User Avatar Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.sage,
                    child: Text(
                      'MZ',
                      style: AppTypography.cardHeading.copyWith(
                        color: AppColors.jungle,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mpotaima Ziriyah',
                          style: AppTypography.cardHeading,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'mpotaimaziriyah@gmail.com',
                          style: AppTypography.caption,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.sage.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Explorer Member',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.forest,
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, color: AppColors.forest),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfileScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Statistics Row
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Saved Places', '8', Icons.bookmark_outline_rounded),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard('Guides Read', '14', Icons.auto_stories_outlined),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Account Options List
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  _buildOptionTile(
                    icon: Icons.person_outline_rounded,
                    title: 'Edit Profile',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfileScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  _buildOptionTile(
                    icon: Icons.download_for_offline_outlined,
                    title: 'Offline Maps & Guides',
                    subtitle: 'Save data while in the field',
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  _buildOptionTile(
                    icon: Icons.notifications_none_rounded,
                    title: 'Notifications',
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  _buildOptionTile(
                    icon: Icons.help_outline_rounded,
                    title: 'Help & Tourism Support',
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  _buildOptionTile(
                    icon: Icons.info_outline_rounded,
                    title: 'About Pearl4U',
                    subtitle: 'v1.0.0 (Uganda Wildlife Edition)',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Logout Button
            TextButton.icon(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout_rounded, color: AppColors.error),
              label: Text(
                'Sign Out',
                style: AppTypography.actionLabel.copyWith(color: AppColors.error),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String count, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.sage,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.forest, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count,
                style: AppTypography.cardHeading.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
              Text(
                title,
                style: AppTypography.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.jungle, size: 22),
      title: Text(title, style: AppTypography.body.copyWith(fontWeight: FontWeight.w500)),
      subtitle: subtitle != null ? Text(subtitle, style: AppTypography.caption) : null,
      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.muted, size: 20),
      onTap: onTap,
    );
  }
}

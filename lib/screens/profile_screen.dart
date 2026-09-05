import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 15),

            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primaryDark,
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_rounded,
                color: Colors.white,
                size: 45,
              ),
            ),

            const SizedBox(height: 14),

            const Text(
              'Movie Explorer',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Cinema enthusiast',
              style: TextStyle(
                color: AppColors.textGrey,
              ),
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                _statCard(
                  icon: Icons.movie_outlined,
                  number: '10',
                  label: 'Movies',
                ),
                const SizedBox(width: 12),
                _statCard(
                  icon: Icons.favorite_outline,
                  number: '0',
                  label: 'Favorites',
                ),
                const SizedBox(width: 12),
                _statCard(
                  icon: Icons.star_outline,
                  number: '8.4',
                  label: 'Avg. Rating',
                ),
              ],
            ),

            const SizedBox(height: 30),

            _optionCard(
              icon: Icons.bookmark_border_rounded,
              title: 'My Watchlist',
              subtitle: 'Movies saved for later',
              onTap: () {},
            ),

            _optionCard(
              icon: Icons.notifications_none_rounded,
              title: 'Notifications',
              subtitle: 'Manage movie alerts',
              onTap: () {},
            ),

            _optionCard(
              icon: Icons.settings_outlined,
              title: 'Settings',
              subtitle: 'App preferences',
              onTap: () {},
            ),

            _optionCard(
              icon: Icons.info_outline_rounded,
              title: 'About CineVerse',
              subtitle: 'Version 1.0.0',
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'CineVerse',
                  applicationVersion: '1.0.0',
                  applicationIcon: const Icon(
                    Icons.movie_filter_rounded,
                    color: AppColors.primary,
                  ),
                  children: const [
                    Text(
                      'A modern movie discovery demo app built with Flutter.',
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _statCard({
    required IconData icon,
    required String number,
    required String label,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 17,
          horizontal: 5,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.secondary,
              size: 21,
            ),
            const SizedBox(height: 8),
            Text(
              number,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textGrey,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _optionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
          side: const BorderSide(
            color: AppColors.border,
          ),
        ),
        tileColor: AppColors.surface,
        leading: Container(
          width: 43,
          height: 43,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(.12),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            icon,
            color: AppColors.secondary,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: AppColors.textGrey,
            fontSize: 11,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: AppColors.textGrey,
        ),
      ),
    );
  }
}
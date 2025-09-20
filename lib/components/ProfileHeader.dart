import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String imagePath;
  final int recipes;
  final int following;
  final int followers;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.imagePath,
    required this.recipes,
    required this.following,
    required this.followers,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(radius: 32, backgroundImage: AssetImage(imagePath)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.h2),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildStat('Recipes', recipes.toString()),
                    _buildDot(),
                    _buildStat('Following', following.toString()),
                    _buildDot(),
                    _buildStat('Followers', followers.toString()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Row(
      children: [
        Text(
          value,
          style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(width: 4),
        Text(label, style: AppTextStyles.bodySecondary),
      ],
    );
  }

  Widget _buildDot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 4,
        height: 4,
        decoration: const BoxDecoration(
          color: AppColors.textSecondary,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

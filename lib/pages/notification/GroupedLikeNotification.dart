import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';

class GroupedLikeNotification extends StatelessWidget {
  final String firstUserName;
  final String? secondUserName;
  final String firstUserImage;
  final String? secondUserImage;
  final String action;
  final String time;
  final String thumbnailPath;

  const GroupedLikeNotification({
    super.key,
    required this.firstUserName,
    this.secondUserName,
    required this.firstUserImage,
    this.secondUserImage,
    required this.action,
    required this.time,
    required this.thumbnailPath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          secondUserImage != null && secondUserImage!.isNotEmpty
              ? _buildDiagonalAvatars(firstUserImage, secondUserImage!)
              : _buildSingleAvatar(firstUserImage),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textPrimary,
                ),
                children: [
                  TextSpan(
                    text: firstUserName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (secondUserName != null && secondUserName!.isNotEmpty) ...[
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: secondUserName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                  TextSpan(
                    text: ' $action • $time',
                    style: AppTextStyles.bodySecondary,
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              thumbnailPath,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSingleAvatar(String image) {
    return _buildProfilePic(image, size: 38, withBorder: true);
  }

  Widget _buildDiagonalAvatars(String firstImage, String secondImage) {
    return SizedBox(
      width: 60,
      height: 48,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: 8,
            child: _buildProfilePic(secondImage, size: 32, withBorder: false),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: _buildProfilePic(firstImage, size: 38, withBorder: true),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePic(
    String path, {
    double size = 32,
    bool withBorder = false,
  }) {
    return Container(
      padding: withBorder ? const EdgeInsets.all(2) : EdgeInsets.zero,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Image.asset(path, width: size, height: size, fit: BoxFit.cover),
      ),
    );
  }
}

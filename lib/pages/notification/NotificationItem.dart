import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_button.dart';

class NotificationItem extends StatelessWidget {
  final String name;
  final String action;
  final String time;
  final String imagePath;
  final String? thumbnailPath;
  final bool showFollowButton;
  final bool isFollowed;

  const NotificationItem({
    super.key,
    required this.name,
    required this.action,
    required this.time,
    required this.imagePath,
    this.thumbnailPath,
    this.showFollowButton = false,
    this.isFollowed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          CircleAvatar(radius: 24, backgroundImage: AssetImage(imagePath)),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textPrimary,
                ),
                children: [
                  TextSpan(
                    text: name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' $action • $time'),
                ],
              ),
            ),
          ),
          if (thumbnailPath != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                thumbnailPath!,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          if (showFollowButton)
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: CustomButton(
                text: isFollowed ? 'Following' : 'Follow',
                onPressed: () {
                  print(
                    'Button pressed: ${isFollowed ? 'Following' : 'Follow'}',
                  );
                },
                backgroundColor: isFollowed
                    ? Colors.grey[100]!
                    : AppColors.primary,
                textColor: isFollowed ? AppColors.textSecondary : Colors.white,
                borderColor: isFollowed ? Colors.grey[300] : null,
                borderWidth: 1,
                borderradius: 20,
                width: 90,
                height: 36,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

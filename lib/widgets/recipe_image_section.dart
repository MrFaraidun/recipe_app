import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class RecipeImageSection extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onChangeImage;

  const RecipeImageSection({
    super.key,
    required this.imageUrl,
    required this.onChangeImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        color: Colors.grey[100],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 12,
            right: 12,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: const Icon(Icons.camera_alt, color: Colors.white),
                onPressed: onChangeImage,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

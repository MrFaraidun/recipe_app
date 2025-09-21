import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class IngredientsSection extends StatelessWidget {
  final List<String> ingredients;
  final VoidCallback onAddIngredient;
  final Function(int) onEditIngredient;
  final Function(int) onRemoveIngredient;

  const IngredientsSection({
    super.key,
    required this.ingredients,
    required this.onAddIngredient,
    required this.onEditIngredient,
    required this.onRemoveIngredient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ingredients',
                style: AppTextStyles.h3.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: AppColors.primary),
                onPressed: onAddIngredient,
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (ingredients.isEmpty)
            _buildEmptyState()
          else
            ...ingredients.asMap().entries.map((entry) {
              int index = entry.key;
              String ingredient = entry.value;
              return _buildIngredientItem(ingredient, index);
            }),
        ],
      ),
    );
  }

  Widget _buildIngredientItem(String ingredient, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(child: Text(ingredient, style: AppTextStyles.body)),
          IconButton(
            icon: const Icon(Icons.edit, size: 16, color: AppColors.primary),
            onPressed: () => onEditIngredient(index),
          ),
          IconButton(
            icon: const Icon(Icons.delete, size: 16, color: Colors.red),
            onPressed: () => onRemoveIngredient(index),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(Icons.local_dining, size: 48, color: AppColors.textSecondary),
            const SizedBox(height: 8),
            Text(
              'No Ingredients',
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Tap + to add ingredients',
              style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

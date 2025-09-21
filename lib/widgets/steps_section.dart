import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class StepsSection extends StatelessWidget {
  final List<String> steps;
  final VoidCallback onAddStep;
  final Function(int) onEditStep;
  final Function(int) onRemoveStep;

  const StepsSection({
    super.key,
    required this.steps,
    required this.onAddStep,
    required this.onEditStep,
    required this.onRemoveStep,
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
                'Cooking Steps',
                style: AppTextStyles.h3.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: AppColors.primary),
                onPressed: onAddStep,
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (steps.isEmpty)
            _buildEmptyState()
          else
            ...steps.asMap().entries.map((entry) {
              int index = entry.key;
              String step = entry.value;
              return _buildStepItem(step, index);
            }),
        ],
      ),
    );
  }

  Widget _buildStepItem(String step, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(step, style: AppTextStyles.body)),
          IconButton(
            icon: const Icon(Icons.edit, size: 16, color: AppColors.primary),
            onPressed: () => onEditStep(index),
          ),
          IconButton(
            icon: const Icon(Icons.delete, size: 16, color: Colors.red),
            onPressed: () => onRemoveStep(index),
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
            Icon(Icons.list_alt, size: 48, color: AppColors.textSecondary),
            const SizedBox(height: 8),
            Text(
              'No Steps',
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Tap + to add cooking steps',
              style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

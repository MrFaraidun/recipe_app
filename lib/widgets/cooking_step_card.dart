import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'custom_button.dart';

class CookingStepCard extends StatelessWidget {
  final String step;
  final int stepNumber;
  final int totalSteps;
  final bool isCurrentStep;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;

  const CookingStepCard({
    super.key,
    required this.step,
    required this.stepNumber,
    required this.totalSteps,
    this.isCurrentStep = false,
    this.onNext,
    this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isCurrentStep
            ? AppColors.primary.withOpacity(0.1)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrentStep ? AppColors.primary : AppColors.border,
          width: isCurrentStep ? 2 : 1,
        ),
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
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isCurrentStep
                      ? AppColors.primary
                      : AppColors.textSecondary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$stepNumber',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Step $stepNumber of $totalSteps',
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              if (isCurrentStep)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Current',
                    style: AppTextStyles.bodySecondary.copyWith(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            step,
            style: AppTextStyles.body.copyWith(
              color: AppColors.textPrimary,
              height: 1.5,
            ),
          ),
          if (isCurrentStep && (onNext != null || onPrevious != null)) ...[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (onPrevious != null)
                  CustomButton(
                    text: 'Previous',
                    onPressed: onPrevious!,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                    height: 36,
                    borderradius: 18,
                  )
                else
                  const SizedBox.shrink(),
                if (onNext != null)
                  CustomButton(
                    text: 'Next',
                    onPressed: onNext!,
                    backgroundColor: AppColors.primary,
                    textColor: Colors.white,
                    height: 36,
                    borderradius: 18,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

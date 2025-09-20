import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Widget? child;
  final double? width;
  final double? height;
  final Color? borderColor;
  final double borderWidth;
  final double? borderradius; // intentionally matches existing usage name
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.primary,
    this.textColor = Colors.white,
    this.child,
    this.width = double.infinity,
    this.height,
    this.borderColor,
    this.borderWidth = 1,
    this.borderradius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null;
    final BorderSide? side = borderColor != null
        ? BorderSide(color: borderColor!, width: borderWidth)
        : null;

    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled
            ? AppColors.textSecondary.withOpacity(0.4)
            : backgroundColor,
        foregroundColor: textColor,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderradius ?? 12),
        ),
        elevation: 0,
        side: side,
      ),
      child:
          child ??
          Text(
            text ?? '',
            style: AppTextStyles.body.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
    );

    if (width != null || height != null) {
      return SizedBox(width: width, height: height, child: button);
    }
    return SizedBox(width: double.infinity, child: button);
  }
}

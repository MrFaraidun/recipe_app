import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final IconData? icon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool readOnly;
  final Color textColor;
  final Color labelColor;
  final Color focusedLabelColor;
  final Color iconColor;
  final Color focusedIconColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final double? borderradius;
  final double borderWidth;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final String? errorText;

  const CustomTextField({
    super.key,
    required this.label,
    this.hintText,
    this.icon,
    this.suffixIcon,
    this.obscureText = false,
    this.readOnly = false,
    this.textColor = AppColors.textPrimary,
    this.labelColor = AppColors.textPrimary,
    this.focusedLabelColor = AppColors.textSecondary,
    this.iconColor = AppColors.textSecondary,
    this.focusedIconColor = AppColors.primary,
    this.borderColor = AppColors.border,
    this.focusedBorderColor = AppColors.primary,
    this.borderradius,
    this.borderWidth = 1,
    this.keyboardType,
    this.textInputAction,
    this.controller,
    this.onChanged,
    this.onTap,
    this.inputFormatters,
    this.maxLines = 1,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      maxLines: obscureText ? 1 : maxLines,
      readOnly: readOnly,
      onTap: onTap,
      style: AppTextStyles.body.copyWith(color: textColor),
      decoration: InputDecoration(
        hintText: hintText ?? label,
        hintStyle: AppTextStyles.body.copyWith(
          color: labelColor.withOpacity(0.7),
        ),
        prefixIcon: icon != null ? Icon(icon, color: iconColor) : null,
        suffixIcon: suffixIcon,
        errorText: errorText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderradius ?? 12),
          borderSide: BorderSide(color: focusedBorderColor, width: borderWidth),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderradius ?? 12),
          borderSide: BorderSide(color: borderColor, width: borderWidth),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }
}

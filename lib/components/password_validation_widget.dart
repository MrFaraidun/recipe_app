import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class PasswordValidationWidget extends StatelessWidget {
  final Color brandColor;
  final TextEditingController passwordController;
  final TextEditingController confirmController;
  final bool showConfirmField;
  final bool hasSixChars;
  final bool hasNumber;
  final bool hasUppercase;
  final bool hasLowercase;
  final bool passwordsMatch;

  const PasswordValidationWidget({
    super.key,
    required this.brandColor,
    required this.passwordController,
    required this.confirmController,
    required this.showConfirmField,
    required this.hasSixChars,
    required this.hasNumber,
    required this.hasUppercase,
    required this.hasLowercase,
    required this.passwordsMatch,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRule('At least 8 characters', hasSixChars),
        _buildRule('Contains a number', hasNumber),
        _buildRule('Contains uppercase', hasUppercase),
        _buildRule('Contains lowercase', hasLowercase),
        if (showConfirmField) ...[
          const SizedBox(height: 10),
          TextField(
            controller: confirmController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          _buildRule('Passwords match', passwordsMatch),
        ],
      ],
    );
  }

  Widget _buildRule(String label, bool ok) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            ok ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 18,
            color: ok ? brandColor : AppColors.textSecondary,
          ),
          const SizedBox(width: 8),
          Text(label, style: AppTextStyles.bodySecondary),
        ],
      ),
    );
  }
}

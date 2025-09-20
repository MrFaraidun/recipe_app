import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/CustomTextField.dart';
import '../../widgets/custom_button.dart';

class PasswordRecoveryPage extends StatefulWidget {
  const PasswordRecoveryPage({super.key});

  @override
  State<PasswordRecoveryPage> createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),

              // Title
              Text(
                'Password recovery',
                style: AppTextStyles.h1.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1A1A),
                ),
              ),

              const SizedBox(height: 16),

              // Subtitle
              Text(
                'Enter your email to recover your password',
                style: AppTextStyles.bodySecondary.copyWith(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // Email input
              CustomTextField(
                label: '',
                controller: emailController,
                hintText: 'Syafrilchoirul17@gmail.com',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                borderColor: Colors.grey[300]!,
                focusedBorderColor: AppColors.primary,
                borderradius: 24,
                textColor: Colors.black,
                iconColor: Colors.grey[600]!,
                focusedIconColor: AppColors.primary,
              ),

              const Spacer(),

              // Sign In button
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: CustomButton(
                  text: 'Sign In',
                  onPressed: () {
                    Navigator.pushNamed(context, '/verification');
                  },
                  backgroundColor: AppColors.primary,
                  textColor: Colors.white,
                  height: 56,
                  borderradius: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

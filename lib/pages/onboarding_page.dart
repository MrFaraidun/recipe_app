import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../l10n/app_localizations.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height - MediaQuery.of(context).padding.top,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Image
                SizedBox(
                  height: size.height * 0.55,
                  child: Image.asset(
                    'assets/onboarding.png',
                    fit: BoxFit.contain,
                  ),
                ),

                // Texts + Button
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 80,
                  ),
                  child: Column(
                    children: [
                      Text(
                        local.translate('welcomeTitle'),
                        style: AppTextStyles.h1,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        local.translate('welcomeSubtitle'),
                        style: AppTextStyles.bodySecondary,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                        text: local.translate('getStarted'),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

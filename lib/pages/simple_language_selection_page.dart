import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../services/language_service.dart';

class SimpleLanguageSelectionPage extends StatelessWidget {
  const SimpleLanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Simple logo
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(
                  Icons.restaurant_menu,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),

              // Simple title
              Text(
                'Choose Language',
                style: AppTextStyles.h1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Simple language buttons
              _buildSimpleLanguageButton(context, 'English', 'en', '🇺🇸'),
              const SizedBox(height: 12),
              _buildSimpleLanguageButton(context, 'کوردی', 'ckb', '🇮🇶'),
              const SizedBox(height: 12),
              _buildSimpleLanguageButton(context, 'Kurdî', 'kmr', '🇹🇷'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSimpleLanguageButton(
    BuildContext context,
    String languageName,
    String languageCode,
    String flag,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _selectLanguage(context, languageCode),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.textPrimary,
          elevation: 2,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: AppColors.border),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(flag, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Text(languageName, style: AppTextStyles.h2),
          ],
        ),
      ),
    );
  }

  void _selectLanguage(BuildContext context, String languageCode) async {
    // Change the language using the language service
    final languageNotifier = Provider.of<LanguageNotifier>(
      context,
      listen: false,
    );
    await languageNotifier.setLanguage(languageCode);

    // Navigate to onboarding page
    Navigator.pushReplacementNamed(context, '/onboarding');
  }
}

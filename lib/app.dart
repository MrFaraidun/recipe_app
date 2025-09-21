import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kurdish_localization_plus/flutter_kurdish_localization.dart';
import 'package:provider/provider.dart';
import 'Layout/MainLayout.dart';
import 'pages/search/search_page.dart';
import 'pages/onboarding_page.dart';
import 'pages/login_page.dart';
import 'pages/simple_language_selection_page.dart';
import 'pages/password/password_recovery_page.dart' as pw2;
import 'pages/Verification_Page.dart';
import 'pages/camera_scan_page.dart';
import 'pages/settings_page.dart';
import 'pages/edit_profile_page.dart';
import 'pages/privacy_settings_page.dart';
import 'pages/account_settings_page.dart';
import 'pages/notifications_settings_page.dart';
import 'pages/favorites_page.dart';
import 'pages/recipe_edit_page.dart';
import 'pages/following_followers_page.dart';
import 'pages/comments_reviews_page.dart';
import 'pages/cooking_mode_page.dart';
import 'pages/shopping_list_page.dart';
import 'pages/categories_browse_page.dart';
import 'models/recipe.dart';
import 'l10n/app_localizations.dart';
import 'services/language_service.dart';

class RecipeApp extends StatefulWidget {
  const RecipeApp({super.key});

  @override
  State<RecipeApp> createState() => _RecipeAppState();
}

class _RecipeAppState extends State<RecipeApp> {
  final LanguageNotifier _languageNotifier = LanguageNotifier();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    await _languageNotifier.loadSavedLanguage();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return MaterialApp(
        home: Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Icon(
                    Icons.restaurant_menu,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF22C55E)),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Loading...',
                  style: TextStyle(fontSize: 16, color: Color(0xFF64748B)),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return ChangeNotifierProvider<LanguageNotifier>(
      create: (context) => _languageNotifier,
      child: Consumer<LanguageNotifier>(
        builder: (context, languageNotifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Recipe App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
              useMaterial3: true,
            ),
            initialRoute: '/language',
            routes: {
              '/language': (context) => const SimpleLanguageSelectionPage(),
              '/onboarding': (context) => const OnboardingPage(),
              '/login': (context) => const LoginPage(),
              '/home': (context) => const MainLayout(),
              '/search': (context) => const SearchPage(),
              '/password-recovery': (context) =>
                  const pw2.PasswordRecoveryPage(),
              '/verification': (context) => const OTPVerificationPage(),
              '/scan': (context) => const CameraScanPage(),
              // Settings Pages
              '/settings': (context) => const SettingsPage(),
              '/edit-profile': (context) => const EditProfilePage(),
              '/privacy-settings': (context) => const PrivacySettingsPage(),
              '/account-settings': (context) => const AccountSettingsPage(),
              '/notifications-settings': (context) =>
                  const NotificationsSettingsPage(),
              // Recipe Pages
              '/favorites': (context) => const FavoritesPage(),
              '/recipe-edit': (context) => RecipeEditPage(
                recipe: Recipe(
                  title: 'Sample Recipe',
                  description: 'Sample description',
                  imageUrl: 'assets/pancake.png',
                  duration: '30 mins',
                  category: 'Food',
                  ingredients: ['Ingredient 1', 'Ingredient 2'],
                  steps: ['Step 1', 'Step 2'],
                  author: 'Sample Author',
                  likes: 0,
                ),
              ),
              '/following-followers': (context) =>
                  const FollowingFollowersPage(isFollowingTab: true),
              '/comments-reviews': (context) =>
                  const CommentsReviewsPage(recipeTitle: 'Sample Recipe'),
              '/cooking-mode': (context) => CookingModePage(
                recipe: Recipe(
                  title: 'Sample Recipe',
                  description: 'Sample description',
                  imageUrl: 'assets/pancake.png',
                  duration: '30 mins',
                  category: 'Food',
                  ingredients: ['Ingredient 1', 'Ingredient 2'],
                  steps: ['Step 1', 'Step 2'],
                  author: 'Sample Author',
                  likes: 0,
                ),
              ),
              '/shopping-list': (context) => const ShoppingListPage(),
              '/categories-browse': (context) => const CategoriesBrowsePage(),
            },
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              KurdishMaterialLocalizations.delegate,
              KurdishWidgetLocalizations.delegate,
              KurdishCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ckb'),
              Locale('kmr'),
            ],
            locale: languageNotifier.locale,
          );
        },
      ),
    );
  }
}

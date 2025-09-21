import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../l10n/app_localizations.dart';
import '../widgets/recipe_card.dart';
import '../data/dummy_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔍 Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: _buildSearchBar(),
          ),

          // Quick Access Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: _buildQuickAccessButtons(),
          ),

          // 📌 Category title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              local.translate('categoryTitle'),
              style: AppTextStyles.h2.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // 🍽 Category filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildCategoryChip(local.translate('allCategories'), 'All'),
                _buildCategoryChip(local.translate('foodCategory'), 'Food'),
                _buildCategoryChip(local.translate('drinkCategory'), 'Drink'),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 🩶 Light gray separator
          Container(height: 15, color: Colors.grey[200]),

          // 📌 Tabs
          TabBar(
            indicatorColor: AppColors.primary,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            labelStyle: AppTextStyles.body.copyWith(
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: AppTextStyles.body,
            tabs: [
              Tab(text: local.translate('leftRecipes')),
              Tab(text: local.translate('rightRecipes')),
            ],
          ),

          // 📜 Tab content
          Expanded(
            child: TabBarView(
              children: [
                _buildRecipeGrid(selectedCategory),
                _buildRecipeGrid(selectedCategory),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/search');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: AppColors.textSecondary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Search recipes...',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, String key) {
    final isSelected = selectedCategory == key;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(
          label,
          style: isSelected
              ? AppTextStyles.body.copyWith(color: Colors.white)
              : AppTextStyles.body,
        ),
        selected: isSelected,
        selectedColor: AppColors.primary,
        checkmarkColor: Colors.white,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1,
          ),
        ),
        onSelected: (_) {
          setState(() => selectedCategory = key);
        },
      ),
    );
  }

  Widget _buildRecipeGrid(String category) {
    final filtered = category == 'All'
        ? dummyRecipes
        : dummyRecipes.where((r) => r.category == category).toList();

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) => RecipeCard(recipe: filtered[i], showHeart: true),
              childCount: filtered.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: kBottomNavigationBarHeight + 20),
        ),
      ],
    );
  }

  Widget _buildQuickAccessButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildQuickAccessButton(
          icon: Icons.favorite,
          label: 'Favorites',
          onTap: () => Navigator.pushNamed(context, '/favorites'),
        ),
        _buildQuickAccessButton(
          icon: Icons.shopping_cart,
          label: 'Shopping',
          onTap: () => Navigator.pushNamed(context, '/shopping-list'),
        ),
        _buildQuickAccessButton(
          icon: Icons.category,
          label: 'Browse',
          onTap: () => Navigator.pushNamed(context, '/categories-browse'),
        ),
        _buildQuickAccessButton(
          icon: Icons.settings,
          label: 'Settings',
          onTap: () => Navigator.pushNamed(context, '/settings'),
        ),
      ],
    );
  }

  Widget _buildQuickAccessButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.bodySecondary.copyWith(
                fontSize: 10,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

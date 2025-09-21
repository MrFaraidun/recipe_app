import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedCategory = 'All';

  // Sample favorite recipes
  final List<Recipe> _favoriteRecipes = [
    Recipe(
      title: 'Chocolate Pancakes',
      author: 'John Doe',
      category: 'Food',
      duration: '30 mins',
      imageUrl: 'assets/pancake.png',
    ),
    Recipe(
      title: 'Berry Smoothie',
      author: 'Jane Smith',
      category: 'Drink',
      duration: '10 mins',
      imageUrl: 'assets/pancake.png',
    ),
    Recipe(
      title: 'Pasta Carbonara',
      author: 'Mike Johnson',
      category: 'Food',
      duration: '45 mins',
      imageUrl: 'assets/pancake.png',
    ),
  ];

  final List<Recipe> _savedCollections = [
    Recipe(
      title: 'Quick Breakfast Ideas',
      author: 'Collection',
      category: 'Collection',
      duration: 'Various',
      imageUrl: 'assets/pancake.png',
    ),
    Recipe(
      title: 'Healthy Snacks',
      author: 'Collection',
      category: 'Collection',
      duration: 'Various',
      imageUrl: 'assets/pancake.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Favorites',
          style: AppTextStyles.h2.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textPrimary),
            onPressed: () => _showSearchDialog(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          labelStyle: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
          unselectedLabelStyle: AppTextStyles.body,
          tabs: const [
            Tab(text: 'Recipes'),
            Tab(text: 'Collections'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildRecipesTab(), _buildCollectionsTab()],
      ),
    );
  }

  Widget _buildRecipesTab() {
    return Column(
      children: [
        // Category Filter
        _buildCategoryFilter(),

        // Recipes Grid
        Expanded(child: _buildRecipesGrid()),
      ],
    );
  }

  Widget _buildCollectionsTab() {
    return _buildCollectionsGrid();
  }

  Widget _buildCategoryFilter() {
    final categories = ['All', 'Food', 'Drink'];

    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category;

          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(category),
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
                setState(() => _selectedCategory = category);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecipesGrid() {
    final filteredRecipes = _selectedCategory == 'All'
        ? _favoriteRecipes
        : _favoriteRecipes
              .where((r) => r.category == _selectedCategory)
              .toList();

    if (filteredRecipes.isEmpty) {
      return _buildEmptyState(
        icon: Icons.favorite_border,
        title: 'No Favorite Recipes',
        subtitle: 'Start liking recipes to see them here',
      );
    }

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) =>
                  RecipeCard(recipe: filteredRecipes[index], showHeart: true),
              childCount: filteredRecipes.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCollectionsGrid() {
    if (_savedCollections.isEmpty) {
      return _buildEmptyState(
        icon: Icons.folder_outlined,
        title: 'No Collections',
        subtitle: 'Create collections to organize your favorite recipes',
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: _savedCollections.length,
      itemBuilder: (context, index) {
        return _buildCollectionCard(_savedCollections[index]);
      },
    );
  }

  Widget _buildCollectionCard(Recipe collection) {
    return Container(
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
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset(
                collection.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  collection.title,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${_getRandomRecipeCount()} recipes',
                  style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: AppColors.textSecondary),
          const SizedBox(height: 16),
          Text(
            title,
            style: AppTextStyles.h3.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: AppTextStyles.bodySecondary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Favorites'),
        content: const Text('Search functionality coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  int _getRandomRecipeCount() {
    return (5 + (DateTime.now().millisecondsSinceEpoch % 20));
  }
}

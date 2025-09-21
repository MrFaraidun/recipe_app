import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/recipe_card.dart';
import '../widgets/category_grid.dart';
import '../widgets/filter_chips.dart';
import '../models/recipe.dart';

class CategoriesBrowsePage extends StatefulWidget {
  const CategoriesBrowsePage({super.key});

  @override
  State<CategoriesBrowsePage> createState() => _CategoriesBrowsePageState();
}

class _CategoriesBrowsePageState extends State<CategoriesBrowsePage> {
  final List<Category> _categories = [
    Category(
      name: 'Breakfast',
      icon: Icons.wb_sunny,
      color: Colors.orange,
      recipeCount: 24,
    ),
    Category(
      name: 'Lunch',
      icon: Icons.lunch_dining,
      color: Colors.green,
      recipeCount: 18,
    ),
    Category(
      name: 'Dinner',
      icon: Icons.dinner_dining,
      color: Colors.purple,
      recipeCount: 32,
    ),
    Category(
      name: 'Dessert',
      icon: Icons.cake,
      color: Colors.pink,
      recipeCount: 15,
    ),
    Category(
      name: 'Snacks',
      icon: Icons.cookie,
      color: Colors.brown,
      recipeCount: 12,
    ),
    Category(
      name: 'Drinks',
      icon: Icons.local_drink,
      color: Colors.blue,
      recipeCount: 8,
    ),
  ];

  final List<String> _filters = [
    'All',
    'Quick',
    'Healthy',
    'Vegetarian',
    'Vegan',
    'Gluten-Free',
  ];
  final List<String> _selectedFilters = ['All'];

  List<Recipe> _filteredRecipes = [];
  String _selectedCategory = '';

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  void _loadRecipes() {
    // Sample recipes - replace with actual data
    _filteredRecipes = [
      Recipe(
        title: 'Pancakes',
        description: 'Fluffy breakfast pancakes',
        imageUrl: 'assets/pancake.png',
        duration: '15 mins',
        category: 'Breakfast',
        ingredients: ['Flour', 'Eggs', 'Milk'],
        steps: ['Mix ingredients', 'Cook on pan'],
        author: 'John Doe',
        likes: 25,
      ),
      Recipe(
        title: 'Caesar Salad',
        description: 'Fresh and crispy salad',
        imageUrl: 'assets/pancake.png',
        duration: '10 mins',
        category: 'Lunch',
        ingredients: ['Lettuce', 'Croutons', 'Parmesan'],
        steps: ['Wash lettuce', 'Add toppings'],
        author: 'Jane Smith',
        likes: 18,
      ),
    ];
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
          'Browse Recipes',
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
            icon: const Icon(Icons.filter_list, color: AppColors.primary),
            onPressed: _showFilterModal,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          _buildSearchBar(),

          // Filter Chips
          FilterChips(
            filters: _filters,
            selectedFilters: _selectedFilters,
            onFilterTap: _onFilterTap,
          ),

          const SizedBox(height: 16),

          // Content
          Expanded(
            child: _selectedCategory.isEmpty
                ? _buildCategoriesView()
                : _buildRecipesView(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search recipes...',
          prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: _onSearchChanged,
      ),
    );
  }

  Widget _buildCategoriesView() {
    return CategoryGrid(categories: _categories, onCategoryTap: _onCategoryTap);
  }

  Widget _buildRecipesView() {
    if (_filteredRecipes.isEmpty) {
      return _buildEmptyState();
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _filteredRecipes.length,
      itemBuilder: (context, index) {
        return RecipeCard(recipe: _filteredRecipes[index]);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: AppColors.textSecondary),
          const SizedBox(height: 16),
          Text(
            'No Recipes Found',
            style: AppTextStyles.h3.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters or search terms',
            style: AppTextStyles.bodySecondary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _onSearchChanged(String query) {
    // Implement search functionality
  }

  void _onFilterTap(String filter) {
    setState(() {
      if (filter == 'All') {
        _selectedFilters.clear();
        _selectedFilters.add('All');
      } else {
        _selectedFilters.remove('All');
        if (_selectedFilters.contains(filter)) {
          _selectedFilters.remove(filter);
        } else {
          _selectedFilters.add(filter);
        }
        if (_selectedFilters.isEmpty) {
          _selectedFilters.add('All');
        }
      }
    });
  }

  void _onCategoryTap(Category category) {
    setState(() {
      _selectedCategory = category.name;
    });
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Filter Recipes',
              style: AppTextStyles.h3.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            // Add more filter options here
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Apply filters
              },
              child: const Text('Apply Filters'),
            ),
          ],
        ),
      ),
    );
  }
}

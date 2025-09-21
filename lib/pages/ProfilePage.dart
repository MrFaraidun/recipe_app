import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/CustomProfilePic.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';
import 'following_followers_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final myRecipes = [
    Recipe(
      title: 'Pancake',
      author: 'Faraidun',
      category: 'Food',
      duration: '>60 mins',
      imageUrl: 'assets/pancake.png',
    ),
    Recipe(
      title: 'Pancake Special',
      author: 'Faraidun',
      category: 'Food',
      duration: '>60 mins',
      imageUrl: 'assets/pancake.png',
    ),
  ];

  final likedRecipes = [
    Recipe(
      title: 'Pancake Delight',
      author: 'John Doe',
      category: 'Food',
      duration: '30 mins',
      imageUrl: 'assets/pancake.png',
    ),
    Recipe(
      title: 'Pancake Supreme',
      author: 'Jane Doe',
      category: 'Food',
      duration: '45 mins',
      imageUrl: 'assets/pancake.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
        title: const Text('My Profile', style: AppTextStyles.h2),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: AppColors.textPrimary),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          IconButton(
            icon: const Icon(Icons.share, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const CustomProfilePic(imagePath: 'assets/pancake.png'),
          const SizedBox(height: 12),
          Text('Choirul Syafril', style: AppTextStyles.h2),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStat('32', 'Recipes'),
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, '/following-followers'),
                  child: _buildStat('782', 'Following'),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const FollowingFollowersPage(isFollowingTab: false),
                    ),
                  ),
                  child: _buildStat('1.287', 'Followers'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TabBar(
            controller: _tabController,
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            labelStyle: AppTextStyles.h3,
            tabs: const [
              Tab(text: 'Recipes'),
              Tab(text: 'Liked'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildRecipeGrid(
                  myRecipes,
                  showAuthor: false,
                  showHeart: false,
                ),
                _buildRecipeGrid(
                  likedRecipes,
                  showAuthor: true,
                  showHeart: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.h2),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.bodySecondary),
      ],
    );
  }

  Widget _buildRecipeGrid(
    List<Recipe> recipes, {
    required bool showAuthor,
    required bool showHeart,
  }) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return RecipeCard(
          recipe: recipes[index],
          showAuthor: showAuthor,
          showHeart: showHeart,
        );
      },
    );
  }
}

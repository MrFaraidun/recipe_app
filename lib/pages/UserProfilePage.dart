import 'package:flutter/material.dart';
import '../components/ProfileHeader.dart';
import '../components/RecipeGrid.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../models/recipe.dart';
import '../models/user.dart';

class UserProfilePage extends StatefulWidget {
  final User user;
  final List<Recipe>? userRecipes;
  final List<Recipe>? userLikedRecipes;
  final bool isCurrentUser;
  final VoidCallback? onFollow;
  final bool isFollowing;

  const UserProfilePage({
    super.key,
    required this.user,
    this.userRecipes,
    this.userLikedRecipes,
    this.isCurrentUser = false,
    this.onFollow,
    this.isFollowing = false,
  });

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
          widget.isCurrentUser ? 'My Profile' : 'Profile',
          style: AppTextStyles.h2,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.share, color: AppColors.textPrimary),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Profile Header
          ProfileHeader(
            name: widget.user.name,
            imagePath: widget.user.imagePath,
            recipes: widget.user.recipes,
            following: widget.user.following,
            followers: widget.user.followers,
          ),

          // Follow/Edit Profile Button
          if (!widget.isCurrentUser) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: widget.onFollow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    widget.isFollowing ? 'Following' : 'Follow',
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],

          // Tabs
          TabBar(
            controller: _tabController,
            indicatorColor: AppColors.primary,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            labelStyle: AppTextStyles.body.copyWith(
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: AppTextStyles.body,
            tabs: const [
              Tab(text: "Recipes"),
              Tab(text: "Liked"),
            ],
          ),

          // Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                RecipeGrid(
                  recipes: widget.userRecipes ?? [],
                  showAuthor: false,
                  showHeart: true,
                ),
                RecipeGrid(
                  recipes: widget.userLikedRecipes ?? [],
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
}

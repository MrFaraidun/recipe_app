import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/custom_button.dart';

class FollowingFollowersPage extends StatefulWidget {
  final bool isFollowingTab;

  const FollowingFollowersPage({super.key, required this.isFollowingTab});

  @override
  State<FollowingFollowersPage> createState() => _FollowingFollowersPageState();
}

class _FollowingFollowersPageState extends State<FollowingFollowersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample data
  final List<UserData> _following = [
    UserData(
      name: 'John Doe',
      username: '@johndoe',
      imagePath: 'assets/pancake.png',
      isFollowing: true,
      isVerified: true,
    ),
    UserData(
      name: 'Jane Smith',
      username: '@janesmith',
      imagePath: 'assets/pancake.png',
      isFollowing: true,
      isVerified: false,
    ),
    UserData(
      name: 'Mike Johnson',
      username: '@mikejohnson',
      imagePath: 'assets/pancake.png',
      isFollowing: true,
      isVerified: true,
    ),
  ];

  final List<UserData> _followers = [
    UserData(
      name: 'Sarah Wilson',
      username: '@sarahwilson',
      imagePath: 'assets/pancake.png',
      isFollowing: false,
      isVerified: false,
    ),
    UserData(
      name: 'David Brown',
      username: '@davidbrown',
      imagePath: 'assets/pancake.png',
      isFollowing: true,
      isVerified: true,
    ),
    UserData(
      name: 'Lisa Davis',
      username: '@lisadavis',
      imagePath: 'assets/pancake.png',
      isFollowing: false,
      isVerified: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    if (widget.isFollowingTab) {
      _tabController.index = 0;
    } else {
      _tabController.index = 1;
    }
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
          'Social',
          style: AppTextStyles.h2.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
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
            Tab(text: 'Following'),
            Tab(text: 'Followers'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildFollowingTab(), _buildFollowersTab()],
      ),
    );
  }

  Widget _buildFollowingTab() {
    return _buildUserList(_following, isFollowingTab: true);
  }

  Widget _buildFollowersTab() {
    return _buildUserList(_followers, isFollowingTab: false);
  }

  Widget _buildUserList(List<UserData> users, {required bool isFollowingTab}) {
    if (users.isEmpty) {
      return _buildEmptyState(
        icon: isFollowingTab ? Icons.person_add : Icons.people,
        title: isFollowingTab ? 'No Following' : 'No Followers',
        subtitle: isFollowingTab
            ? 'Start following users to see them here'
            : 'No one is following you yet',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: users.length,
      itemBuilder: (context, index) {
        return _buildUserCard(users[index], isFollowingTab);
      },
    );
  }

  Widget _buildUserCard(UserData user, bool isFollowingTab) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          // Profile Picture
          Stack(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(user.imagePath),
              ),
              if (user.isVerified)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 10,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),

          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      user.name,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (user.isVerified) ...[
                      const SizedBox(width: 4),
                      Icon(Icons.verified, color: AppColors.primary, size: 16),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  user.username,
                  style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),

          // Action Button
          if (isFollowingTab)
            _buildUnfollowButton(user)
          else
            _buildFollowButton(user),
        ],
      ),
    );
  }

  Widget _buildFollowButton(UserData user) {
    return CustomButton(
      text: user.isFollowing ? 'Following' : 'Follow',
      onPressed: () => _toggleFollow(user),
      backgroundColor: user.isFollowing
          ? AppColors.primary.withOpacity(0.1)
          : AppColors.primary,
      textColor: user.isFollowing ? AppColors.primary : Colors.white,
      borderColor: user.isFollowing ? AppColors.primary : null,
      height: 32,
      borderradius: 16,
    );
  }

  Widget _buildUnfollowButton(UserData user) {
    return CustomButton(
      text: 'Unfollow',
      onPressed: () => _unfollowUser(user),
      backgroundColor: Colors.red.withOpacity(0.1),
      textColor: Colors.red,
      borderColor: Colors.red,
      height: 32,
      borderradius: 16,
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

  void _toggleFollow(UserData user) {
    setState(() {
      user.isFollowing = !user.isFollowing;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          user.isFollowing
              ? 'Now following ${user.name}'
              : 'Unfollowed ${user.name}',
        ),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              user.isFollowing = !user.isFollowing;
            });
          },
        ),
      ),
    );
  }

  void _unfollowUser(UserData user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Unfollow User'),
        content: Text('Are you sure you want to unfollow ${user.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _following.remove(user);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Unfollowed ${user.name}')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Unfollow'),
          ),
        ],
      ),
    );
  }
}

class UserData {
  final String name;
  final String username;
  final String imagePath;
  bool isFollowing;
  final bool isVerified;

  UserData({
    required this.name,
    required this.username,
    required this.imagePath,
    required this.isFollowing,
    required this.isVerified,
  });
}

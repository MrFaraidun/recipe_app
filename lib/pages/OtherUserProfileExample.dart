import 'package:flutter/material.dart';
import 'package:recipe_app/pages/UserProfilePage.dart';
import '../models/user.dart';
import '../models/recipe.dart';

class OtherUserProfileExample extends StatelessWidget {
  const OtherUserProfileExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Example user data
    final otherUser = const User(
      id: 'other_user_1',
      name: 'Qasim Syafril',
      imagePath: 'assets/pancake.png', // Using pancake.png as profile pic
      recipes: 25,
      following: 450,
      followers: 1200,
    );

    // Example recipes for the other user
    final otherUserRecipes = [
      Recipe(
        title: 'Pancake',
        author: 'Qasim Syafril',
        category: 'Food',
        duration: '>60 mins',
        imageUrl: 'assets/pancake.png',
      ),
      Recipe(
        title: 'Salad',
        author: 'Qasim Syafril',
        category: 'Food',
        duration: '>60 mins',
        imageUrl: 'assets/pancake.png', // You can add more images
      ),
    ];

    final otherUserLikedRecipes = [
      Recipe(
        title: 'Pasta',
        author: 'Another Chef',
        category: 'Food',
        duration: '30 mins',
        imageUrl: 'assets/pancake.png',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Other User Profile Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserProfilePage(
                  user: otherUser,
                  userRecipes: otherUserRecipes,
                  userLikedRecipes: otherUserLikedRecipes,
                  isCurrentUser: false,
                  isFollowing: false,
                  onFollow: () {
                    // Handle follow action
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Followed user!')),
                    );
                  },
                ),
              ),
            );
          },
          child: const Text('View Other User Profile'),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:recipe_app/pages/RecipeDetailPage.dart';
import '../models/recipe.dart';

class RecipeDetailExample extends StatelessWidget {
  const RecipeDetailExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Example recipe data
    final recipe = Recipe(
      title: 'Cacao Maca Walnut Milk',
      author: 'Elena Shelby',
      category: 'Food',
      duration: '60 mins',
      imageUrl: 'assets/pancake.png',
    );

    const description =
        'Your recipe has been uploaded, you can see it on your profile. Your recipe has been uploaded, you can see it on your profile. This delicious cacao maca walnut milk is perfect for a healthy breakfast or afternoon snack.';

    const ingredients = [
      '4 Eggs',
      '1/2 Butter',
      '1/2 Butter',
      '2 cups Walnuts',
      '1 tbsp Cacao powder',
      '1 tsp Maca powder',
      '2 cups Almond milk',
      '1 tbsp Honey',
      '1 tsp Vanilla extract',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Recipe Detail Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetailPage(
                  recipe: recipe,
                  description: description,
                  ingredients: ingredients,
                  likes: 273,
                  authorImageUrl: 'assets/pancake.png',
                ),
              ),
            );
          },
          child: const Text('View Recipe Detail'),
        ),
      ),
    );
  }
}

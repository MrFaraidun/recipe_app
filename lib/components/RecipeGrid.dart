import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';

class RecipeGrid extends StatelessWidget {
  final List<Recipe> recipes;
  final bool showAuthor;
  final bool showHeart;

  const RecipeGrid({
    super.key,
    required this.recipes,
    this.showAuthor = true,
    this.showHeart = true,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return RecipeCard(
          recipe: recipes[index],
          showHeart: showHeart,
          showAuthor: showAuthor,
        );
      },
    );
  }
}

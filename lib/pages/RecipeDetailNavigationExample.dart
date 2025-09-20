import 'package:flutter/material.dart';
import 'package:recipe_app/pages/SimpleRecipeDetailPage.dart';
import '../models/recipe.dart';

class RecipeDetailNavigationExample extends StatelessWidget {
  const RecipeDetailNavigationExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Example recipe with full details
    final detailedRecipe = Recipe(
      title: 'Cacao Maca Walnut Milk',
      author: 'Madam Qasim',
      category: 'Food',
      duration: '60 mins',
      imageUrl: 'assets/pancake.png',
      description:
          'Your recipe has been uploaded, you can see it on your profile. This delicious cacao maca walnut milk is perfect for a healthy breakfast or afternoon snack.',
      ingredients: [
        '4 Eggs',
        '1/2 Butter',
        '2 cups Walnuts',
        '1 tbsp Cacao powder',
        '1 tsp Maca powder',
        '2 cups Almond milk',
        '1 tbsp Honey',
        '1 tsp Vanilla extract',
      ],
      steps: [
        'First, gather all your ingredients and prepare your workspace.',
        'In a large bowl, whisk together the eggs until they are well combined.',
        'Add the butter and mix until smooth and creamy.',
        'Gradually add the cacao powder and maca powder, stirring continuously.',
        'Slowly pour in the almond milk while whisking to prevent lumps.',
        'Add honey and vanilla extract, then mix until everything is well incorporated.',
        'Let the mixture rest for 10 minutes to allow flavors to meld.',
        'Serve immediately or store in the refrigerator for up to 3 days.',
      ],
      likes: 273,
      authorImageUrl: 'assets/pancake.png',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Recipe Detail Navigation')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Recipe card preview
            Container(
              width: 200,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    Image.asset(
                      detailedRecipe.imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.8),
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              detailedRecipe.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${detailedRecipe.category} • ${detailedRecipe.duration}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SimpleRecipeDetailPage(recipe: detailedRecipe),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
              child: const Text('View Recipe Details'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tap the button to see the full recipe detail page!',
              style: TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

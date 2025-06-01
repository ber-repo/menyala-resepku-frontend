import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../provider/recipe_provider.dart'; // Ensure this path is correct
import 'widgets/recipe_detail_screen.dart';

class AllRecipesScreen extends StatelessWidget {
  final List<Recipe> recipes; // Define the recipes parameter

  const AllRecipesScreen({super.key, required this.recipes}); // Constructor with required parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semua Resep'),
      ),
      body: recipes.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: recipes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  return _buildRecipeCard(context, recipe);
                },
              ),
            )
          : const Center(child: Text("Tidak ada resep yang ditemukan.")),
    );
  }

  GestureDetector _buildRecipeCard(BuildContext context, Recipe recipe) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(recipe: recipe),
          ),
        );
      },
      child: Card(
        elevation: 4,
        color: Colors.deepPurple.shade50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: recipe.imageUrl.isNotEmpty
                  ? Image.network(recipe.imageUrl, height: 100, fit: BoxFit.cover)
                  : Container(
                      height: 100,
                      color: Colors.grey,
                      alignment: Alignment.center,
                      child: const Text('No Image Available', style: TextStyle(color: Colors.white)),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                recipe.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "${recipe.calories} Kcal • ${recipe.cookTime} min",
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../widgets/food_recipe_placeholder_card_material_page.dart';

class FoodRecipeCategoryDetailMaterialPage extends StatefulWidget {
  final List<Map<String, dynamic>> recipes;
  final String category;
  final List<bool> favorites;
  final void Function(int) onFavoriteToggle;

  const FoodRecipeCategoryDetailMaterialPage({
    super.key,
    required this.recipes,
    required this.category,
    required this.favorites,
    required this.onFavoriteToggle,
  });

  @override
  State<FoodRecipeCategoryDetailMaterialPage> createState() =>
      _FoodRecipeCategoryDetailMaterialPageState();
}

class _FoodRecipeCategoryDetailMaterialPageState
    extends State<FoodRecipeCategoryDetailMaterialPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final categoryRecipes = widget.recipes
        .where((recipe) => recipe['category']?['name'] == widget.category)
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.category,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.04),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount;
                    if (constraints.maxWidth > 900) {
                      crossAxisCount = 4;
                    } else if (constraints.maxWidth > 600) {
                      crossAxisCount = 3;
                    } else {
                      crossAxisCount = 2;
                    }
                    return GridView.builder(
                      itemCount: categoryRecipes.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        final recipe = categoryRecipes[index];
                        final originalIndex = widget.recipes.indexOf(recipe);
                        return FoodRecipePlaceholderCardMaterialPage(
                          recipe: recipe,
                          isFavorite: recipe['isFavorite'],
                          onFavoriteToggle: () =>
                              widget.onFavoriteToggle(originalIndex),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

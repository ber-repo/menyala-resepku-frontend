import 'package:flutter/material.dart';
import '../repositories/recipe_repository.dart';
import 'food_recipe_category_detail_material_page.dart';

class FoodRecipeCategoryMaterialPage extends StatefulWidget {
  const FoodRecipeCategoryMaterialPage({super.key});

  @override
  State<FoodRecipeCategoryMaterialPage> createState() => _FoodRecipeCategoryMaterialPageState();
}

class _FoodRecipeCategoryMaterialPageState extends State<FoodRecipeCategoryMaterialPage> {
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategoriesFromRepo();
  }

  Future<void> fetchCategoriesFromRepo() async {
    categories = await fetchCategories();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.01),
          child: Text(
            'Categories',
            style: TextStyle(
              fontSize: screenWidth * 0.055,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              title: Text(
                categories[index],
                style: TextStyle(fontSize: screenWidth * 0.045),
              ),
              onTap: () async {
                final recipes = await fetchRecipesByCategory(categories[index]);
                if (!mounted) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodRecipeCategoryDetailMaterialPage(
                      recipes: recipes,
                      category: categories[index],
                      favorites: recipes.map((r) => r['isFavorite'] as bool? ?? false).toList(),
                      onFavoriteToggle: (recipeIndex) async {
                        await setRecipeFavorite(
                          int.parse(recipes[recipeIndex]['id'].toString()),
                          !(recipes[recipeIndex]['isFavorite'] ?? false),
                        );
                        final updatedRecipes = await fetchRecipesByCategory(categories[index]);
                        setState(() {
                          recipes.clear();
                          recipes.addAll(updatedRecipes);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

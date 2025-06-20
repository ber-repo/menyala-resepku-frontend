import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../repositories/recipe_repository.dart';
import '../widgets/food_recipe_placeholder_card_material_page.dart';
import 'food_recipe_recipe_detail_page.dart';

class FoodRecipeFavoriteMaterialPage extends StatefulWidget {
  const FoodRecipeFavoriteMaterialPage({super.key});

  @override
  State<FoodRecipeFavoriteMaterialPage> createState() => _FoodRecipeFavoriteMaterialPageState();
}

class _FoodRecipeFavoriteMaterialPageState extends State<FoodRecipeFavoriteMaterialPage> {
  List<Map<String, dynamic>> favoriteRecipes = [];

  @override
  void initState() {
    super.initState();
    fetchFavoriteRecipes();
  }

  Future<void> fetchFavoriteRecipes() async {
    final HttpLink httpLink = HttpLink('http://10.0.2.2:8080/graphql');
    final GraphQLClient client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );
    const String query = r'''
      query {
        allRecipe {
          id
          recipeName
          isFavorite
          images { downloadUrl }
        }
      }
    ''';
    final result = await client.query(QueryOptions(document: gql(query)));
    if (!result.hasException) {
      setState(() {
        favoriteRecipes = (result.data?['allRecipe'] as List)
            .where((r) => r['isFavorite'] == true)
            .map((e) => e as Map<String, dynamic>)
            .toList();
      });
    }
  }

  Future<void> onFavoriteToggle(int index) async {
    final recipe = favoriteRecipes[index];
    final newValue = !(recipe['isFavorite'] == true);
    await setRecipeFavorite(int.parse(recipe['id'].toString()), newValue);
    await fetchFavoriteRecipes(); 
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Favorites",
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
                      itemCount: favoriteRecipes.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        final recipe = favoriteRecipes[index];
                        return GestureDetector(
                          onTap: () async {
                            final recipeId = recipe['id'];
                            final recipeDetail = await fetchRecipeById(recipeId);
                            if (!mounted) return;
                            if (recipeDetail != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FoodRecipeRecipeDetailPageMaterialPage(recipe: recipeDetail),
                                ),
                              );
                            }
                          },
                          child: FoodRecipePlaceholderCardMaterialPage(
                            recipe: recipe,
                            isFavorite: recipe['isFavorite'],
                            onFavoriteToggle: () => onFavoriteToggle(index),
                          ),
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

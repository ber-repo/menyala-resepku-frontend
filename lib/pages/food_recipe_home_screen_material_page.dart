import 'package:flutter/material.dart';
import '../widgets/food_recipe_placeholder_card_material_page.dart';
import 'food_recipe_recipe_detail_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:frontend/repositories/recipe_repository.dart';

class FoodRecipeHomeScreenMaterialPage extends StatefulWidget {
  const FoodRecipeHomeScreenMaterialPage({super.key});

  @override
  State<FoodRecipeHomeScreenMaterialPage> createState() =>
      _FoodRecipeHomeScreenMaterialPageState();
}

class _FoodRecipeHomeScreenMaterialPageState
    extends State<FoodRecipeHomeScreenMaterialPage> {
  List<Map<String, dynamic>> recipes = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    final HttpLink httpLink = HttpLink('http://10.0.2.2:8080/graphql');
    final GraphQLClient client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );
    const String queryStr = r'''
      query {
        allRecipe {
          id
          recipeName
          recipeDescription
          isFavorite
          category { name }
          images { downloadUrl }
          ingredients { ingredientName }
          steps { stepDescription }
        }
      }
    ''';
    final result = await client.query(QueryOptions(document: gql(queryStr)));
    if (!result.hasException) {
      setState(() {
        recipes = (result.data?['allRecipe'] as List)
            .map((e) => e as Map<String, dynamic>)
            .toList();
      });
    }
  }

  void onFavoriteToggle(int index) async {
    final recipe = recipes[index];
    final newValue = !(recipe['isFavorite'] == true);
    await setRecipeFavorite(int.parse(recipe['id'].toString()), newValue);
    await fetchRecipes(); 
  }

  List<Map<String, dynamic>> get filteredRecipes {
    if (query.isEmpty) {
      return recipes;
    }
    return recipes.where((recipe) {
      return recipe['recipeName'].toLowerCase().contains(query.toLowerCase()) ||
          (recipe['ingredients'] as List)
              .any((ingredient) => (ingredient['ingredientName'] as String)
                  .toLowerCase()
                  .contains(query.toLowerCase()));
    }).toList();
  }

  void onQueryChanged(String newQuery) {
    setState(() {
      query = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final recipesToShow = filteredRecipes;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Search",
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
              SizedBox(height: screenHeight * 0.032),
              const Text(
                "What is in your kitchen?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: screenHeight * 0.0004),
              const Text("Enter some ingredients"),
              SizedBox(height: screenHeight * 0.024),
              TextField(
                onChanged: onQueryChanged,
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              SizedBox(height: screenHeight * 0.016),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                    return GridView.builder(
                      itemCount: recipesToShow.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        final recipe = recipesToShow[index];
                        final originalIndex = recipes.indexOf(recipe);
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
                            onFavoriteToggle: () => onFavoriteToggle(originalIndex),
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

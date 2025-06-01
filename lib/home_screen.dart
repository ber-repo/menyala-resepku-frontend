import 'package:flutter/material.dart';
import 'models/recipe.dart'; 
import 'food_recipe_login_material_page.dart'; 
import 'package:shared_preferences/shared_preferences.dart'; 
import 'widgets/recipe_detail_screen.dart'; 
import 'all_recipes_screen.dart'; 

class HomeScreen extends StatefulWidget {
  final List<Recipe> allRecipes; // Ensure this is defined
  final String username;

  const HomeScreen({super.key, required this.allRecipes, required this.username});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _username;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _username = widget.username; // Initialize the username
  }

  void _navigateToAllRecipes() {
    // When navigating, pass the right parameter
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AllRecipesScreen(recipes: widget.allRecipes), // Pass the list of recipes
      ),
    ).then((updatedRecipes) {
      if (updatedRecipes != null) {
        setState(() {
          // Assume updatedRecipes is of type List<Recipe>
          widget.allRecipes.clear();
          widget.allRecipes.addAll(updatedRecipes);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredRecipes = widget.allRecipes.where((recipe) =>
      recipe.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(
        title: const Text('Selamat Datang di Aplikasi Resep'),
        actions: [_buildPopupMenu()],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Temukan Resep Terbaik untuk Hidangan Anda', style: TextStyle(fontSize: 16, color: Colors.black54)),
              const SizedBox(height: 16),
              _buildSearchField(),
              const SizedBox(height: 10),
              const Text('Hasil Pencarian', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Expanded(
                child: filteredRecipes.isNotEmpty
                    ? GridView.builder(
                        itemCount: filteredRecipes.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          final recipe = filteredRecipes[index];
                          return _buildRecipeCard(recipe);
                        },
                      )
                    : const Center(child: Text("Tidak ada resep yang ditemukan.")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuButton<String> _buildPopupMenu() {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.account_circle),
      itemBuilder: (context) {
        return [
          PopupMenuItem<String>(
            value: 'profile',
            child: ListTile(title: Text("Username: $_username")),
          ),
          PopupMenuItem<String>(
            value: 'logout',
            child: ListTile(
              title: const Text("Logout"),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const FoodRecipeLoginMaterialPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ),
          PopupMenuItem<String>(
            value: 'all_recipes',
            child: ListTile(
              title: const Text("All Recipes"),
              onTap: _navigateToAllRecipes, // Navigate to AllRecipesScreen
            ),
          ),
        ];
      },
    );
  }

  TextField _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Cari resep...',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        prefixIcon: const Icon(Icons.search),
      ),
      onChanged: (value) {
        setState(() {
          _searchQuery = value;
        });
      },
    );
  }

  GestureDetector _buildRecipeCard(Recipe recipe) {
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
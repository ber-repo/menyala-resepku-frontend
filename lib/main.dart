import 'package:flutter/material.dart';
// //import 'package:frontend/models/recipe_model.dart';
// import 'food_recipe_login_material_page.dart';
// import 'food_recipe_signup_material_page.dart';
import 'pages/food_recipe_favorite_material_page.dart';
import 'pages/food_recipe_add_recipe_material_page.dart';
import 'pages/food_recipe_category_material_page.dart';
import 'pages/food_recipe_home_screen_material_page.dart';
import 'pages/food_recipe_login_create_material_page.dart';
// import 'food_recipe_ingredient_steps_material_page.dart';
// import './pages/food_recipe_recipe_detail_page.dart';
// import 'pages/food_recipe_category_detail_material_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menyala Resepku',
      // theme: ThemeData(
      //   fontFamily: 'PoetsenOne',
      // ),
      // Mulai dari login screen
      home: const FoodRecipeLoginCreateMaterialPage(),
    );
  }
}

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const FoodRecipeHomeScreenMaterialPage(),
      const FoodRecipeCategoryMaterialPage(),
      const FoodRecipeFavoriteMaterialPage(),
      const FoodRecipeAddRecipeMaterialPage(),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Recipe',
          ),
        ],
      ),
    );
  }
}

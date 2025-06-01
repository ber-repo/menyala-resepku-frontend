import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeProvider with ChangeNotifier {
  // Private list to store recipes
  final List<Recipe> _recipes = [];

  // Getter to access the recipes
  List<Recipe> get recipes => _recipes;

  // Method to add a new recipe
  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
    notifyListeners(); // Notify listeners to update UI
  }

  // Optional: Method to remove a recipe
  void removeRecipe(Recipe recipe) {
    _recipes.remove(recipe);
    notifyListeners();
  }
  
  // Optional: Method to clear all recipes
  void clearRecipes() {
    _recipes.clear();
    notifyListeners();
  }
}
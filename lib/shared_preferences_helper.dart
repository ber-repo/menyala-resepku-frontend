import 'dart:convert'; // Ensure this is used for JSON encoding/decoding
import 'package:shared_preferences/shared_preferences.dart';
import 'models/recipe.dart';

class SharedPreferencesHelper {
  static const String _recipesKey = 'recipes';

  // Save recipes to local storage
  Future<void> saveRecipes(List<Recipe> recipes) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> recipesJson = recipes.map((recipe) => jsonEncode(recipe.toJson())).toList();
      await prefs.setStringList(_recipesKey, recipesJson);
    } catch (e) {
      print('Error saving recipes: $e');
    }
  }

  // Load recipes from local storage
  Future<List<Recipe>> loadRecipes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? recipesJson = prefs.getStringList(_recipesKey);
      if (recipesJson == null) {
        return [];
      }
      return recipesJson.map((recipe) => Recipe.fromJson(jsonDecode(recipe))).toList();
    } catch (e) {
      print('Error loading recipes: $e');
      return [];
    }
  }

  // Clear all saved recipes
  Future<void> clearRecipes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_recipesKey);
    } catch (e) {
      print('Error clearing recipes: $e');
    }
  }
}
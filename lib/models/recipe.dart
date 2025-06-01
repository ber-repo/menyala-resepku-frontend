import 'dart:convert'; // Ensure this is used for JSON encoding/decoding

class Recipe {
  final String name;
  final String category;
  final String description;
  final String ingredients;
  final String instructions;
  final String imageUrl;    // Property for image URL
  final int calories;       // Property for calories
  final int cookTime;       // Property for cook time

  Recipe({
    required this.name,
    required this.category,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.imageUrl,   // Include this property in constructor
    required this.calories,    // Include this property in constructor
    required this.cookTime,    // Include this property in constructor
  });

  // Getter to return a valid image URL or a placeholder
  String get displayImageUrl {
    return imageUrl.isNotEmpty ? imageUrl : 'assets/images/default_image.png'; // Path to your default image
  }

  // Convert Recipe object to a map (for JSON encoding)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'description': description,
      'ingredients': ingredients,
      'instructions': instructions,
      'imageUrl': displayImageUrl,    // Use the getter for JSON
      'calories': calories,             // Include this property in JSON
      'cookTime': cookTime,             // Include this property in JSON
    };
  }

  // Create a Recipe object from a map (for JSON decoding)
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      category: json['category'],
      description: json['description'],
      ingredients: json['ingredients'],
      instructions: json['instructions'],
      imageUrl: json['imageUrl'],  // Decode this property
      calories: json['calories'],    // Decode this property
      cookTime: json['cookTime'],    // Decode this property
    );
  }
}
import 'package:flutter/material.dart';

class FoodRecipeRecipeDetailPageMaterialPage extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const FoodRecipeRecipeDetailPageMaterialPage(
      {super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: (recipe['images'] != null &&
                      recipe['images'] is List &&
                      recipe['images'].isNotEmpty &&
                      recipe['images'][0]['downloadUrl'] != null)
                  ? Image.network(
                      recipe['images'][0]['downloadUrl'],
                      height: 250,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/mie-goreng-sayur.jpg',
                          height: 250,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      'assets/images/mie-goreng-sayur.jpg',
                      height: 250,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(height: 20),
            // Recipe Name
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  recipe['recipeName'] ?? 'No Name',
                  style:
                      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // category
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        recipe['category']?['name'] ?? 'No category',
                        style: const TextStyle(fontSize: 12, color: Colors.orange),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Ingredients
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                child: const Text(
                  'Ingredients',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              constraints: const BoxConstraints(maxHeight: 120),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var ingredient in recipe['ingredients'] ?? [])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          '• ${ingredient['ingredientName'] ?? ''}', 
                          style: const TextStyle(fontSize: 14)
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Steps
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                child: const Text(
                  'Steps',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              constraints: const BoxConstraints(maxHeight: 150),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: SingleChildScrollView(
                primary: false, 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var step in recipe['steps'] ?? [])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          step['stepDescription'] ?? '', 
                          style: const TextStyle(fontSize: 14)
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20), 
          ],
        ),
      ),
    );
  }
}
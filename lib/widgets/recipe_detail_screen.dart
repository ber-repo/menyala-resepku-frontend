import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    // Split instructions into a list based on a separator (e.g., comma)
    final List<String> instructionsList = recipe.instructions.split(', ');

    return Scaffold(
      appBar: AppBar(title: Text(recipe.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                recipe.imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Replace with your default image or a placeholder
                  return Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[300], // Placeholder color
                    alignment: Alignment.center,
                    child: const Text(
                      'No Image Available',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(recipe.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(recipe.category, style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.local_fire_department, size: 20),
                const SizedBox(width: 4),
                Text('${recipe.calories} kcal'),
                const SizedBox(width: 16),
                const Icon(Icons.timer, size: 20),
                const SizedBox(width: 4),
                Text('${recipe.cookTime} mins'),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            Text(recipe.description),
            const SizedBox(height: 16),
            const Text('Ingredients', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            Text(recipe.ingredients),
            const SizedBox(height: 16),
            const Text('Instructions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            _buildInstructionsList(instructionsList),
          ],
        ),
      ),
    );
  }

  // Method to build a numbered list of instructions
  Widget _buildInstructionsList(List<String> instructions) {
    return Column(
      children: List.generate(instructions.length, (index) {
        return Text('${index + 1}. ${instructions[index]}');
      }),
    );
  }
}
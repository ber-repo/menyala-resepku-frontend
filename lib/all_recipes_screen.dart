import 'package:flutter/material.dart';
import 'home_screen.dart'; // Gunakan PlaceholderCard dari sini

class AllRecipesScreen extends StatelessWidget {
  final List<bool> favorites;
  final void Function(int) onFavoriteToggle;

  const AllRecipesScreen({
    super.key,
    required this.favorites,
    required this.onFavoriteToggle,
  });

//body nya
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'All Recipes',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                    return GridView.builder(
                      itemCount: favorites.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        return PlaceholderCard( //placeholder card dipanggil dan ditaruh disini
                          isFavorite: favorites[index],
                          onFavoriteToggle: () => onFavoriteToggle(index),
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

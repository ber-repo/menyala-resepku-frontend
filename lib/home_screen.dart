import 'package:flutter/material.dart'; //import material

class HomeScreen extends StatelessWidget {
  final List<bool> favorites;
  final void Function(int) onFavoriteToggle;

  const HomeScreen({
    super.key,
    required this.favorites,
    required this.onFavoriteToggle,
  });
//favorites --> hati merah di placeholder card

  @override
  Widget build(BuildContext context) {
    final visibleCount = favorites.length >= 10 ? 10 : favorites.length; // jumlah placeholder card di homescreen

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100, //body nya 
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Search",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                "What is in your kitchen?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              const Text("Enter some ingredients"),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Type your ingredients',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;

                    return GridView.builder(
                      itemCount: visibleCount,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        return PlaceholderCard( //placeholdercard
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

//class buat placeholder card biar bisa dipanggil di layar lain
class PlaceholderCard extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const PlaceholderCard({
    super.key,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.deepPurple.shade50,
      shadowColor: Colors.deepPurple.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              color: Colors.deepPurple.shade300,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: onFavoriteToggle,
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Recipe Title",
              style: TextStyle(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text("000 Kcal • 00 min"),
          )
        ],
      ),
    );
  }
}

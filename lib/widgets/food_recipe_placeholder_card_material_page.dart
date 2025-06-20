import 'package:flutter/material.dart';

class FoodRecipePlaceholderCardMaterialPage extends StatefulWidget {
  final Map<String, dynamic> recipe;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const FoodRecipePlaceholderCardMaterialPage({
    super.key,
    required this.recipe,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  State<FoodRecipePlaceholderCardMaterialPage> createState() =>
      _FoodRecipePlaceholderCardMaterialPageState();
}

class _FoodRecipePlaceholderCardMaterialPageState
    extends State<FoodRecipePlaceholderCardMaterialPage> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: const Color.fromARGB(255, 255, 255, 255),
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Container
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                color: Colors.grey[300],
              ),
              child: Stack(
                children: [
                  // Placeholder untuk gambar
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(16)),
                      color: Colors.grey[300],
                    ),
                    child: widget.recipe['images'] != null &&
                            widget.recipe['images'].isNotEmpty &&
                            widget.recipe['images'][0]['downloadUrl'] != null
                        ? ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16)),
                            child: Image.network(
                              widget.recipe['images'][0]['downloadUrl'],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[300],
                                  child: Icon(
                                    Icons.restaurant,
                                    size: 40,
                                    color: Colors.grey[600],
                                  ),
                                );
                              },
                            ),
                          )
                        : Icon(
                            Icons.restaurant,
                            size: 40,
                            color: Colors.grey[600],
                          ),
                  ),
                  // Favorite Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Color(0x4D000000),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          widget.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: widget.isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: widget.onFavoriteToggle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Content
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Recipe Name
                  Text(
                    widget.recipe['recipeName'] ?? 'Unknown Recipe',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

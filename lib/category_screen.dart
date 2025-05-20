import 'package:flutter/material.dart';
import 'data.dart'; // import category umum yang ada dari awal 

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  void _showAddCategoryDialog() {
    final TextEditingController _newCategoryController = TextEditingController();

//fungsi add category
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add New Category'),
        content: TextField(
          controller: _newCategoryController,
          decoration: const InputDecoration(hintText: 'Enter category name'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newCat = _newCategoryController.text.trim();
              if (newCat.isNotEmpty && !categories.contains(newCat)) {
                setState(() {
                  categories.add(newCat);
                });
              }
              Navigator.of(ctx).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
// body
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9FF),
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade100,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddCategoryDialog,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              title: Text(categories[index]),
            ),
          );
        },
      ),
    );
  }
}

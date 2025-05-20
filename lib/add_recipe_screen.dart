import 'package:flutter/material.dart';
import 'data.dart'; // untuk ketika add recipe mau masukin ke category yang sudah ada

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}
//add recipe
class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();

  String? _selectedCategory;

//sub,it
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newRecipe = {
        'name': _nameController.text,
        'category': _selectedCategory ?? '',
        'description': _descriptionController.text,
        'ingredients': _ingredientsController.text,
        'instructions': _instructionsController.text,
      };

      print('New recipe added: $newRecipe');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recipe added!')),
      );

      // Kosongkan form
      _formKey.currentState!.reset();
      setState(() {
        _selectedCategory = null;
      });
    }
  }

// body
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF5FF), // Soft lavender background
      appBar: AppBar(
        title: const Text('New Recipe'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade100,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Fill the New Recipe',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildTextField(_nameController, 'Name'),
                  const SizedBox(height: 12),
                  _buildCategoryDropdown(),
                  const SizedBox(height: 12),
                  _buildTextField(_descriptionController, 'Description'),
                  const SizedBox(height: 12),
                  _buildTextField(_ingredientsController, 'Ingredients'),
                  const SizedBox(height: 12),
                  _buildTextField(_instructionsController, 'Instructions'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.deepPurple.shade100,
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label.toUpperCase(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

//dropdown di bagian category
  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCategory,
      decoration: InputDecoration(
        labelText: 'CATEGORY',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      items: categories.map((cat) {
        return DropdownMenuItem(
          value: cat,
          child: Text(cat),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedCategory = value;
        });
      },
      validator: (value) =>
          value == null || value.isEmpty ? 'Please select a category' : null,
    );
  }
}

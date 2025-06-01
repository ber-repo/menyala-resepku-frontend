import 'package:flutter/material.dart';
import 'models/recipe.dart';
import 'data.dart';

class AddRecipeScreen extends StatefulWidget {
  final void Function(Recipe) onAddRecipe;

  const AddRecipeScreen({
    super.key,
    required this.onAddRecipe,
  });

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ingredientController = TextEditingController();
  final TextEditingController _instructionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _cookTimeController = TextEditingController();

  String? _selectedCategory;
  final List<String> _ingredients = [];
  final List<String> _instructions = [];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newRecipe = Recipe(
        name: _nameController.text,
        category: _selectedCategory ?? 'Uncategorized',
        description: _descriptionController.text,
        ingredients: _ingredients.join(', '), // Join the list into a string
        instructions: _instructions.join(', '), // Join the list into a string
        imageUrl: _imageUrlController.text, // Use the image URL input
        calories: int.tryParse(_caloriesController.text) ?? 0, // Use calories input
        cookTime: int.tryParse(_cookTimeController.text) ?? 0,   // Use cook time input
      );

      widget.onAddRecipe(newRecipe);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recipe added!')),
      );

      // Clear form after submitting
      _formKey.currentState!.reset();
      setState(() {
        _selectedCategory = null;
        _ingredients.clear();
        _instructions.clear();
        _imageUrlController.clear();
        _caloriesController.clear();
        _cookTimeController.clear();
      });
    }
  }

  void _addIngredient() {
    if (_ingredientController.text.isNotEmpty) {
      setState(() {
        _ingredients.add(_ingredientController.text);
        _ingredientController.clear();
      });
    }
  }

  void _addInstruction() {
    if (_instructionController.text.isNotEmpty) {
      setState(() {
        _instructions.add(_instructionController.text);
        _instructionController.clear();
      });
    }
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  void _removeInstruction(int index) {
    setState(() {
      _instructions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF5FF),
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
                  _buildIngredientInputField(),
                  _buildIngredientList(),
                  const SizedBox(height: 12),
                  _buildInstructionInputField(),
                  _buildInstructionList(),
                  const SizedBox(height: 12),
                  _buildTextField(_imageUrlController, 'Image URL (optional)'),
                  const SizedBox(height: 12),
                  _buildTextField(_caloriesController, 'Calories (optional, e.g. 200)'),
                  const SizedBox(height: 12),
                  _buildTextField(_cookTimeController, 'Cook Time (optional, e.g. 30)'),
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
        if (label != 'Image URL (optional)' && label != 'Calories (optional, e.g. 200)' && label != 'Cook Time (optional, e.g. 30)' &&
            (value == null || value.isEmpty)) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

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
      validator: (value) => value == null ? 'Please select a category' : null,
    );
  }

  Widget _buildIngredientInputField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _ingredientController,
            decoration: const InputDecoration(
              labelText: 'Add Ingredient',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _addIngredient,
        ),
      ],
    );
  }

  Widget _buildIngredientList() {
    return Column(
      children: _ingredients.map((ingredient) {
        int index = _ingredients.indexOf(ingredient);
        return ListTile(
          title: Text(ingredient),
          trailing: IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () => _removeIngredient(index),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInstructionInputField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _instructionController,
            decoration: const InputDecoration(
              labelText: 'Add Instruction',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _addInstruction,
        ),
      ],
    );
  }

  Widget _buildInstructionList() {
    return Column(
      children: _instructions.map((instruction) {
        int index = _instructions.indexOf(instruction);
        return ListTile(
          title: Text(instruction),
          trailing: IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () => _removeInstruction(index),
          ),
        );
      }).toList(),
    );
  }
}
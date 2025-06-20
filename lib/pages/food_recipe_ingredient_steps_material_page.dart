import 'package:flutter/material.dart';
import '../main.dart';
//import 'food_recipe_add_recipe_material_page.dart';
import 'package:frontend/repositories/recipe_repository.dart';
//import 'food_recipe_home_screen_material_page.dart';

class FoodRecipeIngredientStepsMaterialPage extends StatefulWidget {
  final int recipeId;
  const FoodRecipeIngredientStepsMaterialPage({super.key, required this.recipeId});

  @override
  State<FoodRecipeIngredientStepsMaterialPage> createState() =>
      _FoodRecipeIngredientStepsMaterialPageState();
}

class _FoodRecipeIngredientStepsMaterialPageState
    extends State<FoodRecipeIngredientStepsMaterialPage> {
  final List<TextEditingController> _ingredientControllers = [];
  final TextEditingController _stepController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addIngredientField();
    _addIngredientField();
  }

  void _addIngredientField() {
    setState(() {
      _ingredientControllers.add(TextEditingController());
    });
  }

  void _removeIngredientField(int index) {
    setState(() {
      _ingredientControllers[index].dispose();
      _ingredientControllers.removeAt(index);
    });
  }

  @override
  void dispose() {
    for (var controller in _ingredientControllers) {
      controller.dispose();
    }
    _stepController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> submitIngredientsAndSteps() async {
    // Submit ingredients
    for (final controller in _ingredientControllers) {
      final ingredient = controller.text.trim();
      if (ingredient.isNotEmpty) {
        await addIngredient(ingredient, widget.recipeId);
      }
    }
    // Submit step
    final step = _stepController.text.trim();
    if (step.isNotEmpty) {
      await addStep(step, widget.recipeId);
    }
    // Submit category
    final category = _categoryController.text.trim();
    if (category.isNotEmpty) {
      await setRecipeCategory(category, widget.recipeId);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ingredients, step, and category berhasil disimpan!')),
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const MainAppScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Ingredients
            SizedBox(height: screenHeight * 0.08), 
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.02, left: screenWidth * 0.04),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Ingredients',
                  style: TextStyle(
                      fontSize: screenWidth * 0.045, 
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.021),
            SizedBox(
              height: screenHeight * 0.2,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _ingredientControllers.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _ingredientControllers[index],
                                decoration: InputDecoration(
                                  hintText: 'Enter ingredient',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.09),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.025,
                                    horizontal: screenWidth * 0.04,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.015),
                            IconButton(
                              onPressed: () => _removeIngredientField(index),
                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.06),
                  ),
                  minimumSize: Size(screenWidth * 0.90,
                      screenHeight * 0.07 
                      )),
              onPressed: _addIngredientField,
              child: Text(
                '+ Ingredient',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.04, 
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.045),
            //Step
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.02, left: screenWidth * 0.04),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Steps',
                  style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.025),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: TextField(
                controller: _stepController,
                textAlignVertical: TextAlignVertical.top,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Enter Steps',
                  alignLabelWithHint: true,
                  contentPadding: EdgeInsets.only(
                      top: screenHeight * 0.032,
                      left: screenWidth * 0.03,
                      right: screenWidth * 0.03),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.015),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: TextField(
                controller: _categoryController,
                decoration: InputDecoration(
                  hintText: 'Enter category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.025,
                      horizontal: screenWidth * 0.04),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            //Button next and done
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.065,
                  vertical: screenHeight * 0.015),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tombol Done di kanan
                  SizedBox(
                    width: 355,
                    height: 60,
                    child: TextButton(
                      onPressed: () async {
                        await submitIngredientsAndSteps();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFFFED477),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.08),
                        ),
                      ),
                      child: Text(
                        "Done",
                        style: TextStyle(fontSize: screenWidth * 0.04),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
          ],
        ),
      ),
    );
  }
}

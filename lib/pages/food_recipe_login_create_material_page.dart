import 'package:flutter/material.dart';
import 'food_recipe_login_material_page.dart';
import 'food_recipe_signup_material_page.dart';

class FoodRecipeLoginCreateMaterialPage extends StatefulWidget {
  const FoodRecipeLoginCreateMaterialPage({super.key});

  @override
  State<FoodRecipeLoginCreateMaterialPage> createState() =>
      _FoodRecipeLoginCreateMaterialPageState();
}

class _FoodRecipeLoginCreateMaterialPageState
    extends State<FoodRecipeLoginCreateMaterialPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0), 
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.55), 
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Text(
                          "Help your path to health goals with happiness",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 3
                              ..color = Colors.black,
                          ),
                        ),
                        const Text(
                          "Help your path to health goals with happiness",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFED477),
                        minimumSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const FoodRecipeLoginMaterialPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const FoodRecipeSignupMaterialPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Create New Account',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

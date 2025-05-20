import 'package:flutter/material.dart';
import 'package:frontend/food_recipe_login_material_page.dart';

void main(){
  runApp(const MyApp());
}


class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      home: FoodRecipeLoginMaterialPage()
    );
  }
}
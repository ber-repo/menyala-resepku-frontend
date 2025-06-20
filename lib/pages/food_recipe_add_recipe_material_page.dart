import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'food_recipe_ingredient_steps_material_page.dart';
import 'package:frontend/repositories/image_repository.dart';
import 'package:frontend/repositories/recipe_repository.dart';

class FoodRecipeAddRecipeMaterialPage extends StatefulWidget {
  const FoodRecipeAddRecipeMaterialPage({super.key});

  @override
  State<FoodRecipeAddRecipeMaterialPage> createState() =>
      _FoodRecipeAddRecipeMaterialPageState();
}

class _FoodRecipeAddRecipeMaterialPageState
    extends State<FoodRecipeAddRecipeMaterialPage> {
  File? _imageFile;

  void _onImageSelected(File? file) {
    setState(() {
      _imageFile = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImagePickerWidget(onImageSelected: _onImageSelected),
            SizedBox(height: 8),
            FoodRecipeRecipeNameMaterialPage(imageFile: _imageFile),
          ],
        ),
      ),
    );
  }
}

class ImagePickerWidget extends StatefulWidget {
  final void Function(File?) onImageSelected;
  const ImagePickerWidget({super.key, required this.onImageSelected});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      widget.onImageSelected(_imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 100),
        child: GestureDetector(
          onTap: _pickImage,
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(12),
            dashPattern: [6, 3],
            color: Colors.grey,
            child: Container(
              width: screenWidth * 0.85,
              height: 160,
              alignment: Alignment.center,
              child: _imageFile == null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.image, size: 48, color: Colors.grey),
                        SizedBox(height: 8),
                        Text(
                          "Add Cover Photo",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "(up to 5 Mb)",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    )
                  : Image.file(_imageFile!, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }
}

class FoodRecipeRecipeNameMaterialPage extends StatefulWidget {
  final File? imageFile;
  const FoodRecipeRecipeNameMaterialPage({super.key, required this.imageFile});

  @override
  State<FoodRecipeRecipeNameMaterialPage> createState() =>
      _FoodRecipeRecipeNameMaterialPageState();
}

class _FoodRecipeRecipeNameMaterialPageState
    extends State<FoodRecipeRecipeNameMaterialPage> {
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recipe Name",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _recipeNameController,
            decoration: InputDecoration(
              hintText: 'Enter recipe name',
              contentPadding:
                  EdgeInsets.only(top: 26.0, left: 12.0, right: 12.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
              ),
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Description",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          TextField(
            controller: _descriptionController,
            textAlignVertical: TextAlignVertical.top,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Tell a little about your food',
              alignLabelWithHint:
                  true, 
              contentPadding:
                  EdgeInsets.only(top: 26.0, left: 12.0, right: 12.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 35),
          SizedBox(height: 75),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFED477), 
              ),
              onPressed: () async {
                final imageUrl = await uploadImage(widget.imageFile!, null);
                if (imageUrl != null) {
                  final result = await addRecipe(
                    _recipeNameController.text,
                    [imageUrl],
                    _descriptionController.text,
                  );
                  if (result != null) {
                    final recipeId = int.parse(result['id'].toString());
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodRecipeIngredientStepsMaterialPage(recipeId: recipeId),
                      ),
                    );
                  }
                }
              },
              child: Text('Next'),
            ),
          )
        ],
      ),
    );
  }
}

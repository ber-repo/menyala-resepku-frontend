import 'package:flutter/material.dart';

class FoodRecipeLoginMaterialPage extends StatefulWidget {
  const FoodRecipeLoginMaterialPage({super.key});

  @override
  State<FoodRecipeLoginMaterialPage> createState() =>
      _FoodRecipeLoginMaterialPageState();
}

class _FoodRecipeLoginMaterialPageState
    extends State<FoodRecipeLoginMaterialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(     
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Menyala Resepku",
              style: TextStyle(
                color: Color(0xFFF5B935),
                fontSize: 40,
                fontFamily: 'PoetsenOne',
                shadows: [
                  Shadow(
                    offset: Offset(1.5, 1.5), 
                    blurRadius: 1,
                    color: Colors.black, 
                  ),
                ],
              ),
            ),
            const SizedBox(height: 65),
            Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 319,
                height: 369,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFED477),
                            foregroundColor: Color(0xFF971B1E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            fixedSize: Size(250, 50)),
                        onPressed: () {
                          // untuk tombol ditekan
                        },
                        child: Text(
                          'LOGIN',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text("Forget your password?"),
                      TextButton(
                        onPressed: () {
                          // untuk reset password
                        },
                        child: Text(
                          'Reset here',
                          style: TextStyle(
                            color: Color(0xFF971B1E),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

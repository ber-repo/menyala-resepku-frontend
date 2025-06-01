import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class FoodRecipeLoginMaterialPage extends StatefulWidget {
  const FoodRecipeLoginMaterialPage({super.key});

  @override
  State<FoodRecipeLoginMaterialPage> createState() =>
      _FoodRecipeLoginMaterialPageState();
}

class _FoodRecipeLoginMaterialPageState
    extends State<FoodRecipeLoginMaterialPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Map<String, String> _users = {'admin': '1234'}; // Default user
  bool _isLoginMode = true;

  void _handleAuth() async {
    final prefs = await SharedPreferences.getInstance();
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;

      if (_isLoginMode) {
        // LOGIN
        if (_users[username] == password) {
          await prefs.setBool('isLoggedIn', true); // Save login status
          await prefs.setString('username', username); // Save username
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainNavigation(username: username), // Pass username
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Username or password is incorrect')),
          );
        }
      } else {
        // SIGN UP
        if (_users.containsKey(username)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Username already exists')),
          );
        } else {
          _users[username] = password;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Account created. Please login.')),
          );
          setState(() {
            _isLoginMode = true;
          });
        }
      }
    }
  }

  void _handleResetPassword() {
    final username = _usernameController.text;
    if (_users.containsKey(username)) {
      setState(() {
        _users[username] = '1234'; // Reset to default
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset to "1234"')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username not found')),
      );
    }
  }

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
                height: 420,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _isLoginMode ? 'Login' : 'Sign Up',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) =>
                              value == null || value.isEmpty
                                  ? 'Enter your username'
                                  : null,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) =>
                              value == null || value.isEmpty
                                  ? 'Enter your password'
                                  : null,
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFED477),
                            foregroundColor: Color(0xFF971B1E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            fixedSize: Size(250, 50),
                          ),
                          onPressed: _handleAuth,
                          child: Text(
                            _isLoginMode ? 'LOGIN' : 'SIGN UP',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isLoginMode = !_isLoginMode;
                            });
                          },
                          child: Text(
                            _isLoginMode
                                ? "Don't have an account? Sign Up"
                                : "Already have an account? Login",
                            style: TextStyle(
                              color: Color(0xFF971B1E),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: _handleResetPassword,
                          child: Text(
                            'Forgot password? Reset',
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
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'auth_screen.dart';

const Color kGoldColor = Color(0xFFFFD700);
const Color kBlackColor = Colors.black;

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      await Future.delayed(const Duration(seconds: 2)); // Simulate network call

      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
      );

      // Navigate back to login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: kBlackColor,
        foregroundColor: kGoldColor,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // --- App Logo ---
                  Image.asset('assets/logo.png', height: 100),
                  const SizedBox(height: 40),

                  // --- Full Name ---
                  TextFormField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: TextStyle(color: kBlackColor),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kGoldColor, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // --- Phone ---
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(color: kBlackColor),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kGoldColor, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      } else if (value.length < 10) {
                        return 'Enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // --- Email ---
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: kBlackColor),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kGoldColor, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!value.contains('@')) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // --- Password ---
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: kBlackColor),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: kBlackColor,
                        ),
                        onPressed: () {
                          setState(() =>
                              _obscurePassword = !_obscurePassword);
                        },
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: kGoldColor, width: 2.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  // --- Register Button ---
                  _isLoading
                      ? const CircularProgressIndicator(color: kGoldColor)
                      : ElevatedButton(
                          onPressed: _register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kGoldColor,
                            foregroundColor: kBlackColor,
                            minimumSize: const Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'CREATE ACCOUNT',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  const SizedBox(height: 30),

                  // --- Already Have Account Link ---
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => AuthScreen()),
                      );
                    },
                    child: const Text(
                      'Already have an account? Sign In',
                      style: TextStyle(color: kBlackColor, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

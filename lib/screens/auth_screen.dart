import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';

// --- Brand Colors ---
const Color kGoldColor = Color(0xFFFFD700);
const Color kBlackColor = Colors.black;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true; // toggle password visibility

  InputDecoration _inputDecoration({required String label, required IconData prefixIcon, Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: kBlackColor),
      prefixIcon: Icon(prefixIcon, color: kBlackColor.withOpacity(0.6)),
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: kGoldColor, width: 2),
      ),
      border: const OutlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Sign In'),
        backgroundColor: kBlackColor,
        foregroundColor: kGoldColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Logo
              Image.asset(
                'assets/logo.png',
                height: 120,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.account_circle, size: 100, color: Colors.grey);
                },
              ),
              const SizedBox(height: 40),

              // Email or Phone
              TextFormField(
                controller: _emailOrPhoneController,
                decoration: _inputDecoration(label: 'Phone Number or Email', prefixIcon: Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number or email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Password with eye icon
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: _inputDecoration(
                  label: 'Password',
                  prefixIcon: Icons.lock,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: kBlackColor.withOpacity(0.6),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  ForgotPasswordScreen()),
                    );
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: kBlackColor),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Login Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Login Successful!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kGoldColor,
                  foregroundColor: kBlackColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'LOG IN',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const SizedBox(height: 30),

              // Register Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: kBlackColor),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: kGoldColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

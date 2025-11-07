import 'package:flutter/material.dart';

// --- Brand Colors ---
const Color kGoldColor = Color(0xFFFFD700);
const Color kBlackColor = Colors.black;

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  // Input decoration helper
  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: kBlackColor),
      prefixIcon: Icon(icon, color: kBlackColor.withOpacity(0.6)),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: kGoldColor, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      border: const OutlineInputBorder(),
    );
  }

  // Submit/reset password logic
  void _resetPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus(); // hide keyboard

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset link sent to ${emailController.text}'),
          backgroundColor: kBlackColor,
          duration: const Duration(seconds: 2),
        ),
      );

      // Navigate back after short delay
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: kBlackColor,
        foregroundColor: kGoldColor,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // dismiss keyboard
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Form(
              key: _formKey,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.lock_reset, size: 80, color: kGoldColor),
                      const SizedBox(height: 20),
                      const Text(
                        'Recover Your Account',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: kBlackColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Enter your email address and we will send you a password reset link.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Email Input Field
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            _buildInputDecoration('Email Address', Icons.email),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),

                      // Reset Password Button
                      ElevatedButton(
                        onPressed: () => _resetPassword(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kGoldColor,
                          foregroundColor: kBlackColor,
                          minimumSize: const Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text(
                          'SEND RESET LINK',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Back to Login Link
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Remembered your password? Log In",
                          style: TextStyle(
                            color: kBlackColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

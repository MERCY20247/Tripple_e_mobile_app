import 'dart:async';
import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

// Define a consistent Gold color for the brand
const Color kGoldColor = Color(0xFFFFD700);
const Color kBlackColor = Colors.black;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Move to Onboarding after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use the brand's primary color: Black
      backgroundColor: kBlackColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo (will appear gold on black background)
            Image.asset('assets/logo.png', height: 120), // Increased height for visibility
            SizedBox(height: 30),
            Text(
              // Updated text to match your brand
              "TRIPPLE E",
              style: TextStyle(
                // Use the brand's accent color: Gold
                color: kGoldColor,
                fontSize: 32, // Increased font size
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              // Subtitle for more branding
              "FINANCIAL SERVICES",
              style: TextStyle(
                color: Colors.white, // White for subtext contrast
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 50),
            // Set the indicator color to Gold
            CircularProgressIndicator(color: kGoldColor),
          ],
        ),
      ),
    );
  }
}

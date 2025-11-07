import 'package:flutter/material.dart';
import 'loan_application_screen.dart';

// --- Brand Colors ---
const Color kGoldColor = Color(0xFFFFD700);
const Color kBlackColor = Colors.black;
const Color kBackgroundColor = Color(0xFFFAFAFA);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBlackColor,
        title: Image.asset(
          'assets/logo.png',
          height: 40,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: kGoldColor),
            onPressed: () {
              // Handle notification tap
            },
          ),
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Welcome, Customer!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: kBlackColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Your trusted partner in financial services.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 30),

                // ElevatedButton for Loan Application
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoanApplicationScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kGoldColor,
                    foregroundColor: kBlackColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'APPLY FOR A LOAN',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Optional TextButton for other action
                TextButton(
                  onPressed: () {
                    // For example, navigate to Loan History or Support
                  },
                  child: const Text(
                    'View Loan History',
                    style: TextStyle(
                      fontSize: 16,
                      color: kBlackColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

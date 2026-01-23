import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'loan_types_screen.dart';
import 'loan_history_screen.dart';
import 'profile_screen.dart';

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

      // ---------------- AppBar ----------------
      appBar: AppBar(
        backgroundColor: kBlackColor,
        centerTitle: true,
        title: Image.asset(
          'assets/logo.png',
          height: 40,
        ),
        actions: [
          // Notifications
          IconButton(
            icon: const Icon(Icons.notifications, color: kGoldColor),
            onPressed: () {
              // TODO: Navigate to NotificationsScreen
            },
          ),

          // Profile
          IconButton(
            icon: const Icon(Icons.person, color: kGoldColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),

      // ---------------- Body ----------------
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ---------------- Welcome ----------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.account_circle,
                      color: kGoldColor,
                      size: 42,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Welcome, Customer!',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Text(
                  'Your trusted partner in financial services.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),

                const SizedBox(height: 30),

                // ---------------- Apply for Loan ----------------
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoanTypesScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kGoldColor,
                    foregroundColor: kBlackColor,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'APPLY FOR A LOAN',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // ---------------- Loan History ----------------
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoanHistoryScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'View Loan History',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kGoldColor = Color(0xFFFFD700);
const Color kBlackColor = Colors.black;

class LoanHistoryScreen extends StatelessWidget {
  const LoanHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Loan History',
          style: GoogleFonts.poppins(color: kGoldColor),
        ),
        backgroundColor: kBlackColor,
        iconTheme: const IconThemeData(color: kGoldColor),
      ),
      body: Center(
        child: Text(
          'No loan history available yet.',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
      ),
    );
  }
}

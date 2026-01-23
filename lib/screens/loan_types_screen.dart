import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'loan_application_screen.dart';

// --- Brand Colors ---
const Color kGoldColor = Color(0xFFFFD700);
const Color kBlackColor = Colors.black;
const Color kBackgroundColor = Color(0xFFFAFAFA);

class LoanTypesScreen extends StatelessWidget {
  const LoanTypesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Available Loan Types',
          style: GoogleFonts.poppins(
            color: kGoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: kBlackColor,
        iconTheme: const IconThemeData(color: kGoldColor),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _loanCard(
            context,
            title: 'Personal Loan',
            description:
                'Flexible loans for personal needs such as education, medical bills, or emergencies.',
            amount: 'UGX 500,000 – 10,000,000',
            duration: '6 – 24 months',
            interest: '3% monthly',
          ),
          const SizedBox(height: 16),
          _loanCard(
            context,
            title: 'Business Loan',
            description:
                'Grow your business with affordable financing and flexible repayment plans.',
            amount: 'UGX 1,000,000 – 50,000,000',
            duration: '6 – 36 months',
            interest: '2.5% monthly',
          ),
          const SizedBox(height: 16),
          _loanCard(
            context,
            title: 'Emergency Loan',
            description:
                'Quick access to cash for urgent financial needs with fast approval.',
            amount: 'UGX 100,000 – 1,000,000',
            duration: '1 – 6 months',
            interest: '4% monthly',
          ),
        ],
      ),
    );
  }

  Widget _loanCard(
    BuildContext context, {
    required String title,
    required String description,
    required String amount,
    required String duration,
    required String interest,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Gold Accent Border
            Container(
              width: 6,
              decoration: const BoxDecoration(
                color: kGoldColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 8),
                    _infoRow(Icons.payments_outlined, "Limit: $amount"),
                    _infoRow(Icons.timer_outlined, "Period: $duration"),
                    _infoRow(Icons.trending_up_outlined, "Interest: $interest"),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoanApplicationScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kBlackColor,
                          foregroundColor: kGoldColor,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'APPLY NOW',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: kGoldColor),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: kBlackColor,
            ),
          ),
        ],
      ),
    );
  }
}
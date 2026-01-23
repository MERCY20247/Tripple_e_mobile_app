import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Brand Colors ---
const Color kGoldColor = Color(0xFFFFD700);
const Color kBlackColor = Colors.black;
const Color kBackgroundColor = Color(0xFFFAFAFA);

enum LoanStatus { pending, approved, rejected }

class LoanStatusScreen extends StatelessWidget {
  final LoanStatus status;

  const LoanStatusScreen({
    super.key,
    this.status = LoanStatus.pending, // default state
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Loan Status',
          style: GoogleFonts.poppins(
            color: kGoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: kBlackColor,
        iconTheme: const IconThemeData(color: kGoldColor),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _statusIcon(),
                  const SizedBox(height: 20),
                  _statusTitle(),
                  const SizedBox(height: 10),
                  _statusMessage(),
                  const SizedBox(height: 25),
                  _statusDetails(),
                  const SizedBox(height: 30),
                  _actionButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- STATUS UI HELPERS ----------------

  Widget _statusIcon() {
    switch (status) {
      case LoanStatus.approved:
        return const Icon(
          Icons.check_circle,
          size: 90,
          color: Colors.green,
        );
      case LoanStatus.rejected:
        return const Icon(
          Icons.cancel,
          size: 90,
          color: Colors.red,
        );
      default:
        return const Icon(
          Icons.hourglass_top,
          size: 90,
          color: kGoldColor,
        );
    }
  }

  Widget _statusTitle() {
    String title;
    Color color;

    switch (status) {
      case LoanStatus.approved:
        title = 'Loan Approved';
        color = Colors.green;
        break;
      case LoanStatus.rejected:
        title = 'Loan Rejected';
        color = Colors.red;
        break;
      default:
        title = 'Pending Approval';
        color = kGoldColor;
    }

    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  Widget _statusMessage() {
    String message;

    switch (status) {
      case LoanStatus.approved:
        message =
            'Congratulations! Your loan has been approved and will be disbursed shortly.';
        break;
      case LoanStatus.rejected:
        message =
            'Unfortunately, your loan application was not approved. You may try again later.';
        break;
      default:
        message =
            'Your loan application is currently under review. This may take up to 24 hours.';
    }

    return Text(
      message,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        fontSize: 16,
        color: Colors.grey[700],
        height: 1.5,
      ),
    );
  }

  Widget _statusDetails() {
    if (status != LoanStatus.approved) return const SizedBox.shrink();

    return Column(
      children: [
        _detailRow('Approved Amount', 'UGX 5,000,000'),
        _detailRow('Repayment Period', '12 Months'),
        _detailRow('Monthly Installment', 'UGX 470,000'),
        _detailRow('Next Due Date', '15 Oct 2025'),
      ],
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: kBlackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(BuildContext context) {
    switch (status) {
      case LoanStatus.approved:
        return ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kGoldColor,
            foregroundColor: kBlackColor,
            minimumSize: const Size(double.infinity, 50),
          ),
          child: Text(
            'GO TO HOME',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
        );

      case LoanStatus.rejected:
        return ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
          ),
          child: Text(
            'APPLY AGAIN',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
        );

      default:
        return TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'CHECK LATER',
            style: GoogleFonts.poppins(
              color: kBlackColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
    }
  }
}

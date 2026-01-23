import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Brand Colors ---
const Color kGoldColor = Color(0xFFFFD700);
const Color kBlackColor = Colors.black;
const Color kBackgroundColor = Color(0xFFFAFAFA);

class LoanCalculationScreen extends StatefulWidget {
  const LoanCalculationScreen({super.key});

  @override
  State<LoanCalculationScreen> createState() => _LoanCalculationScreenState();
}

class _LoanCalculationScreenState extends State<LoanCalculationScreen> {
  double loanAmount = 1000000; // UGX
  int loanDuration = 6; // months
  final double interestRate = 0.1; // 10%

  double get interest => loanAmount * interestRate;
  double get totalPayable => loanAmount + interest;
  double get monthlyInstallment => totalPayable / loanDuration;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Loan Calculator',
          style: GoogleFonts.poppins(
            color: kGoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: kBlackColor,
        iconTheme: const IconThemeData(color: kGoldColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Loan Amount (UGX)'),
            _amountSlider(),
            const SizedBox(height: 20),

            _sectionTitle('Loan Duration (Months)'),
            _durationSelector(),
            const SizedBox(height: 30),

            _summaryCard(),
            const SizedBox(height: 30),

            _proceedButton(context),
          ],
        ),
      ),
    );
  }

  // ---------------- UI SECTIONS ----------------

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: kBlackColor,
      ),
    );
  }

  Widget _amountSlider() {
    return Column(
      children: [
        Text(
          'UGX ${loanAmount.toStringAsFixed(0)}',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: kGoldColor,
          ),
        ),
        Slider(
          min: 100000,
          max: 10000000,
          divisions: 99,
          value: loanAmount,
          activeColor: kGoldColor,
          onChanged: (value) {
            setState(() => loanAmount = value);
          },
        ),
      ],
    );
  }

  Widget _durationSelector() {
    return Wrap(
      spacing: 10,
      children: [3, 6, 9, 12, 18, 24].map((months) {
        final bool selected = loanDuration == months;
        return ChoiceChip(
          label: Text('$months'),
          selected: selected,
          selectedColor: kGoldColor,
          labelStyle: GoogleFonts.poppins(
            color: selected ? kBlackColor : kBlackColor,
            fontWeight: FontWeight.w500,
          ),
          onSelected: (_) {
            setState(() => loanDuration = months);
          },
        );
      }).toList(),
    );
  }

  Widget _summaryCard() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _summaryRow('Interest Rate', '10%'),
            _summaryRow('Interest Amount', 'UGX ${interest.toStringAsFixed(0)}'),
            _summaryRow('Total Payable', 'UGX ${totalPayable.toStringAsFixed(0)}'),
            const Divider(),
            _summaryRow(
              'Monthly Installment',
              'UGX ${monthlyInstallment.toStringAsFixed(0)}',
              bold: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool bold = false}) {
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
              fontWeight: bold ? FontWeight.bold : FontWeight.w600,
              color: kBlackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _proceedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to loan application screen
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: kGoldColor,
        foregroundColor: kBlackColor,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        'PROCEED TO APPLICATION',
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

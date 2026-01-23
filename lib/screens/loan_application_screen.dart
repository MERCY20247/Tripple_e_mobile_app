import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'guarantor_screen.dart'; // Import your new screen

// --- Brand Colors ---
const Color kGoldColor = Color(0xFFFFD700);
const Color kBlackColor = Colors.black;
const Color kBackgroundColor = Color(0xFFFAFAFA);

class LoanApplicationScreen extends StatefulWidget {
  const LoanApplicationScreen({super.key});

  @override
  State<LoanApplicationScreen> createState() => _LoanApplicationScreenState();
}

class _LoanApplicationScreenState extends State<LoanApplicationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _termController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _termController.dispose();
    _purposeController.dispose();
    super.dispose();
  }

  void _proceedToGuarantor() {
    if (_formKey.currentState!.validate()) {
      // Navigate to the next step in the application process
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const GuarantorScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Loan Details',
          style: GoogleFonts.poppins(
            color: kGoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: kBlackColor,
        iconTheme: const IconThemeData(color: kGoldColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Step 1 of 3: Loan Information",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: kBlackColor.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 20),
              
              _buildInputField(
                controller: _amountController,
                label: 'Loan Amount',
                hint: 'e.g. 500,000',
                icon: Icons.account_balance_wallet,
                prefixText: 'UGX ',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter amount';
                  final n = double.tryParse(value);
                  if (n == null || n < 100) return 'Minimum amount is 100';
                  return null;
                },
              ),

              const SizedBox(height: 20),

              _buildInputField(
                controller: _termController,
                label: 'Repayment Period',
                hint: 'e.g. 12',
                icon: Icons.timelapse,
                suffixText: ' Months',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter period';
                  final n = int.tryParse(value);
                  if (n == null || n < 6) return 'Minimum 6 months';
                  return null;
                },
              ),

              const SizedBox(height: 20),

              _buildInputField(
                controller: _purposeController,
                label: 'Purpose of Loan',
                hint: 'Describe why you need this loan...',
                icon: Icons.edit_note,
                maxLines: 4,
                validator: (value) =>
                    value == null || value.length < 10 ? 'Please provide more detail' : null,
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: _proceedToGuarantor,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kBlackColor,
                  foregroundColor: kGoldColor,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'NEXT: GUARANTOR INFO',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.arrow_forward, size: 20),
                  ],
                ),
              ),
              
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel Application',
                    style: GoogleFonts.poppins(color: Colors.redAccent),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? prefixText,
    String? suffixText,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: kBlackColor,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          style: GoogleFonts.poppins(color: kBlackColor),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
            prefixText: prefixText,
            suffixText: suffixText,
            prefixIcon: Icon(icon, color: kGoldColor),
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kGoldColor, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
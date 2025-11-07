import 'package:flutter/material.dart';

// --- Brand Colors ---
const Color kGoldColor = Color(0xFFFFD700);
const Color kBlackColor = Colors.black;
const Color kBackgroundColor = Color(0xFFFAFAFA);

class LoanApplicationScreen extends StatelessWidget {
  LoanApplicationScreen({super.key});

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Controllers for input fields
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _termController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();

  // Submit logic
  void _submitApplication(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Show confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Loan application for \$${_amountController.text} submitted!'),
          backgroundColor: kBlackColor,
          duration: const Duration(seconds: 3),
        ),
      );
      Navigator.pop(context); // Go back to previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('New Loan Application'),
        backgroundColor: kBlackColor,
        foregroundColor: kGoldColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey, // Requirement: Form widget
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tell us about your loan needs:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kBlackColor,
                ),
              ),
              const SizedBox(height: 30),

              // Loan Amount Field
              _buildTextFormField(
                controller: _amountController,
                label: 'Desired Loan Amount (\$) *',
                icon: Icons.attach_money,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == null ||
                      double.parse(value) <= 100) {
                    return 'Please enter a valid amount (min \$100)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Loan Term Field
              _buildTextFormField(
                controller: _termController,
                label: 'Repayment Term (Months) *',
                icon: Icons.calendar_today,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      int.tryParse(value) == null ||
                      int.parse(value) < 6) {
                    return 'Term must be at least 6 months';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Loan Purpose Field
              _buildTextFormField(
                controller: _purposeController,
                label: 'Purpose of Loan *',
                icon: Icons.description,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please state the loan purpose';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),

              // Submit Button
              ElevatedButton(
                onPressed: () => _submitApplication(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kGoldColor,
                  foregroundColor: kBlackColor,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  'SUBMIT APPLICATION',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 15),

              // Cancel / Back Button
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'CANCEL',
                  style: TextStyle(fontSize: 16, color: kBlackColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper for TextFormField decoration
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: kBlackColor),
        prefixIcon: Icon(icon, color: kBlackColor.withOpacity(0.6)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kGoldColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kGoldColor = Color(0xFFFFD700);
const Color kBlackColor = Colors.black;

class GuarantorScreen extends StatefulWidget {
  const GuarantorScreen({super.key});

  @override
  State<GuarantorScreen> createState() => _GuarantorScreenState();
}

class _GuarantorScreenState extends State<GuarantorScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();

  void _saveAndContinue() {
    if (_formKey.currentState!.validate()) {
      // For now, we just go back. Later, this data will be passed to the API
      Navigator.pop(context); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guarantor Details', style: GoogleFonts.poppins(color: kGoldColor)),
        backgroundColor: kBlackColor,
        iconTheme: const IconThemeData(color: kGoldColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildField(_nameController, 'Full Name', Icons.person),
              const SizedBox(height: 20),
              _buildField(_phoneController, 'Phone Number', Icons.phone, keyboard: TextInputType.phone),
              const SizedBox(height: 20),
              _buildField(_idController, 'National ID Number', Icons.badge),
              const SizedBox(height: 20),
              _buildField(_relationshipController, 'Relationship', Icons.group),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _saveAndContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kGoldColor,
                  minimumSize: const Size(double.infinity, 55),
                ),
                child: Text('SAVE GUARANTOR', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: kBlackColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label, IconData icon, {TextInputType keyboard = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: kBlackColor),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: kGoldColor)),
      ),
      validator: (v) => v!.isEmpty ? 'Required' : null,
    );
  }
}
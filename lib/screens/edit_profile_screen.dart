import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kGoldColor = Color(0xFFFFD700);
const Color kBlackColor = Colors.black;
const Color kBackgroundColor = Color(0xFFFAFAFA);

class EditProfileScreen extends StatefulWidget {
  // Pass current values so they show up in the text fields when the screen opens
  final String currentName;
  final String currentEmail;
  final String currentPhone;

  const EditProfileScreen({
    super.key,
    required this.currentName,
    required this.currentEmail,
    required this.currentPhone,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with the data passed from the Profile Screen
    _nameController = TextEditingController(text: widget.currentName);
    _emailController = TextEditingController(text: widget.currentEmail);
    _phoneController = TextEditingController(text: widget.currentPhone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    await Future.delayed(const Duration(seconds: 1)); // Faster simulation
    setState(() => _isSaving = false);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully'),
        backgroundColor: Colors.green,
      ),
    );

    // IMPORTANT: Pass the data back as a Map to the previous screen
    Navigator.pop(context, {
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(color: kGoldColor, fontWeight: FontWeight.w600),
        ),
        backgroundColor: kBlackColor,
        iconTheme: const IconThemeData(color: kGoldColor),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundColor: kGoldColor,
                    child: Icon(Icons.person, size: 50, color: kBlackColor),
                  ),
                  const SizedBox(height: 25),
                  _buildInputField(
                    controller: _nameController,
                    label: 'Full Name',
                    icon: Icons.person_outline,
                    validator: (v) => v!.isEmpty ? 'Enter name' : null,
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    controller: _emailController,
                    label: 'Email Address',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) => !v!.contains('@') ? 'Enter valid email' : null,
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    controller: _phoneController,
                    label: 'Phone Number',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    validator: (v) => v!.length < 10 ? 'Enter valid phone' : null,
                  ),
                  const SizedBox(height: 35),
                  _isSaving
                      ? const CircularProgressIndicator(color: kGoldColor)
                      : ElevatedButton(
                          onPressed: _saveProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kGoldColor,
                            foregroundColor: kBlackColor,
                            minimumSize: const Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text(
                            'SAVE CHANGES',
                            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: GoogleFonts.poppins(color: kBlackColor),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: kBlackColor),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: kGoldColor, width: 2)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
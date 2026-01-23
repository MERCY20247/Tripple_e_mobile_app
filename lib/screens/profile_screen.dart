import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'edit_profile_screen.dart';
import 'settings_screen.dart';
import 'auth_screen.dart';

// --- Brand Colors ---
const Color kGoldColor = Color(0xFFFFD700);
const Color kBlackColor = Colors.black;
const Color kBackgroundColor = Color(0xFFFAFAFA);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ---------------- User Data (local for now) ----------------
  String _name = 'Mercy Aziirwe';
  String _email = 'aziirwemercy@gmail.com';
  String _phone = '+256757185014';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBlackColor,
        iconTheme: const IconThemeData(color: kGoldColor),
        title: Text(
          'My Profile',
          style: GoogleFonts.poppins(
            color: kGoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ---------------- Profile Card ----------------
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 45,
                      backgroundColor: kGoldColor,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: kBlackColor,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      _name,
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _email,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _phone,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ---------------- Profile Options ----------------
            _profileOption(
              icon: Icons.edit,
              title: 'Edit Profile',
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfileScreen(
                      currentName: _name,
                      currentEmail: _email,
                      currentPhone: _phone,
                    ),
                  ),
                );

                if (result != null && result is Map<String, String>) {
                  setState(() {
                    _name = result['name']!;
                    _email = result['email']!;
                    _phone = result['phone']!;
                  });
                }
              },
            ),

            _profileOption(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SettingsScreen(),
                  ),
                );
              },
            ),

            _profileOption(
              icon: Icons.lock_outline,
              title: 'Change Password',
              onTap: () => _showChangePasswordDialog(),
            ),

            _profileOption(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () => _showHelpSupportSheet(),
            ),

            const SizedBox(height: 20),

            // ---------------- Logout ----------------
            Card(
              elevation: 0,
              color: Colors.red.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.red.shade100),
              ),
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: Text(
                  'Logout',
                  style: GoogleFonts.poppins(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () => _confirmLogout(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- Logic Helpers ----------------

  void _showChangePasswordDialog() {
    final TextEditingController oldPassController = TextEditingController();
    final TextEditingController newPassController = TextEditingController();
    bool obscureOld = true;
    bool obscureNew = true;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text('Change Password',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _dialogTextField(oldPassController, 'Current Password', obscureOld, () {
                setDialogState(() => obscureOld = !obscureOld);
              }),
              const SizedBox(height: 15),
              _dialogTextField(newPassController, 'New Password', obscureNew, () {
                setDialogState(() => obscureNew = !obscureNew);
              }),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: GoogleFonts.poppins(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kBlackColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password updated successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: Text('UPDATE', style: GoogleFonts.poppins(color: kGoldColor)),
            ),
          ],
        ),
      ),
    );
  }

  void _showHelpSupportSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Help & Support',
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _supportTile(Icons.phone, 'Call Us', '+256 757 185014'),
            _supportTile(Icons.email, 'Email Us', 'support@tripple-e.com'),
            _supportTile(Icons.chat_bubble_outline, 'Live Chat', 'Average response: 5 mins'),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ---------------- Small Reusable Widgets ----------------

  Widget _dialogTextField(TextEditingController controller, String label, bool obscure, VoidCallback toggle) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(fontSize: 14),
        suffixIcon: IconButton(
            icon: Icon(obscure ? Icons.visibility_off : Icons.visibility, size: 20),
            onPressed: toggle),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: kGoldColor)),
      ),
    );
  }

  Widget _supportTile(IconData icon, String title, String sub) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
          backgroundColor: kGoldColor.withOpacity(0.1),
          child: Icon(icon, color: kBlackColor, size: 20)),
      title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15)),
      subtitle: Text(sub, style: GoogleFonts.poppins(fontSize: 13)),
      onTap: () => Navigator.pop(context),
    );
  }

  Widget _profileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: kGoldColor),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: kBlackColor,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          'Logout',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: kBlackColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const AuthScreen()),
                (_) => false,
              );
            },
            child: Text(
              'Logout',
              style: GoogleFonts.poppins(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
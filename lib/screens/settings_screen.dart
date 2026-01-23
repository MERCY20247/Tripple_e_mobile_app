import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth_screen.dart';

// --- Brand Colors ---
const Color kGoldColor = Color(0xFFFFD700);
const Color kBlackColor = Colors.black;
const Color kBackgroundColor = Color(0xFFFAFAFA);

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'English (UK)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(
            color: kGoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: kBlackColor,
        iconTheme: const IconThemeData(color: kGoldColor),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _sectionTitle('Preferences'),
          _switchTile(
            title: 'Enable Notifications',
            icon: Icons.notifications_active,
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() => _notificationsEnabled = value);
            },
          ),
          _switchTile(
            title: 'Dark Mode',
            icon: Icons.dark_mode,
            value: _darkModeEnabled,
            onChanged: (value) {
              setState(() => _darkModeEnabled = value);
            },
          ),
          const SizedBox(height: 25),
          
          _sectionTitle('General'),
          _navTile(
            title: 'Language',
            subtitle: _selectedLanguage,
            icon: Icons.language,
            onTap: () => _showLanguageDialog(),
          ),
          _navTile(
            title: 'Privacy Policy',
            icon: Icons.privacy_tip_outlined,
            onTap: () => _showDocumentSheet(
              'Privacy Policy',
              'At Tripple E Financial Services, your privacy is our priority. We collect data to improve your loan experience. We do not share your personal identification with third parties without consent. Your data is encrypted and stored securely in compliance with financial regulations.',
            ),
          ),
          _navTile(
            title: 'Terms & Conditions',
            icon: Icons.description_outlined,
            onTap: () => _showDocumentSheet(
              'Terms & Conditions',
              '1. Eligibility: You must be 18+ to apply for a loan.\n\n2. Repayment: Failure to pay within the agreed period may affect your credit score and attract penalties.\n\n3. Data: You authorize Tripple E to verify your credit history with relevant authorities.\n\n4. Interest: Interest rates are fixed at the time of approval.',
            ),
          ),
          const SizedBox(height: 25),
          
          _sectionTitle('Account'),
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
          const SizedBox(height: 40),
          Center(
            child: Text(
              'Tripple E v1.0.1',
              style: GoogleFonts.poppins(
                color: Colors.grey, 
                fontSize: 12,
                letterSpacing: 1.1,
              ),
            ),
          )
        ],
      ),
    );
  }

  // --- Functional Logic Helpers ---

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text('Select Language', 
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold)
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['English (UK)', 'Luganda', 'Swahili'].map((lang) {
            return RadioListTile<String>(
              activeColor: kGoldColor,
              title: Text(lang, style: GoogleFonts.poppins()),
              value: lang,
              groupValue: _selectedLanguage,
              onChanged: (val) {
                setState(() => _selectedLanguage = val!);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showDocumentSheet(String title, String content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, 
                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context), 
                  icon: const Icon(Icons.close)
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  content,
                  style: GoogleFonts.poppins(
                    fontSize: 14, 
                    color: Colors.black87, 
                    height: 1.6
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: kBlackColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text('I UNDERSTAND', 
                style: GoogleFonts.poppins(color: kGoldColor, fontWeight: FontWeight.bold)
              ),
            )
          ],
        ),
      ),
    );
  }

  // --- UI Helpers ---

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: kBlackColor.withOpacity(0.4),
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _switchTile({
    required String title,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        title: Text(title, 
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15)
        ),
        secondary: Icon(icon, color: kGoldColor),
        activeColor: kGoldColor,
      ),
    );
  }

  Widget _navTile({
    required String title,
    String? subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: Icon(icon, color: kGoldColor),
        title: Text(title, 
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15)
        ),
        subtitle: subtitle != null 
          ? Text(subtitle, style: GoogleFonts.poppins(fontSize: 12, color: kGoldColor)) 
          : null,
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text('Logout', 
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold)
        ),
        content: Text('Are you sure you want to exit your session?', 
          style: GoogleFonts.poppins()
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: Text('Cancel', style: GoogleFonts.poppins(color: kBlackColor))
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const AuthScreen()),
                (route) => false,
              );
            },
            child: Text('Logout', 
              style: GoogleFonts.poppins(color: Colors.red, fontWeight: FontWeight.bold)
            ),
          ),
        ],
      ),
    );
  }
}
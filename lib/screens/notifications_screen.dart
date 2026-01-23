import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Brand Colors ---
const Color kGoldColor = Color(0xFFFFD700);
const Color kBlackColor = Colors.black;
const Color kBackgroundColor = Color(0xFFFAFAFA);

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBlackColor,
        iconTheme: const IconThemeData(color: kGoldColor),
        title: Text(
          'Notifications',
          style: GoogleFonts.poppins(
            color: kGoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: () {
              // Later: mark all as read
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          _notificationTile(
            icon: Icons.check_circle,
            title: 'Loan Approved 🎉',
            message:
                'Your personal loan of UGX 1,000,000 has been approved.',
            time: '2 mins ago',
            isUnread: true,
          ),
          _notificationTile(
            icon: Icons.pending_actions,
            title: 'Loan Under Review',
            message:
                'Your business loan application is currently being reviewed.',
            time: '1 hour ago',
          ),
          _notificationTile(
            icon: Icons.warning,
            title: 'Payment Reminder',
            message:
                'Your next loan installment is due tomorrow. Please pay on time.',
            time: 'Yesterday',
          ),
          _notificationTile(
            icon: Icons.info,
            title: 'New Loan Offer',
            message:
                'You are eligible for a top-up loan. Apply now.',
            time: '2 days ago',
          ),
        ],
      ),
    );
  }

  // ---------------- Notification Card ----------------

  Widget _notificationTile({
    required IconData icon,
    required String title,
    required String message,
    required String time,
    bool isUnread = false,
  }) {
    return Card(
      elevation: isUnread ? 6 : 2,
      color: isUnread ? kGoldColor.withOpacity(0.12) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: kBlackColor,
          child: Icon(icon, color: kGoldColor),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: kBlackColor,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            message,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.grey[800],
            ),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              time,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: Colors.grey[600],
              ),
            ),
            if (isUnread)
              const Icon(
                Icons.circle,
                size: 10,
                color: Colors.red,
              ),
          ],
        ),
      ),
    );
  }
}

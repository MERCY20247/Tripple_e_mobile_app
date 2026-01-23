import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth_screen.dart';

// --- Brand Colors ---
const Color kGoldColor = Color(0xFFFFD700);
const Color kBlackColor = Colors.black;

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // --- PageView Section ---
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() => isLastPage = index == 2);
                  },
                  children: [
                    buildPage(
                      image: 'assets/loan.png',
                      title: 'Welcome to Tripple E',
                      description:
                          'Access fast and secure loans anytime, anywhere right from your phone.',
                    ),
                    buildPage(
                      image: 'assets/loan2.png',
                      title: 'Smart Loan Management',
                      description:
                          'Easily apply, track repayments, and get instant updates on your loan status.',
                    ),
                    buildPage(
                      image: 'assets/logo.png',
                      title: 'Empowering Your Financial Growth',
                      description:
                          'Experience transparent, reliable, and convenient financial services with Tripple E.',
                    ),
                  ],
                ),
              ),

              // --- Bottom Navigation Controls ---
              Container(
                height: 70,
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey.shade200)),
                ),
                child: isLastPage
                    ? _buildGetStartedButton(context)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Skip Button
                          TextButton(
                            onPressed: () => _controller.jumpToPage(2),
                            child: Text(
                              'Skip',
                              style: GoogleFonts.poppins(
                                color: kBlackColor,
                                fontSize: 16,
                              ),
                            ),
                          ),

                          // Dots Indicator
                          Row(
                            children: List.generate(
                              3,
                              (index) => buildDot(index: index),
                            ),
                          ),

                          // Next Button
                          TextButton(
                            onPressed: () => _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            ),
                            child: Text(
                              'Next',
                              style: GoogleFonts.poppins(
                                color: kGoldColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Get Started Button ---
  Widget _buildGetStartedButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AuthScreen()),
        );
      },
      child: Container(
        width: double.infinity,
        height: 60,
        color: kBlackColor,
        alignment: Alignment.center,
        child: Text(
          'GET STARTED',
          style: GoogleFonts.poppins(
            color: kGoldColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  // --- Page Indicator Dots ---
  Widget buildDot({required int index}) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double currentPage = _controller.hasClients ? _controller.page ?? 0 : 0;
        bool isActive = (currentPage.round() == index);
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: 8.0,
          width: isActive ? 18.0 : 8.0,
          decoration: BoxDecoration(
            color: isActive ? kGoldColor : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4.0),
          ),
        );
      },
    );
  }

  // --- Onboarding Page Template ---
  Widget buildPage({
    required String image,
    required String title,
    required String description,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 300),
        const SizedBox(height: 30),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: kBlackColor,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          description,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: Colors.grey[800],
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

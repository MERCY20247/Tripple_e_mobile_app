import 'package:flutter/material.dart';
import 'auth_screen.dart';

// --- Brand Colors ---
const Color kGoldColor = Color(0xFFFFD700);
const Color kBlackColor = Colors.black;

class OnboardingScreen extends StatefulWidget {
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
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: PageView(
            controller: _controller,
            onPageChanged: (index) {
              // Assuming 3 pages (0,1,2)
              setState(() => isLastPage = index == 2);
            },
            children: [
              buildPage(
                image: 'assets/loan.jpg',
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
      ),
      bottomSheet: isLastPage
          ? TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => AuthScreen()),
                );
              },
              child: Container(
                width: double.infinity,
                height: 60,
                color: kBlackColor,
                alignment: Alignment.center,
                child: const Text(
                  'GET STARTED',
                  style: TextStyle(
                    color: kGoldColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          : Container(
              height: 60,
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip Button
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextButton(
                      onPressed: () => _controller.jumpToPage(2),
                      child: const Text(
                        'Skip',
                        style: TextStyle(color: kBlackColor),
                      ),
                    ),
                  ),

                  // Page Dots
                  Row(
                    children:
                        List.generate(3, (index) => buildDot(index: index)),
                  ),

                  // Next Button
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: TextButton(
                      onPressed: () => _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: kGoldColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
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
          width: isActive ? 16.0 : 8.0,
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
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: kBlackColor,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[800],
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

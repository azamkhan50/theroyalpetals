import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royalpetals/controller/ShopifyLoginController.dart';
import 'package:royalpetals/core/constants/app_images.dart';
import 'package:royalpetals/utils/app_routes.dart';
import 'package:royalpetals/views/splash_screen/onboarding_screen_2.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using MediaQuery to handle responsiveness for all devices
    final size = MediaQuery.of(context).size;
    final double horizontalPadding = size.width * 0.08;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Image (The Flowers)
          Positioned.fill(
            child: Image.asset(
              "assets/image/flower.png", // Replace with your local asset
              fit: BoxFit.cover,
            ),
          ),

          // 2. Petals Overlay (Gradient/Image)
          // You would typically use a transparent PNG here for the falling petals
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.9),
                  ],
                  stops: const [0.6, 1.0],
                ),
              ),
            ),
          ),

          // 3. Content Layer
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Spacer(flex: 10), // Pushes content to the bottom
                  // Heading
                  Text(
                    'Every Celebration Starts Here',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cabin(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Color(0xFFC39A38),
                      height: 1.5, // Optional: adds nice spacing between lines
                    ),
                    // style: TextStyle(
                    //   fontSize: size.width * 0.065, // Responsive font size
                    //   fontWeight: FontWeight.bold,
                    //   color: const Color(0xFFC09E48), // Gold color from UI
                    // ),
                  ),

                  const SizedBox(height: 12),

                  // Subtitle
                  Text(
                    'Discover premium flowers, artisanal cakes, and luxury gift arrangements curated to make every moment unforgettable.',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.cabin(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      //  color:  Color,
                      height: 1.5, // Optional: adds nice spacing between lines
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Page Indicator dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDot(isActive: true),
                      _buildDot(isActive: false),
                      _buildDot(isActive: false),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Buttons Row
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: TextButton(
                            onPressed: () {
                              // 1. Access the Login Controller
                              final authController =
                                  Get.find<ShopifyLoginController>();

                              // 2. Check if the token is valid
                              if (authController.accessToken.value.isNotEmpty) {
                                // User is already logged in, go to Home
                                Get.offAllNamed(AppRoutes.mainNav);
                              } else {
                                // User is not logged in, go to Login Screen
                                Get.offAllNamed(AppRoutes.login);
                              }
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFFE8D9B5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Skip',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Skip Button
                      // Expanded(
                      //   child: SizedBox(
                      //     height: 56,
                      //     child: TextButton(
                      //       onPressed: () {
                      //         Get.toNamed(AppRoutes.login);
                      //       },
                      //       style: TextButton.styleFrom(
                      //         backgroundColor: const Color(0xFFE8D9B5),
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(8),
                      //         ),
                      //       ),
                      //       child: const Text(
                      //         'Skip',
                      //         style: TextStyle(
                      //           color: Colors.black87,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(width: 16),

                      // Next Button
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(const OnboardingScreen2());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFC49E3C),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Next',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20), // Bottom margin
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFC49E3C) : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }
}

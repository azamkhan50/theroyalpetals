import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royalpetals/controller/ShopifyLoginController.dart';
import 'package:royalpetals/core/constants/app_images.dart';
import 'package:royalpetals/utils/app_routes.dart';
import 'package:royalpetals/views/splash_screen/onboarding_screen_3.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    // Media Query for dynamic sizing (responsiveness)
    final size = MediaQuery.of(context).size;
    
    // Constant brand colors from Figma
    const Color brandGold = Color(0xFFC39A38); // Standard brand gold
    const Color skipButtonBg = Color(0xFFE8D9B5); // Light beige for skip
    
    // Calculate adaptive padding
    final double horizontalPadding = size.width * 0.08;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Background Layer: Main Hands & Bouquet Image
          Positioned.fill(
            child: Image.asset(
             "assets/image/flower2.png",
            //  'assets/image/onboarding_2.png', // Replace with your file name
              fit: BoxFit.cover,
            ),
          ),

          // 2. Petals & Gradient Overlay (The soft fade at the bottom)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.0), // Transparent top
                    Colors.white.withOpacity(0.1), // Starts fading
                    Colors.white.withOpacity(0.8), // Solid white bottom
                  ],
                  // Crucial for placing the fade exactly above the text
                  stops: const [0.4, 0.6, 0.85], 
                ),
              ),
            ),
          ),

          // 3. Content Layer (Text, Dots, Buttons)
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding,),
              child: Column(
                children: [
                  // This spacer pushes the text content to the lower half
                  const Spacer(flex: 12),

                  // adaptive Title
                  Text(
                    'Curated for Every Occasion',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cabin(
                      // Scales title font weight 700 with screen width
                      fontSize: size.width * 0.07, 
                      fontWeight: FontWeight.bold,
                      color: brandGold,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Subtitle
                  Text(
                    'From birthdays to Eid and everything in between, find the perfect gift designed to match every emotion and moment.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cabin(
                      // Smaller adaptive font for the description
                      fontSize: size.width * 0.038,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54, // Muted black
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Page Indicator (3 dots)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDot(isActive: false),
                      _buildDot(isActive: true, activeColor: brandGold),
                      _buildDot(isActive: false),
                    ],
                  ),

                  const SizedBox(height: 35),

                  // Buttons Row
                  Row(
                    children: [
                      // Skip Button (Light background)
                      Expanded(
                        child: SizedBox(
                          height: 55,
                          child: TextButton(
                            onPressed: () {
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
                              // Action for skip (e.g., skip to Login)
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: skipButtonBg,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Skip',
                              style: GoogleFonts.cabin(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Next Button (Dark gold background)
                      Expanded(
                        child: SizedBox(
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(const OnboardingScreen3());
                              // Action for next (e.g., go to Onboarding 3)
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: brandGold,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0, // Keep it flat like the UI
                            ),
                            child: Text(
                              'Next',
                              style: GoogleFonts.cabin(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Adaptive bottom spacing for different notches
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Small widget to draw a single dot for page indication
  Widget _buildDot({required bool isActive, Color activeColor = Colors.grey}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? activeColor : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }
}
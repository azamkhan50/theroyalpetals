import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:royalpetals/controller/ShopifyLoginController.dart';
import 'package:royalpetals/utils/app_routes.dart';
import 'package:royalpetals/views/auth/login_screen.dart';
import 'package:royalpetals/views/splash_screen/onboarding_screen.dart';
import 'package:get/get.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        // This triggers when the user taps anywhere on the image
        onTap: () {
          final authController = Get.find<ShopifyLoginController>();

          // 2. Check if the token is valid
          if (authController.accessToken.value.isNotEmpty) {
            // User is already logged in, go to Home
            Get.offAllNamed(AppRoutes.mainNav);
          } else {
            // User is not logged in, go to Login Screen
            Get.offAllNamed(AppRoutes.login);
          } // Navigate to the Login Screen
        },
        child: SizedBox.expand(
          child: Image.asset(
            "assets/image/splash_screen3.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

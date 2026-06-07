import 'package:get/get.dart';
import 'package:royalpetals/controller/ShopifyLoginController.dart';
import 'package:royalpetals/utils/app_routes.dart';
import 'package:royalpetals/views/splash_screen/onboarding_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    // 1. Mandatory wait for the Splash Screen branding (e.g., 3 seconds)
    await Future.delayed(const Duration(seconds: 3));

    // 2. Access the Auth Controller
    // Ensure ShopifyLoginController is already initialized in your Bindings
    final authController = Get.find<ShopifyLoginController>();

    // 3. Check the token status
    if (authController.accessToken.value.isNotEmpty) {
      // User is logged in -> Go to Home/Main
      Get.offAllNamed(AppRoutes.mainNav);
    } else {
      // User is NOT logged in -> Go to Onboarding Screen
      // Using Get.offAll to prevent user from going back to splash
      Get.offAll(() => const OnboardingScreen());
    }
  }
}

// class SplashController extends GetxController {
//   @override
//   void onInit() {
//     super.onInit();
//     _checkLoginStatus();
//   }

//   void _checkLoginStatus() async {
//     // Show splash for 3 seconds
//     await Future.delayed(const Duration(seconds: 3));

//     // Access the persistent controller
//     final authController = Get.find<ShopifyLoginController>();

//     if (authController.accessToken.value.isNotEmpty) {
//       // If token exists, go to Main Home
//       Get.offAllNamed(AppRoutes.mainNav);
//     } else {
//       // Otherwise, go to Login
//       Get.offAllNamed(AppRoutes.login);
//     }
//   }
// }
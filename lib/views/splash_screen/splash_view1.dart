import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royalpetals/controller/splash_controller.dart';
import 'package:royalpetals/core/constants/app_images.dart';
import 'package:royalpetals/views/splash_screen/onboarding_screen.dart';

class SplashView1 extends StatelessWidget {
  const SplashView1({super.key});

  @override
  Widget build(BuildContext context) {
    // We instantiate the controller here so it starts the timer immediately
    Get.put(SplashController()); 

    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(
          "assets/image/splash_1.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
// class SplashView1 extends StatelessWidget {
//   const SplashView1({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         // This triggers when the user taps anywhere on the image
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const OnboardingScreen()),
//           );
//         },
//         child: SizedBox.expand(
//           child: Image.asset(
//             "assets/image/splash_1.png",
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
// }
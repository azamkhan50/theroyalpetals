import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royalpetals/controller/cart_controller.dart';
import 'package:royalpetals/utils/app_routes.dart';
import 'package:royalpetals/views/home/home_screen.dart';
import 'package:royalpetals/views/home/main_navigation.dart';
import 'package:royalpetals/views/home/product_detail_screen.dart';
import 'package:royalpetals/views/product/feature_product_screen.dart';
import 'package:royalpetals/views/profile/profile_screen.dart';
import 'package:royalpetals/widgets/app_bar.dart';
import 'package:royalpetals/widgets/custom_button.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access controller to clear cart if needed
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: RoyalAppBar(
        title: "", // Empty title as per typical success screens
        actions: [
          _buildActionBox(
            child: Image.asset('assets/image/cart2.png'),
            onTap: () =>    Get.toNamed(AppRoutes.cart),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. Success Icon with Fireworks/Confetti
            Stack(
              alignment: Alignment.center,
              children: [
                // You can use a Lottie file here for actual animation
                // or an Image.asset for the background decoration
              
                Container(
                  height: 120,
                  width: 120,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // 2. Success Text
            Text(
              "Your order is successfully\npurchased",
              textAlign: TextAlign.center,
              style: GoogleFonts.cabin(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            // 3. Subtext
            Text(
              "Your order is being prepared to be\nshipped to you on time",
              textAlign: TextAlign.center,
              style: GoogleFonts.cabin(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 50),

            // 4. Continue Shopping Button (Solid)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                   Get.to(FeatureProductScreen());
                   // Get.offAllNamed('/ProductDetailScreen'); // Or navigate to Shop/Category screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC39A38), // Your gold/brown color
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Continue Shopping",
                  style: GoogleFonts.cabin(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // 5. Go Home Button (Outlined/White)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Clear cart before going home
                  cartController.cartItems.clear();
                  cartController.quantities.clear();
                  // Navigate to Home and remove all previous screens
                  Get.to(MainNavigation());
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.grey.shade300),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Go Home",
                  style: GoogleFonts.cabin(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper for the App Bar Action
  Widget _buildActionBox({required Widget child, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Center(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 48,
            width: 48,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black.withOpacity(0.05)),
            ),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
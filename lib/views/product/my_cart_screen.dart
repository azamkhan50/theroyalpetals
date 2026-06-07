import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royalpetals/controller/ShopifyLoginController.dart';
import 'package:royalpetals/controller/cart_controller.dart';
import 'package:royalpetals/utils/app_routes.dart';
import 'package:royalpetals/views/product/personal_information_screen.dart';
import 'package:royalpetals/widgets/action_box.dart';
import 'package:royalpetals/widgets/app_bar.dart';
import 'package:royalpetals/widgets/cart_item.dart';
import 'package:royalpetals/widgets/custom_button.dart';
// Import your custom app bar and cart card
// import 'package:royalpetals/widgets/royal_app_bar.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    // Find the login controller to check status
    final ShopifyLoginController authController = Get.find<ShopifyLoginController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: RoyalAppBar(
        showBackButton: true,
        title: "My Cart",
        actions: [
          ActionBox(child: Image.asset('assets/image/cart2.png'), onTap: () {}),
        ],
      ),
      body: Obx(() {
        // --- LOGIC ADDED HERE ---
        // This ensures that when cartItems loads from SharedPreferences, 
        // the UI automatically switches from "Empty" to your List.
        debugPrint("UI Refresh: Cart has ${cartController.cartItems.length} items");

        return Column(
          children: [
            Expanded(
              child: cartController.cartItems.isEmpty
                  ? const Center(
                      child: Text(
                        "Your cart is empty",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: cartController.cartItems.length,
                      itemBuilder: (context, index) {
                        final product = cartController.cartItems[index];
                        return CartItemCard(
                          item: product,
                          // Access quantity by product ID
                          quantity: cartController.quantities[product.id] ?? 1.obs,
                          onDelete: () => cartController.removeFromCart(index),
                          onIncrement: () => cartController.incrementQty(product.id),
                          onDecrement: () => cartController.decrementQty(product.id),
                        );
                      },
                    ),
            ),
            
            // This part stays visible even if cart is empty, 
            // but the values will update to SAR 0.00
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _priceRow(
                    "Subtotal",
                    "SAR ${cartController.subtotal.toStringAsFixed(2)}",
                  ),
                 // _priceRow("Shipping", "SAR 0"),
                  const Divider(),
                  _priceRow(
                    "Total",
                    "SAR ${cartController.total.toStringAsFixed(2)}",
                    isTotal: true,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    imagePath: "assets/image/creditcard.png",
                    title: "Proceed to Checkout",
                    onPressed: () {
                      if (authController.accessToken.value.isNotEmpty) {
                        Get.to(() => const PersonalInformationScreen());
                      } else {
                        Get.snackbar(
                          "Login Required",
                          "Please login to proceed with checkout",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.orangeAccent,
                          colorText: Colors.white,
                        );
                        Get.toNamed(AppRoutes.login);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  // Helper widget for price rows (keep your existing implementation)
  Widget _priceRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

}
  // class MyCartScreen extends StatelessWidget {
  //   const MyCartScreen({super.key});

  //   @override
  //   Widget build(BuildContext context) {
  //   final CartController cartController = Get.find<CartController>();

  //     return Scaffold(
  //       backgroundColor: const Color(0xFFF9F9F9),
  //       appBar: RoyalAppBar(
  //           showBackButton: true,
  //         title: "My Cart",
  //         actions: [
  //           ActionBox(
  //             child: Image.asset('assets/image/cart2.png'),
  //             onTap: () {},
  //           ),
  //         ],
  //       ),
  //       body: Obx(
  //         () => Column(
  //           children: [
  //             // Scrollable Cart List
  //             Expanded(
  //               child: cartController.cartItems.isEmpty
  //                   ? const Center(child: Text("Your cart is empty"))
  //                   : ListView.builder(
  //                       padding: const EdgeInsets.all(20),
  //                       itemCount: cartController.cartItems.length,
  //                       itemBuilder: (context, index) {
  //                         return CartItemCard(
  //                           item: cartController.cartItems[index],
  //                           quantity: cartController.quantities[index]!,
  //                           onDelete: () => cartController.removeFromCart(index),
  //                           onIncrement: () => cartController.incrementQty(index),
  //                           onDecrement: () => cartController.decrementQty(index),
  //                         );
  //                       },
  //                     ),
  //             ),

  //             // Fixed Bottom Section
  //             Container(
  //               padding: const EdgeInsets.all(20),
  //               decoration: const BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(20),
  //                   topRight: Radius.circular(20),
  //                 ),
  //               ),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   _priceRow(
  //                     "Subtotal",
  //                     "SAR ${cartController.subtotal.toStringAsFixed(2)}",
  //                   ),
  //                   _priceRow("Shipping", "SAR 0"),
  //                   const Divider(),
  //                   _priceRow(
  //                     "Total",
  //                     "SAR ${cartController.total.toStringAsFixed(2)}",
  //                     isTotal: true,
  //                   ),
  //                   const SizedBox(height: 20),
  //                   // ... (Keep your existing payments labels and button)
  //                   CustomButton(
  //                     imagePath: "assets/image/creditcard.png",
  //                     title: "Proceed to Checkout",
  //                     onPressed: () {
  //                       Get.to(() => const PersonalInformationScreen());
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   }

  // Widget _buildActionBox({required Widget child, required VoidCallback onTap}) {
  //   return Padding(
  //     padding: const EdgeInsets.only(right: 10.0),
  //     child: Center(
  //       child: InkWell(
  //         onTap: onTap,
  //         borderRadius: BorderRadius.circular(10),
  //         child: Container(
  //           height: 48,
  //           width: 48,
  //           padding: const EdgeInsets.all(12),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(10),
  //             border: Border.all(color: Colors.black.withOpacity(0.05)),
  //           ),
  //           child: Center(child: child),
  //         ),
  //       ),
  //     ),
  //   );
  // }

//   Widget _priceRow(String label, String value, {bool isTotal = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: GoogleFonts.cabin(
//               fontSize: 15,
//               color: isTotal ? Colors.black : Colors.grey,
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 value,
//                 style: GoogleFonts.cabin(
//                   fontSize: isTotal ? 18 : 15,
//                   fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
//                 ),
//               ),
//               if (isTotal)
//                 Text(
//                   "VAT included",
//                   style: GoogleFonts.cabin(fontSize: 10, color: Colors.grey),
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

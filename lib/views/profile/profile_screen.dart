import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:royalpetals/controller/ShopifyLoginController.dart';
import 'package:royalpetals/utils/app_routes.dart';
import 'package:royalpetals/widgets/action_box.dart';
import 'package:royalpetals/widgets/app_bar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Replace with your actual controller path
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Find the global controller
    final authController = Get.find<ShopifyLoginController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text(
          "Profile",
          style: GoogleFonts.cabin(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // 1. Profile Header
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/image/person.png'),
            ),
            const SizedBox(height: 15),

            // DYNAMIC NAME
            Obx(
              () => Text(
                authController.userName.value,
                style: GoogleFonts.cabin(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            // DYNAMIC EMAIL
            Obx(
              () => Text(
                authController.userEmail.value,
                style: GoogleFonts.cabin(fontSize: 14, color: Colors.grey),
              ),
            ),

            const SizedBox(height: 30),

            // 2. Main Action Grid
            _buildGridSection(),

            const SizedBox(height: 30),

            // 3. Enquiries Section
            _buildEnquiriesSection(authController),

            const SizedBox(height: 40),

            // 4. Footer
            Text(
              "Privacy Policy",
              style: GoogleFonts.cabin(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "App Version 5.2.6",
              style: GoogleFonts.cabin(fontSize: 11, color: Colors.grey),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- Helper Methods ---

  Widget _buildGridSection() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 2.2,
      children: [
        _buildGridItem(Icons.inventory_2_outlined, "My Orders"),
        _buildGridItem(Icons.calendar_today_outlined, "Reminders"),
        _buildGridItem(Icons.chat_bubble_outline, "Chat with Us"),
        _buildGridItem(Icons.location_on_outlined, "Saved Addresses"),
      ],
    );
  }

  Widget _buildGridItem(IconData icon, String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFFC39A38), size: 24),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              title,
              style: GoogleFonts.cabin(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnquiriesSection(ShopifyLoginController auth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enquiries",
          style: GoogleFonts.cabin(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        _buildListItem(Icons.money_outlined, "Currency : SAR"),
        _buildListItem(Icons.lightbulb_outline, "Birthday / Wedding Decor"),
        _buildListItem(Icons.card_giftcard, "Corporate Gifts"),
        _buildListItem(Icons.storefront_outlined, "Become A Partner"),

        // Logout Button
        _buildListItem(
          Icons.logout,
          "Logout",
          onTap: () {
            // Show a confirmation dialog (Optional but recommended)
            Get.defaultDialog(
              title: "Logout",
              middleText: "Are you sure you want to logout?",
              textConfirm: "Yes",
              textCancel: "No",
              confirmTextColor: Colors.white,
              buttonColor: const Color(0xFFC39A38),
              onConfirm: () {
                // CALL THE CONTROLLER METHOD HERE
                auth.logout();
              },
            );
          },
          textColor: Colors.redAccent,
        ),
        // _buildListItem(
        //   Icons.logout,
        //   "Logout",
        //   onTap: () {
        //     // Reset controller data
        //     auth.accessToken.value = "";
        //     auth.userName.value = "Guest User";
        //     auth.userEmail.value = "Not Logged In";

        //     // Navigate to login
        //     Get.offAllNamed(AppRoutes.login);
        //   },
        //   textColor: Colors.redAccent,
        // ),
      ],
    );
  }
Widget _buildListItem(IconData icon, String title, {VoidCallback? onTap, Color? textColor}) {
  return ListTile(
    onTap: onTap,
    leading: Icon(icon, color: textColor ?? Colors.black54),
    title: Text(
      title,
      style: GoogleFonts.cabin(
        fontSize: 14, 
        color: textColor ?? Colors.black,
        fontWeight: FontWeight.w500
      ),
    ),
    trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
  );
}
  // Widget _buildListItem(
  //   IconData icon,
  //   String title, {
  //   VoidCallback? onTap,
  //   Color? textColor,
  // }) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       margin: const EdgeInsets.only(bottom: 10),
  //       padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(4),
  //       ),
  //       child: Row(
  //         children: [
  //           Icon(icon, color: textColor ?? const Color(0xFFC39A38), size: 22),
  //           const SizedBox(width: 15),
  //           Text(
  //             title,
  //             style: GoogleFonts.cabin(
  //               fontSize: 14,
  //               fontWeight: FontWeight.w500,
  //               color: textColor ?? Colors.black,
  //             ),
  //           ),
  //           const Spacer(),
  //           const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F9F9),
//       appBar: RoyalAppBar(
//           showBackButton: false,
//         title: "Profile",
//         actions: [
//           ActionBox(
//             child: Image.asset('assets/image/cart2.png'),
           
//             onTap: () => 
            
//             Get.toNamed(AppRoutes.cart), // Navigate to cart
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
            
//             // 1. Profile Header
//             const CircleAvatar(
//               radius: 50,
//               backgroundImage: AssetImage('assets/image/person.png'), 
//             ),
//             const SizedBox(height: 15),
//             Text(
//               "Haseeb khan",
//               style: GoogleFonts.cabin(
//                 fontSize: 22, 
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black
//               ),
//             ),
//             Text(
//               "Saudi Riyadh",
//               style: GoogleFonts.cabin(
//                 fontSize: 14, 
//                 color: Colors.grey
//               ),
//             ),
//             const SizedBox(height: 30),

//             // 2. Main Action Grid (2x2)
//             GridView.count(
//               crossAxisCount: 2,
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               mainAxisSpacing: 10,
//               crossAxisSpacing: 10,
//               childAspectRatio: 2.2, // Adjust for card height
//               children: [
//                 _buildGridItem(Icons.inventory_2_outlined, "My Orders"),
//                 _buildGridItem(Icons.calendar_today_outlined, "Reminders"),
//                 _buildGridItem(Icons.chat_bubble_outline, "Chat with Us"),
//                 _buildGridItem(Icons.location_on_outlined, "Saved Addresses"),
//               ],
//             ),

//             const SizedBox(height: 30),

//             // 3. Enquiries Section
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 "Enquiries",
//                 style: GoogleFonts.cabin(
//                   fontSize: 18, 
//                   fontWeight: FontWeight.bold
//                 ),
//               ),
//             ),
//             const SizedBox(height: 15),
            
//             _buildListItem(Icons.money_outlined, "Currency : SAR"),
//             _buildListItem(Icons.lightbulb_outline, "Birthday / Wedding Decor"),
//             _buildListItem(Icons.card_giftcard, "Corporate Gifts / Bulk Orders"),
//             _buildListItem(Icons.storefront_outlined, "Become A Partner"),
//             _buildListItem(Icons.thumb_up_alt_outlined, "Share App Feedback"),

//             const SizedBox(height: 40),

//             // 4. Footer Links
//             Text(
//               "Privacy Policy",
//               style: GoogleFonts.cabin(
//                 fontSize: 13, 
//                 fontWeight: FontWeight.bold,
//                 decoration: TextDecoration.underline
//               ),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               "App Version 5.2.6",
//               style: GoogleFonts.cabin(fontSize: 11, color: Colors.grey),
//             ),
//             const SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }

//   // --- Helper Widgets ---

//   // For the 2x2 Grid Items
//   Widget _buildGridItem(IconData icon, String title) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(4), // Slightly rounded as per image
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, color: const Color(0xFFC39A38), size: 24),
//           const SizedBox(width: 10),
//           Flexible(
//             child: Text(
//               title,
//               style: GoogleFonts.cabin(fontSize: 13, fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // For the Vertical Enquiries List
//   Widget _buildListItem(IconData icon, String title) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: const Color(0xFFC39A38), size: 22),
//           const SizedBox(width: 15),
//           Text(
//             title,
//             style: GoogleFonts.cabin(fontSize: 14, fontWeight: FontWeight.w500),
//           ),
//         ],
//       ),
//     );
//   }

//   // Helper for the App Bar Action
  
// }



// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';

// // class ProfileScreen extends StatelessWidget {
// //   const ProfileScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     // Retrieve email passed from previous screen
// //     final String userEmail = Get.arguments ?? "User";

// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Profile"), elevation: 0),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             const Icon(Icons.account_circle, size: 100, color: Color(0xFF005BD3)),
// //             const SizedBox(height: 20),
// //             Text(userEmail, style: const TextStyle(fontSize: 20, color: Colors.grey)),
// //             const SizedBox(height: 40),
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 40),
// //               child: ElevatedButton(
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.redAccent,
// //                   minimumSize: const Size(double.infinity, 50),
// //                 ),
// //                 onPressed: () => Get.offAllNamed('/login'), // Logout and clear stack
// //                 child: const Text("Logout", style: TextStyle(color: Colors.white)),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
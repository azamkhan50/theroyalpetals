import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royalpetals/controller/ProductController.dart';
// import 'your_path/product_controller.dart';
class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Correctly finds the controller initialized in FeatureProductScreen
    final ProductController controller = Get.find<ProductController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03), 
              blurRadius: 10
            )
          ],
        ),
        child: TextField(
          // CONNECT LOGIC HERE:
          onChanged: (value) => controller.filterProducts(value), 
          decoration: InputDecoration(
            hintText: "Search for Products",
            hintStyle: GoogleFonts.cabin(color: Colors.grey, fontSize: 14),
            prefixIcon: const Icon(Icons.search, color: Color(0xFFC39A38)), 
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }
}
// class SearchBarWidget extends StatelessWidget {
//   const SearchBarWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Find the controller
//     final ProductController controller = Get.find<ProductController>();

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
//         ),
//         child: TextField(
//         //  onChanged: (value) => controller.filterSearch(value), // Call search logic
//           decoration: InputDecoration(
//             hintText: "Search for Products",
//             hintStyle: GoogleFonts.cabin(color: Colors.grey, fontSize: 14),
//             prefixIcon: const Icon(Icons.search, color: Color(0xFFC39A38)), // brandGold
//             border: InputBorder.none,
//             contentPadding: const EdgeInsets.symmetric(vertical: 15),
//           ),
//         ),
//       ),
//     );
//   }
// }


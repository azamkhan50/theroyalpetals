 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royalpetals/views/product/feature_product_screen.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: GoogleFonts.cabin(fontSize: 16, fontWeight: FontWeight.w400)),
          GestureDetector(
            onTap: () => Get.to(() => FeatureProductScreen()), // Navigate to the feature product screen
            child: Text("See All", style: GoogleFonts.cabin(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey))),
        ],
      ),
    );
  }
}

// class SectionHeader extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final bool centerAlign;

//   const SectionHeader({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     this.centerAlign = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
//       child: Column(
//         crossAxisAlignment:
//             centerAlign ? CrossAxisAlignment.center : CrossAxisAlignment.start,
//         children: [
//           Text(
//             title.toUpperCase(),
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.w400,
//               color: const Color(0xFFD4AF37),
//               letterSpacing: 2,
//               fontFamily: 'Georgia',
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             subtitle,
//             textAlign: centerAlign ? TextAlign.center : TextAlign.left,
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.black87,
//               height: 1.5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
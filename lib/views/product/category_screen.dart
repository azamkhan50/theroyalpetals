import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royalpetals/utils/app_routes.dart';
import 'package:royalpetals/widgets/action_box.dart';
import 'package:royalpetals/widgets/app_bar.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Brand Colors from Figma
    const Color brandGold = Color(0xFFC39A38);
    const Color bgGrey = Color(0xFFFBFBFB);
    const Color textGrey = Color(0xFF6F6F6F);

    // Category Data List
    // final List<Map<String, String>> categories = [
    //   {
    //     "title": "RAMADAN GIFTS",
    //     "sub": "Thoughtful gifts to share the blessings of Ramadan.",
    //     "image": "assets/image/category1.png"
    //   },
    //   {
    //     "title": "LOVE & ROMANCE",
    //     "sub": "Perfect gifts to express your love and affection.",
    //     "image": "assets/image/category2.png"
    //   },
    //   {
    //     "title": "BIRTHDAY GIFTS",
    //     "sub": "Make every birthday celebration extra special.",
    //     "image": "assets/image/category3.png"
    //   },
    //   {
    //     "title": "EID DAY GIFTS",
    //     "sub": "Joyful gifts to celebrate the spirit of Eid.",
    //     "image": "assets/image/category4.png"
    //   },
    //   {
    //     "title": "GET WELL SOON",
    //     "sub": "Send comfort, care, and warm wishes.",
    //     "image": "assets/image/category5.png"
    //   },
    // ];
    final List<String> categoryImages = [
      "assets/image/category1.png",
      "assets/image/category2.png",
      "assets/image/category3.png",
      "assets/image/category4.png",
      "assets/image/category5.png",
    ];

    return Scaffold(
      backgroundColor: Colors.white,
        appBar: RoyalAppBar(
         showBackButton: false,
        title: "Categories", // Changed from My Cart to match the process
        actions: [
          ActionBox(
            child: Image.asset('assets/image/search.png'),
            onTap: () => Get.back(),
          ),
        ],
      ),
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   leading: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: CircleAvatar(
      //       backgroundColor: bgGrey,
      //       child: IconButton(
      //         icon: const Icon(Icons.arrow_back, color: brandGold, size: 20),
      //         onPressed: () => Navigator.pop(context),
      //       ),
      //     ),
      //   ),
      //   title: Text(
      //     "Categories",
      //     style: GoogleFonts.cabin(
      //       color: brandGold,
      //       fontWeight: FontWeight.w600,
      //       fontSize: 20,
      //     ),
      //   ),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.search, color: brandGold),
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
      body: Column(
        children: [
          // 1. Tab Selection (Shop by Moments / Shop by Combos)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                _buildTabButton("Shop by Moments", true, brandGold),
                const SizedBox(width: 10),
                _buildTabButton("Shop by Combos", false, brandGold),
              ],
            ),
          ),

          // 2. Responsive Category List
          Expanded(
            child:
            ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: categoryImages.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.featured);
             
            },
            child: Container(
              height: 160, // Height adjusted for better image visibility
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(categoryImages[index]),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.center, // Center the image
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    
            //  ListView.builder(
            //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //   itemCount: categories.length,
            //   itemBuilder: (context, index) {
            //     final cat = categories[index];
            //     return Container(
            //       height: 140, // Fixed height for a banner look
            //       margin: const EdgeInsets.only(bottom: 15),
            //       decoration: BoxDecoration(
            //         color: bgGrey,
            //         borderRadius: BorderRadius.circular(15),
            //         image: DecorationImage(
            //           image: AssetImage(cat["image"]!),
            //           fit: BoxFit.cover,
            //           alignment: Alignment.centerRight, // Image on the right
            //         ),
            //       ),
            //       child: Container(
            //         padding: const EdgeInsets.all(20),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(15),
            //           gradient: LinearGradient(
            //             colors: [
            //               bgGrey.withOpacity(0.9),
            //               bgGrey.withOpacity(0.0),
            //             ],
            //             begin: Alignment.centerLeft,
            //             end: Alignment.centerRight,
            //           ),
            //         ),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             SizedBox(
            //               width: MediaQuery.of(context).size.width * 0.45,
            //               child: Text(
            //                 cat["title"]!,
            //                 style: GoogleFonts.cinzel( // Using serif-style for headers
            //                   fontSize: 18,
            //                   fontWeight: FontWeight.bold,
            //                   letterSpacing: 1.2,
            //                 ),
            //               ),
            //             ),
            //             const SizedBox(height: 5),
            //             SizedBox(
            //               width: MediaQuery.of(context).size.width * 0.4,
            //               child: Text(
            //                 cat["sub"]!,
            //                 style: GoogleFonts.cabin(
            //                   fontSize: 12,
            //                   color: textGrey,
            //                   height: 1.3,
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     );
            //   },
            // ),
          ),
        ],
      ),
    );
  }

  // Helper widget for the top tabs
  Widget _buildTabButton(String label, bool isSelected, Color gold) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? gold : Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: isSelected ? gold : Colors.grey.shade200),
      ),
      child: Text(
        label,
        style: GoogleFonts.cabin(
          fontSize: 13,
          color: isSelected ? Colors.white : Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
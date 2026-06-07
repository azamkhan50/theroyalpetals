import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Ensure Get is imported
import 'package:google_fonts/google_fonts.dart';
import 'package:royalpetals/controller/ProductController.dart';
import 'package:royalpetals/widgets/action_box.dart';
import 'package:royalpetals/widgets/all_product_widget.dart' show AllProducts;
import 'package:royalpetals/widgets/app_bar.dart';
import 'package:royalpetals/widgets/category_widget.dart';
import 'package:royalpetals/widgets/searchbarwidget.dart' show SearchBarWidget;
// Import your controller file here
// import 'package:royalpetals/controllers/product_controller.dart'; 

class FeatureProductScreen extends StatelessWidget {
  const FeatureProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // FIX: Initialize the controller here so AllProducts can find it
    Get.put(ProductController()); 

    const Color brandGold = Color(0xFFC39A38);
    const Color bgGrey = Color(0xFFFBFBFB);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: RoyalAppBar(
        title: "Featured Products", // Changed from My Cart to match the process
        actions: [
          // ActionBox(
          //   child: Image.asset('assets/image/search.png'),
          //   onTap: () => Get.back(),
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            CategoryFilterRow(),
            const SizedBox(height: 10),
            const SearchBarWidget(),
            const SizedBox(height: 10),
            // Now AllProducts will successfully find the controller
            const AllProducts(), 
          ],
        ),
      ),
    );
  }
}
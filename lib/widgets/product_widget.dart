import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royalpetals/controller/ProductController.dart';
import 'package:royalpetals/views/product/product_detail_screen.dart';

class ProductHorizontalList extends StatelessWidget {
  const ProductHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find<ProductController>();

    return SizedBox(
      height: 280,
      child: Obx(() {
        // Show loader while fetching category data
        if (controller.isFilterLoading.value || controller.isInitialLoading.value) {
    return const Center(child: CircularProgressIndicator());
  }
        // if (controller.isFilterLoading.value) {
        //   return const Center(child: CircularProgressIndicator());
        // }

        // CRITICAL CHANGE: Use filteredProducts instead of allProducts
        final listToShow = controller.filteredProducts;

        if (listToShow.isEmpty) {
          return const Center(child: Text("No products found in this category"));
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 20, top: 15),
          itemCount: listToShow.length,
          itemBuilder: (context, index) {
            final product = listToShow[index];

            return GestureDetector(
              onTap: () => Get.to(() => ProductDetailScreen(product: product)),
              child: Container(
                width: 170,
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBFBFB),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        product.images.isNotEmpty 
                          ? product.images.first.originalSrc 
                          : 'https://via.placeholder.com/160',
                        height: 160,
                        width: 160,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.cabin(fontSize: 12, color: const Color(0xFF6F6F6F)),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.formattedPrice,
                      style: GoogleFonts.cabin(fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
// class ProductHorizontalList extends StatelessWidget {
//   const ProductHorizontalList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // 1. Get the controller instance
//     final ProductController controller = Get.find<ProductController>();

//     return SizedBox(
//       height: 280,
//       child: Obx(() {
//         // 2. Show a loader while products are fetching
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         // 3. Show a message if no products exist
//         if (controller.allProducts.isEmpty) {
//           return const Center(child: Text("No products found"));
//         }

//         return ListView.builder(
//           scrollDirection: Axis.horizontal,
//           padding: const EdgeInsets.only(left: 20, top: 15),
//           itemCount: controller.allProducts.length, 
//           itemBuilder: (context, index) {
//             // 4. Use the real Shopify Product model
//             final product = controller.allProducts[index];

//             return GestureDetector(
//               onTap: () {
//                 // Pass the real product object to your detail screen
//                 Get.to(() => ProductDetailScreen(product: product));
//               },
//               child: Container(
//                 width: 170,
//                 margin: const EdgeInsets.only(right: 15),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFFBFBFB),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: Image.network(
//                         // 5. Use Network Image for Shopify images
//                         product.images.isNotEmpty 
//                           ? product.images.first.originalSrc 
//                           : 'https://via.placeholder.com/160',
//                         height: 160,
//                         width: 160,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       product.title, // Real title
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: GoogleFonts.cabin(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                         color: const Color(0xFF6F6F6F),
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       // 6. Use formatted price (e.g., SAR 350.00)
//                       product.formattedPrice, 
//                       style: GoogleFonts.cabin(
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
// class ProductHorizontalList extends StatelessWidget {
//   const ProductHorizontalList({super.key});

//   @override
//   Widget build(BuildContext context) {
//      final ProductController controller = Get.find<ProductController>();
//     // 1. Create your data list
//     final List<Map<String, String>> products = [
//       {
//         "image": "assets/image/product1.png",
//         "title": "Chocolates Box and Red Roses Bouquet",
//         "price": "SAR 350.00",
//         "description":
//             "An extraordinary bouquet featuring 200 premium red roses beautifully arranged in a luxurious dome shape and wrapped in elegant cream paper with gold detailing. This breathtaking arrangement represents deep love, passion, and grand romantic gestures. Perfect for proposals, anniversaries, weddings, and unforgettable surprises, this stunning 200-rose bouquet creates a powerful statement of devotion and elegance. 🌹❤️✨",
//       },
//       {
//         "image": "assets/image/product2.png",
//         "title": "Premium Mixed Flower Box",
//         "price": "SAR 280.00",
//         "description":
//             "An extraordinary bouquet featuring 200 premium red roses beautifully arranged in a luxurious dome shape and wrapped in elegant cream paper with gold detailing. This breathtaking arrangement represents deep love, passion, and grand romantic gestures. Perfect for proposals, anniversaries, weddings, and unforgettable surprises, this stunning 200-rose bouquet creates a powerful statement of devotion and elegance. 🌹❤️✨",
//       },
//       {
//         "image": "assets/image/product1.png", // Reusing for example
//         "title": "Luxury Red Rose Arrangement",
//         "price": "SAR 450.00",
//         "description":
//             "An extraordinary bouquet featuring 200 premium red roses beautifully arranged in a luxurious dome shape and wrapped in elegant cream paper with gold detailing. This breathtaking arrangement represents deep love, passion, and grand romantic gestures. Perfect for proposals, anniversaries, weddings, and unforgettable surprises, this stunning 200-rose bouquet creates a powerful statement of devotion and elegance. 🌹❤️✨",
//       },
//     ];

//     return SizedBox(
//       height: 280, // Increased height slightly to prevent overflow
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.only(left: 20, top: 15),
//         itemCount: products.length, // Call length from list
//         itemBuilder: (context, index) {
//           // 2. Extract data for the current item
//           final product = products[index];

//           return GestureDetector(
//             onTap: () {
//               // Navigation to detail screen using GetX
//               Get.to(() => ProductDetailScreen(product: product));
//             },
//             child: Container(
//               width: 170,
//               margin: const EdgeInsets.only(right: 15),
//               // Apply the background color here
//               decoration: BoxDecoration(
//                 color: const Color(0xFFFBFBFB), // Main screen background
//                 borderRadius: BorderRadius.circular(
//                   10,
//                 ), // Optional: rounds the background corners
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.asset(
//                       product["image"]!,
//                       height: 160,
//                       width: 160,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     product["title"]!,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: GoogleFonts.cabin(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: const Color(
//                         0xFF6F6F6F,
//                       ), // Specific grey: rgba(111, 111, 111, 1)
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     product["price"]!,
//                     style: GoogleFonts.cabin(
//                       fontWeight: FontWeight.w400,
//                       fontSize: 14,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
          
//         },
//       ),
//     );
//   }
// }

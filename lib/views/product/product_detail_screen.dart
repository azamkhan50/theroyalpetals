// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:royalpetals/controller/cart_controller.dart' show CartController;
// import 'package:royalpetals/views/product/my_cart_screen.dart';
// import 'package:royalpetals/widgets/custom_button.dart';

// import '../../widgets/app_bar.dart';

// class ProductDetailScreen extends StatelessWidget {
//   final dynamic product;

//   // Initialize Controller
// final CartController cartController = Get.find<CartController>();
//  ProductDetailScreen({super.key, required this.product});
  
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
//   @override
//   Widget build(BuildContext context) {
//     // Custom Colors from your design
//     const Color brandGold = Color(0xFFC39A38);
//     const Color textGrey = Color(0xFF6F6F6F);
//     const Color bgGrey = Color(0xFFFBFBFB);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar:RoyalAppBar(
//   title: "Product",
//   actions: [
//     // --- First Action: Favorite ---
//     _buildActionBox(
//       child: const Icon(Icons.favorite_border, color: Colors.red, size: 20),
//       onTap: () => print("Favorite clicked"),
//     ),
    
//     // --- Second Action: Share ---
//     _buildActionBox(
//       child: Image.asset('assets/image/share.png'), // Figma image
//       onTap: () => print("Share clicked"),
//     ),
//   ],
// ),
      
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 1. Product Image
//             Container(
//               width: double.infinity,
//               height: MediaQuery.of(context).size.height * 0.4,
//               margin: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 image: DecorationImage(
//                   image:NetworkImage( product.image.first.originalSrc,),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),

//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // 2. Title
//                   Text(
//                     product.tit!,
//                     style: GoogleFonts.cabin(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 10),

//                   // 3. Price
//                   Text(
//                     product["price"]!,
//                     style: GoogleFonts.cabin(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
                  
//                   const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 15),
//                     child: Divider(color: Colors.black12),
//                   ),

//                   // 4. Description Section
//                   Text(
//                     "Product Description",
//                     style: GoogleFonts.cabin(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     product["description"]!,
//                     style: GoogleFonts.cabin(
//                       fontSize: 14,
//                       color: textGrey,
//                       height: 1.5,
//                     ),
//                   ),

//                   const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 15),
//                     child: Divider(color: Colors.black12),
//                   ),

//                   // 5. Payments Section
//                   Text(
//                     "Payments",
//                     style: GoogleFonts.cabin(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     "Credit card or cash on delivery",
//                     style: GoogleFonts.cabin(
//                       fontSize: 14,
//                       color: textGrey,
//                     ),
//                   ),
//                     const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 15),
//                     child: Divider(color: Colors.black12),
//                   ),
                 
//                   // Space for the floating button
//                   CustomButton(
//                   imagePath: "assets/image/addcart.png",
//                   title: "Add to Cart",
//                   onPressed: () {
//                     cartController.addToCart(product);
//                     // Get.to(() => MyCartScreen());
//                   },
//                 ),
//                    const SizedBox(height: 50), 
//                 ],
//               ),
//             ),
             
//           ],
//         ),
//       ),
      
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royalpetals/controller/ProductController.dart';
import 'package:royalpetals/controller/cart_controller.dart';
import 'package:royalpetals/model/favorites_provider.dart';
import 'package:royalpetals/widgets/action_box.dart';
import 'package:royalpetals/widgets/app_bar.dart';
import 'package:shopify_flutter/models/src/product/product.dart';
import '../../widgets/custom_button.dart'; // Ensure correct import
// import 'package:royalpetals/controller/CartController.dart'; 

class ProductDetailScreen extends StatelessWidget {
  //final dynamic product; // This is the Product object passed from AllProducts
final Product product;
  ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Find the CartController
    final CartController cartController = Get.find<CartController>();

    const Color textGrey = Color(0xFF6F6F6F);
final ProductController productController = Get.find<ProductController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: RoyalAppBar(
        title: "Product",
        actions: [
         Obx(() {
            bool isFav = productController.isProductFavorite(product.id);
            return ActionBox(
              child: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
                size: 20,
              ),
              onTap: () => productController.toggleFav(product),
            );
          }),
          ActionBox(
            child: Image.asset('assets/image/share.png'),
            onTap: () => print("Share clicked"),
          ),
        ],
        // actions: [
        //   ActionBox(
        //     child: const Icon(Icons.favorite_border, color: Colors.red, size: 20),
        //     onTap: () => print("Favorite clicked"),
        //   ),
        //   ActionBox(
        //     child: Image.asset('assets/image/share.png'),
        //     onTap: () => print("Share clicked"),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Product Image (Updated to use Shopify Image URL)
            Container(
  width: double.infinity,
  height: MediaQuery.of(context).size.height * 0.4,
  margin: const EdgeInsets.all(16),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: CachedNetworkImage(
      imageUrl: product.images.first.originalSrc,
      fit: BoxFit.cover,
      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    ),
  ),
),
            // Container(
            //   width: double.infinity,
            //   height: MediaQuery.of(context).size.height * 0.4,
            //   margin: const EdgeInsets.all(16),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(20),
            //     image: DecorationImage(
            //       image: NetworkImage(product.images.first.originalSrc),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Title (Using dot notation)
                  Text(
                    product.title ?? "No Title",
                    style: GoogleFonts.cabin(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // 3. Price (Using the price property from your model)
                  Text(
                    "SAR ${product.price}",
                    style: GoogleFonts.cabin(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(color: Colors.black12),
                  ),

                  // 4. Description Section (Using dot notation)
                  Text(
                    "Product Description",
                    style: GoogleFonts.cabin(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description ?? "No description available.",
                    style: GoogleFonts.cabin(
                      fontSize: 14,
                      color: textGrey,
                      height: 1.5,
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(color: Colors.black12),
                  ),

                  // 5. Payments Section
                  Text(
                    "Payments",
                    style: GoogleFonts.cabin(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Credit card or cash on delivery",
                    style: GoogleFonts.cabin(
                      fontSize: 14,
                      color: textGrey,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(color: Colors.black12),
                  ),
                  
                  // 6. Add to Cart Button
                  const SizedBox(height: 10),
                  CustomButton(
                    imagePath: "assets/image/addcart.png",
                    title: "Add to Cart",
                    onPressed: () {
                      cartController.addToCart(product);
                      // Get.snackbar("Success", "Added to cart");
                    },
                  ),
                  const SizedBox(height: 50), 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
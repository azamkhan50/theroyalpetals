import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royalpetals/controller/ProductController.dart';
import 'package:royalpetals/model/favorites_provider.dart';
import 'package:royalpetals/views/home/product_detail_screen.dart';
import 'package:royalpetals/views/product/product_detail_screen.dart'
    show ProductDetailScreen;
import 'package:royalpetals/widgets/app_bar.dart';



class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: RoyalAppBar(title: "Favorites"),
      // Obx makes the list refresh instantly when a favorite is removed
      body: Obx(() {
        if (productController.favoriteProducts.isEmpty) {
          return const Center(child: Text("Your favorites list is empty!"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: productController.favoriteProducts.length,
          itemBuilder: (context, index) {
            final product = productController.favoriteProducts[index];
            return Card(
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.images.first.originalSrc,
                    width: 60, height: 60, fit: BoxFit.cover,
                  ),
                ),
                title: Text(product.title),
                subtitle: Text(product.formattedPrice),
                trailing: IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () => productController.toggleFav(product),
                ),
                onTap: () => Get.to(() => ProductDetailScreen(product: product)),
              ),
            );
          },
        );
      }),
    );
  }
}
// class FavoritesScreen extends StatefulWidget {
//   const FavoritesScreen({super.key});

//   @override
//   State<FavoritesScreen> createState() => _FavoritesScreenState();
// }

// class _FavoritesScreenState extends State<FavoritesScreen> {
//   @override
//   Widget build(BuildContext context) {
//     // Get the current list of favorites
//     final favorites = FavoritesManager.favoriteProducts;

//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F9F9),
//       appBar: RoyalAppBar(
//         showBackButton: false,
//         title: "Favorites", // Changed from My Cart to match the process
//         actions: [
//           // ActionBox(
//           //   child: Image.asset('assets/image/cart2.png'),
//           //   onTap: () => Get.back(),
//           // ),
//         ],
//       ),
//       body: favorites.isEmpty
//           ? const Center(child: Text("Your favorites list is empty!"))
//           : ListView.builder(
//               padding: const EdgeInsets.all(10),
//               itemCount: favorites.length,
//               itemBuilder: (context, index) {
//                 final product = favorites[index];

//                 return Card(
//                   margin: const EdgeInsets.only(bottom: 12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: ListTile(
//                     contentPadding: const EdgeInsets.all(10),
//                     leading:
//                     ClipRRect(
//   borderRadius: BorderRadius.circular(8),
//   child: CachedNetworkImage( // Use this instead of Image.network
//     imageUrl: product.images.first.originalSrc,
//     width: 60,
//     height: 60,
//     fit: BoxFit.cover,
//     placeholder: (context, url) => Container(color: Colors.grey[200]),
//     errorWidget: (context, url, error) => const Icon(Icons.error),
//   ),
// ),
//                     //  ClipRRect(
//                     //   borderRadius: BorderRadius.circular(8),
//                     //   child: Image.network(
//                     //     product.images.first.originalSrc,
//                     //     width: 60,
//                     //     height: 60,
//                     //     fit: BoxFit.cover,
//                     //   ),
//                     // ),
//                     title: Text(
//                       product.title,
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text(
//                       product.formattedPrice,
//                       style: const TextStyle(
//                         color: Colors.pink,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     // REMOVE BUTTON: Replaced arrow with a delete/favorite icon
//                     // ... inside your _FavoritesScreenState
//                     trailing: IconButton(
//                       icon: const Icon(Icons.favorite, color: Colors.red),
//                       onPressed: () async {
//                         setState(() {
//                           FavoritesManager.toggleFavorite(product);
//                         });

//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text("Removed from Favorites"),
//                             duration: Duration(seconds: 1),
//                           ),
//                         );
//                       },
//                     ),
//                     onTap: () =>
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) =>
//                                 ProductDetailScreen(product: product),
//                           ),
//                         ).then((value) {
//                           // Refresh screen when coming back from detail screen
//                           // in case they unfavorited it there
//                           setState(() {});
//                         }),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }















// // import 'package:flutter/material.dart';
// // import 'package:royalpetals/model/favorites_provider.dart';
// // import 'package:royalpetals/views/home/product_detail_screen.dart';

// // class FavoritesScreen extends StatelessWidget {
// //   const FavoritesScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("My Favorites"), centerTitle: true),
// //       body: FavoritesManager.favoriteProducts.isEmpty
// //           ? const Center(child: Text("No favorites yet!"))
// //           : ListView.builder(
// //               padding: const EdgeInsets.all(10),
// //               itemCount: FavoritesManager.favoriteProducts.length,
// //               itemBuilder: (context, index) {
// //                 final product = FavoritesManager.favoriteProducts[index];
// //                 return Card(
// //                   child: ListTile(
// //                     leading: Image.network(product.images.first.originalSrc, width: 50),
// //                     title: Text(product.title),
// //                     subtitle: Text(product.formattedPrice),
// //                     trailing: const Icon(Icons.arrow_forward_ios),
// //                     onTap: () => Navigator.push(
// //                       context,
// //                       MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)),
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //     );
// //   }
// // }
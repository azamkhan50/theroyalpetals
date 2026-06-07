// import 'package:flutter/material.dart';
// import 'package:royalpetals/model/favorites_provider.dart';
// import 'package:royalpetals/views/home/main_navigation_screen.dart';
// import 'package:royalpetals/widgets/cart_manager.dart';
// import 'package:royalpetals/widgets/quantity_selector.dart';

// class ProductDetailScreen extends StatefulWidget {
//   final dynamic product;
//   const ProductDetailScreen({super.key, required this.product});

//   @override
//   State<ProductDetailScreen> createState() => _ProductDetailScreenState();
// }

// class _ProductDetailScreenState extends State<ProductDetailScreen> {
//   int _quantity = 1; // Manage quantity state

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: Container(
//           margin: const EdgeInsets.all(8),
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             shape: BoxShape.circle,
//           ),
//           child: const BackButton(color: Colors.black),
//         ),
//         actions: [
//           Container(
//             margin: const EdgeInsets.all(8),
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//             ),
//             child: IconButton(
//               icon: Icon(
//                 FavoritesManager.isFavorite(widget.product)
//                     ? Icons.favorite
//                     : Icons.favorite_border,
//                 color: Colors.red,
//               ),
//               onPressed: () => setState(
//                 () => FavoritesManager.toggleFavorite(widget.product),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 // 1. Image Header
//                 Image.network(
//                   widget.product.images.first.originalSrc,
//                   width: double.infinity,
//                   height: screenHeight * 0.45,
//                   fit: BoxFit.cover,
//                 ),

//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(
//                     20,
//                     20,
//                     20,
//                     100,
//                   ), // Bottom padding for button space
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.product.title,
//                         style: const TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         widget.product.formattedPrice,
//                         style: const TextStyle(
//                           fontSize: 20,
//                           color: Colors.pink,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),

//                       const Divider(height: 40, thickness: 1),

//                       // Description Tab
//                       _buildTabHeader("Description"),
//                       const SizedBox(height: 25),

//                       _buildDynamicDescription(
//                         widget.product.description ?? "",
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // 2. The Bottom Action Bar (Add to Cart)
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border(top: BorderSide(color: Colors.grey.shade200)),
//               ),
//               child: Row(
//                 children: [
//                   // Quantity Selector
//                   QuantitySelector(
//                     quantity: _quantity,
//                     onIncrement: () => setState(() => _quantity++),
//                     onDecrement: () {
//                       if (_quantity > 1) setState(() => _quantity--);
//                     },
//                   ),
//                   const SizedBox(width: 15),
//                   // Add to Cart Button
//                   Expanded(
//                     child: SizedBox(
//                       height: 50,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.black, // Matching your image
//                           shape: StadiumBorder(), // Pill shape
//                           elevation: 0,
//                         ),
//                         onPressed: () {
//                           CartManager.addToCart(widget.product, _quantity);

//                           // ✅ Navigate to Cart tab
//                           Navigator.pushAndRemoveUntil(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   const MainNavigationScreen(initialIndex: 2),
//                             ),
//                             (route) => false,
//                           );
//                           // Handle Add to Cart logic here
//                         },
//                         child: const Text(
//                           "Add To Cart",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTabHeader(String title) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//         ),
//         const SizedBox(height: 4),
//         Container(height: 2, width: 90, color: Colors.black),
//       ],
//     );
//   }

//   // Your dynamic description parser
//   Widget _buildDynamicDescription(String description) {
//     List<String> lines = description.split('\n');
//     List<Widget> descriptionWidgets = [];
//     for (var line in lines) {
//       String trimmedLine = line.trim();
//       if (trimmedLine.isEmpty) continue;
//       if (trimmedLine.startsWith('•') ||
//           trimmedLine.startsWith('*') ||
//           trimmedLine.startsWith('-')) {
//         String cleanText = trimmedLine.replaceFirst(RegExp(r'[•*-]\s*'), '');
//         descriptionWidgets.add(_bulletPoint(cleanText));
//       } else if (trimmedLine.toLowerCase().contains('includes:')) {
//         descriptionWidgets.add(
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 12.0),
//             child: Row(
//               children: [
//                 const Icon(Icons.auto_awesome, color: Colors.amber, size: 20),
//                 const SizedBox(width: 8),
//                 Text(
//                   trimmedLine,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       } else {
//         descriptionWidgets.add(
//           Padding(
//             padding: const EdgeInsets.only(bottom: 12.0),
//             child: Text(
//               trimmedLine,
//               style: const TextStyle(
//                 fontSize: 15,
//                 height: 1.5,
//                 color: Colors.black87,
//               ),
//             ),
//           ),
//         );
//       }
//     }
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: descriptionWidgets,
//     );
//   }

//   Widget _bulletPoint(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             " • ",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               text,
//               style: const TextStyle(
//                 fontSize: 15,
//                 color: Colors.black87,
//                 height: 1.4,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// //2


// // class ProductDetailScreen extends StatefulWidget {
// //   final dynamic product; // Replace dynamic with your Product model
// //   const ProductDetailScreen({super.key, required this.product});

// //   @override
// //   State<ProductDetailScreen> createState() => _ProductDetailScreenState();
// // }

// // class _ProductDetailScreenState extends State<ProductDetailScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     double screenHeight = MediaQuery.of(context).size.height;

// //     return Scaffold(
// //       extendBodyBehindAppBar: true,
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         elevation: 0,
// //         leading: const BackButton(color: Colors.black),
// //         actions: [
// //           IconButton(
// //             icon: Icon(
// //               // Assuming FavoritesManager is defined in your project
// //               FavoritesManager.isFavorite(widget.product) ? Icons.favorite : Icons.favorite_border,
// //               color: Colors.red,
// //             ),
// //             onPressed: () {
// //               setState(() {
// //                 FavoritesManager.toggleFavorite(widget.product);
// //               });
// //             },
// //           )
// //         ],
// //       ),
// //       body: SingleChildScrollView(
// //         child: Column(
// //           children: [
// //             // Product Image Section
// //             Image.network(
// //               widget.product.images.first.originalSrc,
// //               width: double.infinity,
// //               height: screenHeight * 0.45,
// //               fit: BoxFit.cover,
// //             ),
            
// //             Padding(
// //               padding: const EdgeInsets.all(20),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   // Title
// //                   Text(
// //                     widget.product.title,
// //                     style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// //                   ),
// //                   const SizedBox(height: 8),
                  
// //                   // Price
// //                   Text(
// //                     widget.product.formattedPrice,
// //                     style: const TextStyle(fontSize: 20, color: Colors.pink, fontWeight: FontWeight.w600),
// //                   ),
                  
// //                   const Divider(height: 40, thickness: 1),

// //                   // Custom Description Tab
// //                   Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       const Text(
// //                         "Description",
// //                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
// //                       ),
// //                       const SizedBox(height: 4),
// //                       Container(height: 2, width: 90, color: Colors.black),
// //                     ],
// //                   ),
                  
// //                   const SizedBox(height: 25),

// //                   // The Structured Description
// //                   _buildDynamicDescription(widget.product.description ?? "No description available."),

// //                   const SizedBox(height: 40),

// //                   // Red Buy Button
// //                   SizedBox(
// //                     width: double.infinity,
// //                     height: 55,
// //                     child: ElevatedButton(
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: Colors.red,
// //                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
// //                         elevation: 0,
// //                       ),
// //                       onPressed: () {},
// //                       child: const Text(
// //                         "Buy It Now",
// //                         style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
// //                       ),
// //                     ),
// //                   ),
// //                   const SizedBox(height: 20),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // This widget mimics the layout in your image
// //  Widget _buildDynamicDescription(String description) {
// //   // Split the text by new lines to identify paragraphs and bullet points
// //   List<String> lines = description.split('\n');
// //   List<Widget> descriptionWidgets = [];

// //   for (var line in lines) {
// //     String trimmedLine = line.trim();
// //     if (trimmedLine.isEmpty) continue;

// //     // Check if the line is a bullet point (starts with •, *, or -)
// //     if (trimmedLine.startsWith('•') || trimmedLine.startsWith('*') || trimmedLine.startsWith('-')) {
// //       // Remove the symbol and show as a bullet point
// //       String cleanText = trimmedLine.replaceFirst(RegExp(r'[•*-]\s*'), '');
// //       descriptionWidgets.add(_bulletPoint(cleanText));
// //     } 
// //     // Check if it's the "Includes" header
// //     else if (trimmedLine.toLowerCase().contains('includes:')) {
// //       descriptionWidgets.add(
// //         Padding(
// //           padding: const EdgeInsets.symmetric(vertical: 12.0),
// //           child: Row(
// //             children: [
// //               const Icon(Icons.auto_awesome, color: Colors.amber, size: 20),
// //               const SizedBox(width: 8),
// //               Text(
// //                 trimmedLine,
// //                 style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //               ),
// //             ],
// //           ),
// //         ),
// //       );
// //     } 
// //     // Otherwise, treat it as a normal paragraph
// //     else {
// //       descriptionWidgets.add(
// //         Padding(
// //           padding: const EdgeInsets.only(bottom: 12.0),
// //           child: Text(
// //             trimmedLine,
// //             style: const TextStyle(fontSize: 15, height: 1.5, color: Colors.black87),
// //           ),
// //         ),
// //       );
// //     }
// //   }

// //   return Column(
// //     crossAxisAlignment: CrossAxisAlignment.start,
// //     children: descriptionWidgets,
// //   );
// // }

// // // The bullet point UI helper
// // Widget _bulletPoint(String text) {
// //   return Padding(
// //     padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
// //     child: Row(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const Text(" • ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// //         const SizedBox(width: 8),
// //         Expanded(
// //           child: Text(
// //             text,
// //             style: const TextStyle(fontSize: 15, color: Colors.black87, height: 1.4),
// //           ),
// //         ),
// //       ],
// //     ),
// //   );
// // }
// // }

// //1
// // class ProductDetailScreen extends StatefulWidget {
// //   final Product product;
// //   const ProductDetailScreen({super.key, required this.product});

// //   @override
// //   State<ProductDetailScreen> createState() => _ProductDetailScreenState();
// // }

// // class _ProductDetailScreenState extends State<ProductDetailScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     // Dynamic height based on device size
// //     double screenHeight = MediaQuery.of(context).size.height;

// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         actions: [
// //           IconButton(
// //             icon: Icon(
// //               FavoritesManager.isFavorite(widget.product) ? Icons.favorite : Icons.favorite_border,
// //               color: Colors.red,
// //             ),
// //             onPressed: () {
// //               setState(() {
// //                 FavoritesManager.toggleFavorite(widget.product);
// //               });
// //             },
// //           )
// //         ],
// //       ),
// //       extendBodyBehindAppBar: true,
// //       body: SingleChildScrollView(
// //         child: Column(
// //           children: [
// //             Image.network(
// //               widget.product.images.first.originalSrc,
// //               width: double.infinity,
// //               height: screenHeight * 0.45,
// //               fit: BoxFit.cover,
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.all(20),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(widget.product.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
// //                   const SizedBox(height: 10),
// //                   Text(widget.product.formattedPrice, style: const TextStyle(fontSize: 20, color: Colors.pink)),
// //                   const Divider(height: 30),
// //                   Text(widget.product.description ?? "Flower description goes here..."),
// //                   const SizedBox(height: 30),
// //                   SizedBox(
// //                     width: double.infinity,
// //                     height: 50,
// //                     child: ElevatedButton(
// //                       style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
// //                       onPressed: () {},
// //                       child: const Text("Buy It Now", style: TextStyle(color: Colors.white)),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

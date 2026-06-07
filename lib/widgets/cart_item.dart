// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// class CartItemCard extends StatelessWidget {
//   final Map<String, String> item;
//   final VoidCallback onDelete;
//   final VoidCallback onIncrement;
//   final VoidCallback onDecrement;
//   final RxInt quantity; // Pass the observable quantity

//   CartItemCard({
//     super.key,
//     required this.item,
//     required this.onDelete,
//     required this.onIncrement,
//     required this.onDecrement,
//     required this.quantity,
//   });

//   @override
//   Widget build(BuildContext context) {
//     const Color textGrey = Color(0xFF6F6F6F);

//     return Container(
//       margin: const EdgeInsets.only(bottom: 15),
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.03),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           )
//         ],
//       ),
//       child: Stack(
//         children: [
//           Column(
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.asset(
//                       item['image']!,
//                       width: 100,
//                       height: 100,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   const SizedBox(width: 15),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Sku: M34HK", style: GoogleFonts.cabin(fontSize: 10, color: Colors.grey)),
//                         const SizedBox(height: 4),
//                         Text(
//                           item['title']!,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: GoogleFonts.cabin(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
//                         ),
//                         const SizedBox(height: 4),
//                         Text("Red colour", style: GoogleFonts.cabin(fontSize: 12, color: textGrey)),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Quantity Selector
//                   SizedBox(
//                     width: 100,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         GestureDetector(onTap: onDecrement, child: _qtyBtn(Icons.remove)),
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFE8E1CC),
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           // WRAP IN OBX to update number
//                           child: Obx(() => Text(
//                                 "${quantity.value}",
//                                 style: GoogleFonts.cabin(fontWeight: FontWeight.bold),
//                               )),
//                         ),
//                         GestureDetector(onTap: onIncrement, child: _qtyBtn(Icons.add)),
//                       ],
//                     ),
//                   ),
//                   // Price Section
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       // Calculate individual item total (Price * Qty)
//                       Obx(() {
//                          String priceString = item['price']!.replaceAll('SAR ', '').replaceAll(',', '');
//                          double unitPrice = double.tryParse(priceString) ?? 0.0;
//                          double totalItemPrice = unitPrice * quantity.value;
//                          return Text(
//                           "SAR ${totalItemPrice.toStringAsFixed(2)}",
//                           style: GoogleFonts.cabin(fontWeight: FontWeight.bold, fontSize: 14),
//                         );
//                       }),
//                       Text("VAT included", style: GoogleFonts.cabin(fontSize: 9, color: Colors.grey)),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Positioned(
//             right: 0,
//             top: 0,
//             child: GestureDetector(
//               onTap: onDelete,
//               child: const Icon(Icons.close, size: 16, color: Colors.black54),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _qtyBtn(IconData icon) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 4.0),
//       child: Icon(icon, size: 16, color: Colors.black54),
//     );
//   }
// }

// // class CartItemCard extends StatelessWidget {
// //   final Map<String, String> item;
// //   final VoidCallback onDelete;
// //    CartItemCard({super.key, required this.item, required this.onDelete});

// //   @override
// //   Widget build(BuildContext context) {
// //     const Color textGrey = Color(0xFF6F6F6F);

// //     return Container(
// //       margin: const EdgeInsets.only(bottom: 15),
// //       padding: const EdgeInsets.all(15),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(12),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.03),
// //             blurRadius: 10,
// //             offset: const Offset(0, 5),
// //           )
// //         ],
// //       ),
// //       child: Stack(
// //         children: [
// //           Column(
// //             children: [
// //               Row(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   // 1. Image
// //                   ClipRRect(
// //                     borderRadius: BorderRadius.circular(8),
// //                     child: Image.asset(
// //                       item['image']!,
// //                       width: 100,
// //                       height: 100,
// //                       fit: BoxFit.cover,
// //                     ),
// //                   ),
// //                   const SizedBox(width: 15),
// //                   // 2. Product Details
// //                   Expanded(
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                           "Sku: M34HK",
// //                           style: GoogleFonts.cabin(fontSize: 10, color: Colors.grey),
// //                         ),
// //                         const SizedBox(height: 4),
// //                         Text(
// //                           item['title']!,
// //                           maxLines: 2,
// //                           overflow: TextOverflow.ellipsis,
// //                           style: GoogleFonts.cabin(
// //                             fontWeight: FontWeight.w600,
// //                             fontSize: 14,
// //                             color: Colors.black,
// //                           ),
// //                         ),
// //                         const SizedBox(height: 4),
// //                         Text(
// //                           "Red colour",
// //                           style: GoogleFonts.cabin(fontSize: 12, color: textGrey),
// //                         ),
// //                         const SizedBox(height: 4),
// //                         // --- Added Collection RichText ---
// //                         RichText(
// //                           text: TextSpan(
// //                             style: GoogleFonts.cabin(fontSize: 11, color: textGrey),
// //                             children: [
// //                               const TextSpan(text: "Collection: "),
// //                               TextSpan(
// //                                 text: "Flower, Love and Romance",
// //                                 style: GoogleFonts.cabin(color: Colors.grey[400]),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),

// //               const SizedBox(height: 12), // Gap between top row and bottom row

// //               // 3. BOTTOM ROW: Quantity under Image, Price under Details
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 crossAxisAlignment: CrossAxisAlignment.center,
// //                 children: [
// //                   // Quantity Selector (Container width matches Image width)
// //                   SizedBox(
// //                     width: 100,
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         _qtyBtn(Icons.remove),
// //                         Container(
// //                           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
// //                           decoration: BoxDecoration(
// //                             color: const Color(0xFFE8E1CC),
// //                             borderRadius: BorderRadius.circular(4),
// //                           ),
// //                           child: Text(
// //                             "1",
// //                             style: GoogleFonts.cabin(fontWeight: FontWeight.bold),
// //                           ),
// //                         ),
// //                         _qtyBtn(Icons.add),
// //                       ],
// //                     ),
// //                   ),

// //                   // Price Section
// //                   Column(
// //                     crossAxisAlignment: CrossAxisAlignment.end,
// //                     children: [
// //                       Text(
// //                         item['price']!,
// //                         style: GoogleFonts.cabin(
// //                           fontWeight: FontWeight.bold,
// //                           fontSize: 14,
// //                         ),
// //                       ),
// //                       Text(
// //                         "VAT included",
// //                         style: GoogleFonts.cabin(fontSize: 9, color: Colors.grey),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //           // Close Button
// //         Positioned(
// //       right: 0,
// //       top: 0,
// //       child: GestureDetector(
// //         onTap: onDelete, // Call the delete logic here
// //         child: const Icon(Icons.close, size: 16, color: Colors.black54),
// //       ),
// //     ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _qtyBtn(IconData icon) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 4.0),
// //       child: Icon(icon, size: 16, color: Colors.black54),
// //     );
// //   }
// // }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify_flutter/models/models.dart'; // Ensure this import is here

class CartItemCard extends StatelessWidget {
  final Product item;
  final VoidCallback onDelete;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final RxInt quantity;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onDelete,
    required this.onIncrement,
    required this.onDecrement,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    const Color textGrey = Color(0xFF6F6F6F);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      // OPTIMIZED: Use the getter from your model
                      item.image, 
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sku: ${item.id.split('/').last}",
                          style: GoogleFonts.cabin(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.cabin(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Available",
                          style: GoogleFonts.cabin(
                            fontSize: 12,
                            color: textGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Quantity Selector
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: onDecrement,
                        child: _qtyBtn(Icons.remove),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8E1CC),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Obx(
                          () => Text(
                            "${quantity.value}",
                            style: GoogleFonts.cabin(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: onIncrement,
                        child: _qtyBtn(Icons.add),
                      ),
                    ],
                  ),
                  // Price Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Obx(() {
                        // OPTIMIZED: Use the direct double from your model
                        double unitPrice = item.price;
                        double totalItemPrice = unitPrice * quantity.value;

                        return Text(
                          "SAR ${totalItemPrice.toStringAsFixed(2)}",
                          style: GoogleFonts.cabin(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        );
                      }),
                      Text(
                        "VAT included",
                        style: GoogleFonts.cabin(
                          fontSize: 9,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // Delete Button
          Positioned(
            right: -20,
            top: -20,
            child: IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.close, size: 18, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  Widget _qtyBtn(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Icon(icon, size: 18, color: Colors.black87),
    );
  }
}
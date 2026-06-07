import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopify_flutter/models/src/product/price_v_2/price_v_2.dart';
import 'package:shopify_flutter/models/src/product/product.dart';
import 'package:shopify_flutter/models/src/product/product_variant/product_variant.dart';
import 'package:shopify_flutter/models/src/product/shopify_image/shopify_image.dart';

class CartController extends GetxController {
  var cartItems = <Product>[].obs;
  var quantities = <String, RxInt>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _loadCart();
  }

  // --- PERSISTENCE ---

  Future<void> _saveCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
    List<String> itemsJson = cartItems.map((item) {
      return jsonEncode({
        'id': item.id,
        'title': item.title,
        'saved_price': item.price, 
        'saved_image': item.images.first.originalSrc, 
        // ADD THIS LINE: Save the specific Variant ID
        'variant_id': item.productVariants.first.id, 
      });
    }).toList();
      // final prefs = await SharedPreferences.getInstance();
      
      // List<String> itemsJson = cartItems.map((item) {
      //   return jsonEncode({
      //     'id': item.id,
      //     'title': item.title,
      //     'saved_price': item.price, 
      //     'saved_image': item.image, 
      //   });
      // }).toList();
      
      await prefs.setStringList('cart_items', itemsJson);

      Map<String, int> qtyMap = {};
      quantities.forEach((key, value) => qtyMap[key] = value.value);
      await prefs.setString('cart_quantities', jsonEncode(qtyMap));
      
      debugPrint("Cart Saved: ${cartItems.length} items");
    } catch (e) {
      debugPrint("Save Error: $e");
    }
  }

  Future<void> _loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String>? itemsJson = prefs.getStringList('cart_items');
      String? qtyJson = prefs.getString('cart_quantities');

      if (itemsJson != null) {
        List<Product> tempItems = [];
        for (var str in itemsJson) {
          Map<String, dynamic> data = jsonDecode(str);
          
          tempItems.add(Product(
            id: data['id'] ?? '',
            title: data['title'] ?? '',
            availableForSale: true,
            createdAt: '',
            vendor: '',
            productType: '',
            tags: [],
            options: [],
            media: [],
            metafields: [],
            productVariants: [
              ProductVariant(
                id: data['variant_id'] ?? data['id'], 
      title: 'Default Title',
      price: PriceV2(
        amount: (data['saved_price'] as num?)?.toDouble() ?? 0.0, 
        currencyCode: 'SAR',
      ),
                // id: data['id'] ?? '', 
                // title: 'Default Title',
                // price: PriceV2(
                //   amount: (data['saved_price'] as num?)?.toDouble() ?? 0.0, 
                //   currencyCode: 'SAR',
                // ),
                availableForSale: true,
                quantityAvailable: 99,
                weight: 0.0,
                weightUnit: 'kg',
                requiresShipping: true,
                sellingPlanAllocations: [],
              )
            ],
            images: [
              ShopifyImage(originalSrc: data['saved_image'] ?? '', id: '')
            ],
          ));
        }
        cartItems.assignAll(tempItems);
      }

      if (qtyJson != null) {
        Map<String, dynamic> decodedQty = jsonDecode(qtyJson);
        quantities.clear();
        decodedQty.forEach((key, value) {
          quantities[key] = (value as int).obs;
        });
      }
      
      cartItems.refresh();
      quantities.refresh();
    } catch (e) {
      debugPrint("Load Error: $e");
    }
  }

  // --- ACTIONS ---

  void addToCart(Product product) {
    bool alreadyInList = cartItems.any((item) => item.id == product.id);

    if (!alreadyInList) {
      cartItems.add(product);
      quantities[product.id] = 1.obs;
    } else {
      if (quantities.containsKey(product.id)) {
        quantities[product.id]!.value++;
      } else {
        quantities[product.id] = 1.obs;
      }
    }
    // --- ADDED SNACKBAR HERE ---
    Get.snackbar(
      "Added to Cart",
      "${product.title} has been added successfully.",
      snackPosition: SnackPosition.TOP, // Positioned at the top
      backgroundColor: Colors.green.withOpacity(0.9),
      colorText: Colors.white,
      margin: const EdgeInsets.all(15),
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.check_circle, color: Colors.white),
      borderRadius: 10,
    );
    _saveCart();
  }

  void removeFromCart(int index) {
    if (index >= 0 && index < cartItems.length) {
      String id = cartItems[index].id;
      cartItems.removeAt(index);
      quantities.remove(id);
      _saveCart();
    }
  }

  void incrementQty(String productId) {
    if (quantities.containsKey(productId)) {
      quantities[productId]!.value++;
      _saveCart();
    }
  }

  void decrementQty(String productId) {
    if (quantities.containsKey(productId) && quantities[productId]!.value > 1) {
      quantities[productId]!.value--;
      _saveCart();
    }
  }

  double get subtotal {
    double totalValue = 0.0;
    for (var item in cartItems) {
      totalValue += (item.price * (quantities[item.id]?.value ?? 1));
    }
    return totalValue;
  }

  // FIXED: Added the missing total getter
  double get total => subtotal; 
}
// class CartController extends GetxController {
//   var cartItems = <Product>[].obs;
//   var quantities = <String, RxInt>{}.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     _loadCart();
//   }

//   // --- PERSISTENCE ---

//   Future<void> _saveCart() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
      
//       // We map to a clean JSON structure that doesn't rely on Shopify's 'nodes/edges'
//       List<String> itemsJson = cartItems.map((item) {
//         return jsonEncode({
//           'id': item.id,
//           'title': item.title,
//           'saved_price': item.price, // Get the double price
//           'saved_image': item.image, // Get the image string
//         });
//       }).toList();
      
//       await prefs.setStringList('cart_items', itemsJson);

//       Map<String, int> qtyMap = {};
//       quantities.forEach((key, value) => qtyMap[key] = value.value);
//       await prefs.setString('cart_quantities', jsonEncode(qtyMap));
      
//       debugPrint("Cart Saved: ${cartItems.length} items");
//     } catch (e) {
//       debugPrint("Save Error: $e");
//     }
//   }
// Future<void> _loadCart() async {
//   try {
//     final prefs = await SharedPreferences.getInstance();
//     List<String>? itemsJson = prefs.getStringList('cart_items');
//     String? qtyJson = prefs.getString('cart_quantities');

//     if (itemsJson != null) {
//       List<Product> tempItems = [];
//       for (var str in itemsJson) {
//         Map<String, dynamic> data = jsonDecode(str);
        
//         tempItems.add(Product(
//           id: data['id'] ?? '',
//           title: data['title'] ?? '',
//           availableForSale: true,
//           createdAt: '',
//           vendor: '',
//           productType: '',
//           tags: [],
//           options: [],
//           media: [],
//           metafields: [],
//           // FIXED: Added missing required Shopify parameters
//           productVariants: [
//             ProductVariant(
//               id: data['id'] ?? '', // Use product ID as fallback
//               title: 'Default Title',
//               price: PriceV2(
//                 amount: (data['saved_price'] as num?)?.toDouble() ?? 0.0, 
//                 currencyCode: 'SAR',
//               ),
//               availableForSale: true,
//               quantityAvailable: 99,
//               weight: 0.0,            // NEW REQUIRED FIELD
//               weightUnit: 'kg',       // NEW REQUIRED FIELD
//               requiresShipping: true, // NEW REQUIRED FIELD
//               sellingPlanAllocations: [], // NEW REQUIRED FIELD
//             )
//           ],
//           images: [
//             ShopifyImage(originalSrc: data['saved_image'] ?? '', id: '')
//           ],
//         ));
//       }
//       cartItems.assignAll(tempItems);
//     }

//     if (qtyJson != null) {
//       Map<String, dynamic> decodedQty = jsonDecode(qtyJson);
//       quantities.clear();
//       decodedQty.forEach((key, value) {
//         quantities[key] = (value as int).obs;
//       });
//     }
    
//     cartItems.refresh();
//     quantities.refresh();
//   } catch (e) {
//     debugPrint("Load Error: $e");
//   }
// }

//   // --- ACTIONS ---

//   void addToCart(Product product) {
//     bool alreadyInList = cartItems.any((item) => item.id == product.id);

//     if (!alreadyInList) {
//       cartItems.add(product);
//       quantities[product.id] = 1.obs;
//     } else {
//       if (quantities.containsKey(product.id)) {
//         quantities[product.id]!.value++;
//       } else {
//         quantities[product.id] = 1.obs;
//       }
//     }
//     _saveCart();
//   }

//   void removeFromCart(int index) {
//     if (index >= 0 && index < cartItems.length) {
//       String id = cartItems[index].id;
//       cartItems.removeAt(index);
//       quantities.remove(id);
//       _saveCart();
//     }
//   }

//   void incrementQty(String productId) {
//     if (quantities.containsKey(productId)) {
//       quantities[productId]!.value++;
//       _saveCart();
//     }
//   }

//   void decrementQty(String productId) {
//     if (quantities.containsKey(productId) && quantities[productId]!.value > 1) {
//       quantities[productId]!.value--;
//       _saveCart();
//     }
//   }

//   double get subtotal {
//     double total = 0.0;
//     for (var item in cartItems) {
//       // Use the model's price getter directly
//       total += (item.price * (quantities[item.id]?.value ?? 1));
//     }
//     return total;
//   }
// }

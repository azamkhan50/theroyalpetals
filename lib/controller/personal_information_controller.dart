import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royalpetals/controller/cart_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shopify_flutter/shopify_flutter.dart';

class PersonalInformationController extends GetxController {
  final CartController cartController = Get.find<CartController>();
  final formKey = GlobalKey<FormState>();

  // Text Controllers
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final zipController = TextEditingController();
  final phoneController = TextEditingController();

  // Selection States - RE-ADDED THESE TO FIX YOUR UI ERROR
  var selectedShipping = "cod".obs;
  var selectedPayment = "cod".obs;
  var isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    cityController.dispose();
    addressController.dispose();
    zipController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  Future<void> completeOrder() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      if (cartController.cartItems.isEmpty) {
        throw "Your cart is empty";
      }

      debugPrint("🚀 --- STARTING SHOPIFY CART CHECKOUT --- 🚀");
      debugPrint("📧 Email: ${emailController.text}");
      debugPrint(
        "📍 Address: ${addressController.text}, ${cityController.text}",
      );

      // ✅ CREATE CART
      final cart = await ShopifyCart.instance.createCart(
        CartInput(), // ✅ FIXED
      );

      debugPrint("🆕 Cart Created: ${cart.id}");

      // ✅ ADD ITEMS (single call)
      final cartLines = cartController.cartItems.map((item) {
        final qty = cartController.quantities[item.id]?.value ?? 1;

        debugPrint(
          "🛒 ${item.title} | ID: ${item.productVariants.first.id} | Qty: $qty",
        );

        return CartLineUpdateInput(
          merchandiseId: item.productVariants.first.id,
          quantity: qty,
        );
      }).toList();

      final updatedCart = await ShopifyCart.instance.addLineItemsToCart(
        cartId: cart.id,
        cartLineInputs: cartLines,
      );

      debugPrint("✅ Items added");

      // ✅ GET CHECKOUT URL
      final checkoutUrl = updatedCart.checkoutUrl;

      if (checkoutUrl == null || checkoutUrl.isEmpty) {
        throw "Checkout URL not found";
      }

      debugPrint("🌐 Checkout URL: $checkoutUrl");

      // ✅ OPEN CHECKOUT
      final uri = Uri.parse(checkoutUrl);

      if (!await canLaunchUrl(uri)) {
        throw "Cannot open checkout URL";
      }

      await launchUrl(uri, mode: LaunchMode.externalApplication);

      debugPrint("🚀 Opened Checkout");

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;

      debugPrint("❌ ERROR: $e");

      Get.snackbar(
        "Order Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  //  Future<void> completeOrder() async {
  //   if (!formKey.currentState!.validate()) return;

  //   try {
  //     isLoading.value = true;

  //     if (cartController.cartItems.isEmpty) {
  //       throw "Your cart is empty";
  //     }

  //     // --- DEBUG START ---
  //     debugPrint("🚀 --- STARTING SHOPIFY CART CHECKOUT --- 🚀");
  //     debugPrint("📧 Email: ${emailController.text}");
  //     debugPrint("📦 Shipping Method: ${selectedShipping.value}");
  //     debugPrint("📍 Address: ${addressController.text}, ${cityController.text}");
  //     // --- DEBUG END ---

  //     // 1. CREATE CART
  //     final cart = await ShopifyCart.instance.createCart(
  //       CartInput(
  //         buyerIdentity: BuyerIdentityInput(
  //           email: emailController.text.trim(),
  //           countryCode: "SA",
  //         ),
  //       ),
  //     );

  //     debugPrint("🆕 Cart Created: ${cart.id}");

  //     // 2. ADD ALL ITEMS (Single API Call ✅)
  //     final cartLines = cartController.cartItems.map((item) {
  //       final qty = cartController.quantities[item.id]?.value ?? 1;

  //       debugPrint(
  //           "🛒 Item: ${item.title} | VariantID: ${item.productVariants.first.id} | Qty: $qty");

  //       return CartLineUpdateInput(
  //         merchandiseId: item.productVariants.first.id,
  //         quantity: qty,
  //       );
  //     }).toList();

  //     final updatedCart = await ShopifyCart.instance.addLineItemsToCart(
  //       cartId: cart.id,
  //       cartLineInputs: cartLines,
  //     );

  //     debugPrint("✅ Items added to cart");

  //     // 3. GET CHECKOUT URL
  //     final checkoutUrl = updatedCart.checkoutUrl;

  //     debugPrint("🌐 Checkout URL: $checkoutUrl");

  //     if (checkoutUrl == null || checkoutUrl.isEmpty) {
  //       throw "Checkout URL not found";
  //     }

  //     // 4. OPEN CHECKOUT PAGE
  //     await launchUrl(
  //       Uri.parse(checkoutUrl),
  //       mode: LaunchMode.externalApplication,
  //     );

  //     debugPrint("🚀 Redirected to Shopify Checkout");

  //     isLoading.value = false;

  //     // ❌ DO NOT go to success screen here
  //     // Success comes AFTER payment

  //   } catch (e) {
  //     isLoading.value = false;

  //     debugPrint("❌ Shopify API Error: $e");

  //     Get.snackbar(
  //       "Order Error",
  //       e.toString(),
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   }
  // }
}
// class PersonalInformationController extends GetxController {
//   final CartController cartController = Get.find<CartController>();

//   // Form Key for Validation
//   final formKey = GlobalKey<FormState>();

//   // Text Editing Controllers
//   final emailController = TextEditingController();
//   final cityController = TextEditingController();
//   final addressController = TextEditingController();
//   final zipController = TextEditingController();
//   final phoneController = TextEditingController();

//   // Selection States
//   var selectedShipping = "cod".obs;
//   var selectedPayment = "cod".obs;
//   var isLoading = false.obs;

//   @override
//   void onClose() {
//     emailController.dispose();
//     cityController.dispose();
//     addressController.dispose();
//     zipController.dispose();
//     phoneController.dispose();
//     super.onClose();
//   }

//   void updateShipping(String val) => selectedShipping.value = val;
//   void updatePayment(String val) => selectedPayment.value = val;

// Future<void> completeOrder() async {
//   if (!formKey.currentState!.validate()) return;

//   try {
//     isLoading.value = true;

//     if (cartController.cartItems.isEmpty) throw "Your cart is empty";

//     List<Map<String, dynamic>> lineItems = [];
    
//     for (var item in cartController.cartItems) {
//       if (item.productVariants != null && item.productVariants.isNotEmpty) {
//         String vId = item.productVariants.first.id;
        
//         // Ensure we are sending a Variant ID, not a Product ID
//         if (vId.contains("/Product/")) {
//            debugPrint("⚠️ WARNING: Critical ID mismatch found.");
//         }

//         lineItems.add({
//           "variantId": vId, 
//           "quantity": cartController.quantities[item.id]?.value ?? 1,
//         });
//       }
//     }

//     if (lineItems.isEmpty) throw "No valid products found";

//     // CORRECT SDK CALL: Using ShopifyStore instead of ShopifyCheckout
//     debugPrint("Attempting to create Shopify Checkout...");
    
//     await ShopifyStore.instance.checkout(
//       lineItems: lineItems, 
//       email: emailController.text.trim(),
//       shippingAddress: {
//         "address1": addressController.text,
//         "city": cityController.text,
//         "zip": zipController.text,
//         "phone": phoneController.text,
//         "country": "Saudi Arabia", // Added to ensure API acceptance
//         "lastName": "Customer",     // Added required field
//       },
//     );

//     isLoading.value = false;
//     // Clear cart after success if needed: cartController.cartItems.clear();
//     Get.to(() => const OrderSuccessScreen());
    
//   } catch (e) {
//     isLoading.value = false;
//     debugPrint("Shopify API Error: $e");
//     Get.snackbar(
//       "Order Error", 
//       "Could not place order. Please check your connection or address.", 
//       backgroundColor: Colors.red, 
//       colorText: Colors.white,
//     );
//   }
// }}
// Future<void> completeOrder() async {
//   if (!formKey.currentState!.validate()) return;

//   try {
//     isLoading.value = true;

//     // 1. Ensure Cart isn't empty
//     if (cartController.cartItems.isEmpty) {
//       throw "Your cart is empty";
//     }

//     // 2. Map line items safely
//     List<Map<String, dynamic>> lineItems = [];
    
//     // --- THIS IS THE FIXED SECTION ---
//    for (var item in cartController.cartItems) {
//   if (item.productVariants != null && item.productVariants.isNotEmpty) {
    
//     String vId = item.productVariants.first.id;
    
//     // DEBUG CHECK: If it contains "Product" instead of "ProductVariant", it will fail
//     if (vId.contains("/Product/")) {
//        debugPrint("CRITICAL ERROR: Sending Product ID instead of Variant ID: $vId");
//        // You might need to fetch the real Variant ID from Shopify here
//     }

//     lineItems.add({
//       "variantId": vId, 
//       "quantity": cartController.quantities[item.id]?.value ?? 1,
//     });
//   }
// }
//     // ---------------------------------

//     if (lineItems.isEmpty) throw "No valid variants found in cart";

//     final checkoutData = {
//       "email": emailController.text.trim(),
//       "shippingAddress": {
//         "address1": addressController.text,
//         "city": cityController.text,
//         "zip": zipController.text,
//         "phone": phoneController.text,
//       },
//       "lineItems": lineItems,
//     };

//     // 3. Placing the order
//     debugPrint("Placing Shopify Order: $checkoutData");
    
//     // NOTE: You must uncomment and use your actual SDK call here for the order to reach Shopify:
//     // await ShopifyCheckout.instance.createCheckout(
//     //   lineItems: lineItems, 
//     //   email: emailController.text.trim(),
//     //   shippingAddress: checkoutData["shippingAddress"],
//     // );

//     isLoading.value = false;
//     Get.to(() => const OrderSuccessScreen());
    
//   } catch (e) {
//     isLoading.value = false;
//     Get.snackbar("Order Error", e.toString(), 
//       backgroundColor: Colors.red, colorText: Colors.white);
//   }
// }



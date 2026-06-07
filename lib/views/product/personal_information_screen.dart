import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:royalpetals/controller/cart_controller.dart';
import 'package:royalpetals/controller/personal_information_controller.dart';
import 'package:royalpetals/utils/app_routes.dart';
import 'package:royalpetals/views/product/order_success_screen.dart';
import 'package:royalpetals/widgets/action_box.dart';
import 'package:royalpetals/widgets/app_bar.dart'; // Your custom app bar
import 'package:royalpetals/widgets/custom_button.dart'; // Your custom button

// Import your new controller

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize our new controller
    final controller = Get.put(PersonalInformationController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: RoyalAppBar(
        title: "Personal Information",
        actions: [
          ActionBox(
            child: Image.asset('assets/image/cart2.png'),
            onTap: () => Get.toNamed(AppRoutes.cart),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.formKey, // Attach the validation key
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Contact"),
              _buildTextField(
                label: "Email", 
                hint: "munebahmad@gmail.com", 
                controller: controller.emailController
              ),
              
              const SizedBox(height: 20),
              _buildSectionTitle("Delivery"),
              _buildTextField(label: "City", hint: "Select the city", controller: controller.cityController),
              _buildTextField(label: "Address", hint: "Type your address", controller: controller.addressController),
              _buildTextField(label: "Postal code", hint: "Type your postal code", controller: controller.zipController),
              _buildTextField(label: "Phone", hint: "Type your phone number", controller: controller.phoneController),

              const SizedBox(height: 25),
              _buildSectionTitle("Shipping Method"),
              Obx(() => Column(
                children: [
                  _buildSelectionCard(
                    id: "cod",
                    title: "FLAT SHIPPING 5.0 SAR + POST FEE 1 SAR",
                    subtitle: "Cash on Delivery (COD)",
                    price: "SAR 200.00",
                    groupValue: controller.selectedShipping.value,
                    onChanged: (val) => controller.selectedShipping.value = val!,
                  ),
                  _buildSelectionCard(
                    id: "online",
                    title: "FLAT SHIPPING 5.0 SAR + POST FEE 1 SAR",
                    subtitle: "Debit - Credit Card",
                    price: "SAR 1.00",
                    oldPrice: "SAR 200.00",
                    groupValue: controller.selectedShipping.value,
                    onChanged: (val) => controller.selectedShipping.value = val!,
                  ),
                ],
              )),

              const SizedBox(height: 25),
              _buildSectionTitle("Payment Method"),
              Obx(() => Column(
                children: [
                  _buildSimpleSelectionCard(
                    id: "cod",
                    title: "Cash on Delivery",
                    groupValue: controller.selectedPayment.value,
                    onChanged: (val) => controller.selectedPayment.value = val!,
                  ),
                  _buildSimpleSelectionCard(
                    id: "card",
                    title: "Debit - Credit Card",
                    groupValue: controller.selectedPayment.value,
                    onChanged: (val) => controller.selectedPayment.value = val!,
                  ),
                ],
              )),

              const SizedBox(height: 25),
              _buildOrderSummaryList(controller.cartController),

              const SizedBox(height: 20),
              _buildDiscountSection(),

              const SizedBox(height: 30),
              CustomButton(
                
                imagePath: "assets/image/checkmark.png",
                title: "Complete Order",
                onPressed: () { controller.completeOrder();

                  // print('this product id is ${controller.cartController.cartItems.first.id}');
                  //   print('this product id is ${controller.cartController.cartItems.first}');
                 }, // Calls the validation logic
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets (Keeping your exact Design) ---

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: GoogleFonts.cabin(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField({required String label, required String hint, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.cabin(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            validator: (value) => (value == null || value.isEmpty) ? "Field required" : null,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.cabin(color: Colors.grey, fontSize: 13),
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionCard({
    required String id, required String title, required String subtitle, 
    required String price, String? oldPrice, required String groupValue, 
    required Function(String?) onChanged,
  }) {
    bool isSelected = id == groupValue;
    return GestureDetector(
      onTap: () => onChanged(id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF3EAD3) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? const Color(0xFFC39A38) : Colors.transparent),
        ),
        child: Row(
          children: [
            Radio<String>(value: id, groupValue: groupValue, onChanged: onChanged, activeColor: Colors.black),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.cabin(fontSize: 12, fontWeight: FontWeight.bold)),
                  Text(subtitle, style: GoogleFonts.cabin(fontSize: 11, color: Colors.grey[600])),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (oldPrice != null)
                  Text(oldPrice, style: const TextStyle(decoration: TextDecoration.lineThrough, fontSize: 10, color: Colors.grey)),
                Text(price, style: GoogleFonts.cabin(fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleSelectionCard({required String id, required String title, required String groupValue, required Function(String?) onChanged}) {
    bool isSelected = id == groupValue;
    return GestureDetector(
      onTap: () => onChanged(id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF3EAD3) : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Radio<String>(value: id, groupValue: groupValue, onChanged: onChanged, activeColor: Colors.black),
            Text(title, style: GoogleFonts.cabin(fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummaryList(CartController cartController) {
    return Obx(() {
      if (cartController.cartItems.isEmpty) return const SizedBox.shrink();
      return Column(
        children: cartController.cartItems.map((item) {
          int qty = cartController.quantities[item.id]?.value ?? 1;
          double lineTotal = item.price * qty;
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black.withOpacity(0.05)),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(item.images.first.originalSrc, width: 70, height: 70, fit: BoxFit.cover),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                   
                      Text("Quantity: $qty", style: const TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                ),
                Text("SAR ${lineTotal.toStringAsFixed(2)}", style: GoogleFonts.cabin(fontSize: 13, fontWeight: FontWeight.bold)),
              ],
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _buildDiscountSection() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "Discount code",
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: Container(
            height: 55,
            decoration: BoxDecoration(color: const Color(0xFFE8E1CC), borderRadius: BorderRadius.circular(8)),
            child: Center(child: Text("Apply", style: GoogleFonts.cabin(fontWeight: FontWeight.bold))),
          ),
        )
      ],
    );
  }
}

// class PersonalInformationScreen extends StatefulWidget {
//   const PersonalInformationScreen({super.key});

//   @override
//   State<PersonalInformationScreen> createState() => _PersonalInformationScreenState();
// }

// class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
//   final CartController cartController = Get.find<CartController>();
  
//   // Selection states for radio buttons
//   String selectedShipping = "cod";
//   String selectedPayment = "cod";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F9F9),
//       appBar: RoyalAppBar(
//         title: "Personal Information", // Changed from My Cart to match the process
//         actions: [
//           ActionBox(
//             child: Image.asset('assets/image/cart2.png'),
//             onTap: () =>    Get.toNamed(AppRoutes.cart), 
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildSectionTitle("Contact"),
//             _buildTextField(label: "Email", hint: "munebahmad@gmail.com"),
            
//             const SizedBox(height: 20),
//             _buildSectionTitle("Delivery"),
//             _buildTextField(label: "City", hint: "Select the city from dropdown", ),
//             _buildTextField(label: "Address", hint: "Type your address here"),
//             _buildTextField(label: "Postal code", hint: "Type your postal code here"),
//             _buildTextField(label: "Phone", hint: "Type your phone number here"),

//             const SizedBox(height: 25),
//             _buildSectionTitle("Shipping Method"),
//             _buildSelectionCard(
//               id: "cod",
//               title: "FLAT SHIPPING 5.0 SAR + POST FEE 1 SAR",
//               subtitle: "Cash on Delivery (COD)",
//               price: "SAR 200.00",
//               groupValue: selectedShipping,
//               onChanged: (val) => setState(() => selectedShipping = val!),
//             ),
//             _buildSelectionCard(
//               id: "online",
//               title: "FLAT SHIPPING 5.0 SAR + POST FEE 1 SAR",
//               subtitle: "Debit - Credit Card",
//               price: "SAR 1.00",
//               oldPrice: "SAR 200.00",
//               groupValue: selectedShipping,
//               onChanged: (val) => setState(() => selectedShipping = val!),
//             ),

//             const SizedBox(height: 25),
//             _buildSectionTitle("Payment Method"),
//             _buildSimpleSelectionCard(
//               id: "cod",
//               title: "Cash on Delivery",
//               groupValue: selectedPayment,
//               onChanged: (val) => setState(() => selectedPayment = val!),
//             ),
//             _buildSimpleSelectionCard(
//               id: "card",
//               title: "Debit - Credit Card",
//               groupValue: selectedPayment,
//               onChanged: (val) => setState(() => selectedPayment = val!),
//             ),

//             const SizedBox(height: 25),
//             _buildOrderSummaryList(),

//             const SizedBox(height: 20),
//             _buildDiscountSection(),

//             const SizedBox(height: 30),
//             CustomButton(
//                  imagePath: "assets/image/checkmark.png",
//               title: "Complete Order",
//               onPressed: () {
//                 Get.to( () => const OrderSuccessScreen());
//                  // Here you would typically handle the order submission logic
//                  // For example, you might call a method in your CartController to process the order
//                  // cartController.completeOrder();
//                 // Handle order logic
//               },
//             ),
//             const SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }

//   // --- Helper Widgets ---

//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: Text(
//         title,
//         style: GoogleFonts.cabin(fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   Widget _buildTextField({required String label, required String hint, bool isDropdown = false}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 15.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label, style: GoogleFonts.cabin(fontSize: 14, fontWeight: FontWeight.w500)),
//           const SizedBox(height: 8),
//           TextFormField(
//             decoration: InputDecoration(
//               hintText: hint,
//               hintStyle: GoogleFonts.cabin(color: Colors.grey, fontSize: 13),
//               fillColor: Colors.white,
//               filled: true,
//               suffixIcon: isDropdown ? const Icon(Icons.arrow_drop_down) : null,
//               contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSelectionCard({
//     required String id,
//     required String title,
//     required String subtitle,
//     required String price,
//     String? oldPrice,
//     required String groupValue,
//     required Function(String?) onChanged,
//   }) {
//     bool isSelected = id == groupValue;
//     return GestureDetector(
//       onTap: () => onChanged(id),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 10),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: isSelected ? const Color(0xFFF3EAD3) : Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: isSelected ? const Color(0xFFC39A38) : Colors.transparent),
//         ),
//         child: Row(
//           children: [
//             Radio<String>(
//               value: id,
//               groupValue: groupValue,
//               onChanged: onChanged,
//               activeColor: Colors.black,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(title, style: GoogleFonts.cabin(fontSize: 12, fontWeight: FontWeight.bold)),
//                   Text(subtitle, style: GoogleFonts.cabin(fontSize: 11, color: Colors.grey[600])),
//                 ],
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 if (oldPrice != null)
//                   Text(oldPrice, style: const TextStyle(decoration: TextDecoration.lineThrough, fontSize: 10, color: Colors.grey)),
//                 Text(price, style: GoogleFonts.cabin(fontSize: 12, fontWeight: FontWeight.bold)),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSimpleSelectionCard({required String id, required String title, required String groupValue, required Function(String?) onChanged}) {
//     bool isSelected = id == groupValue;
//     return GestureDetector(
//       onTap: () => onChanged(id),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 10),
//         padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
//         decoration: BoxDecoration(
//           color: isSelected ? const Color(0xFFF3EAD3) : Colors.white,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           children: [
//             Radio<String>(value: id, groupValue: groupValue, onChanged: onChanged, activeColor: Colors.black),
//             Text(title, style: GoogleFonts.cabin(fontSize: 14, fontWeight: FontWeight.w500)),
//           ],
//         ),
//       ),
//     );
//   }

// Widget _buildOrderSummaryList() {
//   return Obx(() {
//     if (cartController.cartItems.isEmpty) {
//       return const SizedBox.shrink();
//     }

//     return Column(
//       children: cartController.cartItems.map((item) {
//         // FIX: Access quantity using item.id (String), not the index (int)
//         int qty = cartController.quantities[item.id]?.value ?? 1;

//         // Calculate item total
//         // Note: Since you already have item.price as a double in your model, 
//         // you don't need complex parsing unless your model stores it as a String.
//         double unitPrice = item.price; 
//         double lineTotal = unitPrice * qty;

//         return Container(
//           margin: const EdgeInsets.only(bottom: 10),
//           padding: const EdgeInsets.all(15),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.black.withOpacity(0.05)),
//           ),
//           child: Row(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.network(
//                   item.images.first.originalSrc, 
//                   width: 70, 
//                   height: 70, 
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) => 
//                       const Icon(Icons.broken_image, size: 70),
//                 ),
//               ),
//               const SizedBox(width: 15),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("ITEM ID: ${item.id.split('/').last}", 
//                       style: GoogleFonts.cabin(fontSize: 10, color: Colors.grey)),
//                     Text(
//                       item.title ?? "Product Name", 
//                       style: GoogleFonts.cabin(fontSize: 12, fontWeight: FontWeight.bold), 
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     Text(
//                       "Quantity: ${qty.toString().padLeft(2, '0')}", 
//                       style: GoogleFonts.cabin(fontSize: 10, color: Colors.grey)
//                     ),
//                   ],
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     "SAR ${lineTotal.toStringAsFixed(2)}", 
//                     style: GoogleFonts.cabin(fontSize: 13, fontWeight: FontWeight.bold)
//                   ),
//                   const Text(
//                     "VAT included", 
//                     style: TextStyle(fontSize: 9, color: Colors.grey)
//                   ),
//                 ],
//               )
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   });
// }

//   Widget _buildDiscountSection() {
//     return Row(
//       children: [
//         Expanded(
//           flex: 3,
//           child: TextFormField(
//             decoration: InputDecoration(
//               hintText: "Discount code or gift card",
//               fillColor: Colors.white,
//               filled: true,
//               border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
//             ),
//           ),
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           flex: 1,
//           child: Container(
//             height: 55,
//             decoration: BoxDecoration(color: const Color(0xFFE8E1CC), borderRadius: BorderRadius.circular(8)),
//             child: Center(child: Text("Apply", style: GoogleFonts.cabin(fontWeight: FontWeight.bold))),
//           ),
//         )
//       ],
//     );
//   }

//   Widget _buildActionBox({required Widget child, required VoidCallback onTap}) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 10.0),
//       child: Center(
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(10),
//           child: Container(
//             height: 48, width: 48, padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.white, borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: Colors.black.withOpacity(0.05)),
//             ),
//             child: Center(child: child),
//           ),
//         ),
//       ),
//     );
//   }
// }
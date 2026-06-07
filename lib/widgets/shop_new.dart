import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royalpetals/controller/ProductController.dart';
import 'package:royalpetals/views/home/home_screen.dart';


class ShowNew extends StatelessWidget {
  const ShowNew({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();
    final categories = ["All", "Perfumes", "Flowers and Chocolates", "Father Day "];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Obx(() {
            // Check against COMBO specific selection
            bool isSelected = productController.selectedComboCategory.value == categories[index];

            return
            GestureDetector(
              onTap: () {
                 if (categories[index] == "All") {
                  productController.selectedComboCategory.value = "All";
                  // Reset combo list to all products or original combo list
                  productController.comboProducts.assignAll(productController.allProducts);
                } else {
                  // Call COMBO specific filter
                  productController.filterByComboCategory(categories[index]);
                }
              },
              
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? HomeScreen.brandGold : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? HomeScreen.brandGold
                        : Colors.grey.shade200,
                  ),
                ),
                child: Text(
                  categories[index],
                  style: GoogleFonts.cabin(
                    color: isSelected ? Colors.white : Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ));
            //  GestureDetector(
            //   onTap: () {
            //     if (categories[index] == "All") {
            //       productController.selectedComboCategory.value = "All";
            //       // Reset combo list to all products or original combo list
            //       productController.comboProducts.assignAll(productController.allProducts);
            //     } else {
            //       // Call COMBO specific filter
            //       productController.filterByComboCategory(categories[index]);
            //     }
            //   },
            //   child: Container(
            //     // ... (your styling code remains the same)
            //     decoration: BoxDecoration(
            //       color: isSelected ? HomeScreen.brandGold : Colors.white,
            //       // ...
            //     ),
            //     child: Text(categories[index], 
            //        style: GoogleFonts.cabin(color: isSelected ? Colors.white : Colors.grey)
            //     ),
            //   ),
            // );
          });
        },
      ),
    );
  }
}
// class ShowNew extends StatelessWidget {
//   const ShowNew({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final ProductController productController = Get.find<ProductController>();
//     final categories = ["All", "Perfumes", "Flowers and Chocolates", "Baloons"];

//     return SizedBox(
//       height: 40,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.only(left: 20),
//         itemCount: categories.length,
//         itemBuilder: (context, index) {
//           return Obx(() {
//             // Now Obx is specifically wrapped around the widget that needs updating
//             // and it uses productController.selectedStaticCategory.value
//             bool isSelected =
//                 productController.selectedStaticCategory.value ==
//                 categories[index];

//             return GestureDetector(
//               onTap: () {
//                 if (categories[index] == "All") {
//                   productController.selectedStaticCategory.value = "All";
//                   productController.comboProducts.assignAll(
//                     productController.allProducts,
//                   );
//                 } else {
//                   // Pass the title (e.g., "Flowers")
//                   productController.filterByCategory(categories[index]);
//                 }
//               },
              
//               child: Container(
//                 margin: const EdgeInsets.only(right: 10),
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   color: isSelected ? HomeScreen.brandGold : Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(
//                     color: isSelected
//                         ? HomeScreen.brandGold
//                         : Colors.grey.shade200,
//                   ),
//                 ),
//                 child: Text(
//                   categories[index],
//                   style: GoogleFonts.cabin(
//                     color: isSelected ? Colors.white : Colors.grey,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             );
//           });
//         },
//       ),
//     );
//   }
// }








import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royalpetals/controller/ProductController.dart';
import 'package:royalpetals/views/home/home_screen.dart';
// class CategoryFilterRow extends StatelessWidget {
//   const CategoryFilterRow({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // 1. Find your controller
//     final ProductController productController = Get.find<ProductController>();

//     return SizedBox(
//       height: 40,
//       child: Obx(() { // 2. Wrap with Obx to watch for selection changes
//         return ListView.builder(
//           scrollDirection: Axis.horizontal,
//           padding: const EdgeInsets.only(left: 20),
//           // Add 1 to length to include the "All" button
//           itemCount: productController.categories.length + 1,
//           itemBuilder: (context, index) {

//             String title;
//             String handle;
//             bool isSelected;

//             if (index == 0) {
//               // Logic for the "All" button
//               title = "All";
//               handle = "";
//               isSelected = productController.selectedCategoryHandle.value == "";
//             } else {
//               // Logic for Shopify Categories
//               var category = productController.categories[index - 1];
//               title = category.title;
//               handle = category.handle!;
//               isSelected = productController.selectedCategoryHandle.value == handle;
//             }

//             return GestureDetector(
//               onTap: () {
//                 if (index == 0) {
//                   productController.fetchProducts(); // Show everything
//                   productController.selectedCategoryHandle.value = "";
//                 } else {
//                   productController.filterByCategory(handle); // Filter by category
//                 }
//               },
//               child: Container(
//                 margin: const EdgeInsets.only(right: 10),
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   // 3. Dynamic color based on isSelected
//                   color: isSelected ? HomeScreen.brandGold : Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(
//                     color: isSelected ? HomeScreen.brandGold : Colors.grey.shade200
//                   ),
//                 ),
//                 child: Text(
//                   title,
//                   style: GoogleFonts.cabin(
//                     color: isSelected ? Colors.white : Colors.grey,
//                     fontWeight: FontWeight.w500
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }

class CategoryFilterRow extends StatelessWidget {
  const CategoryFilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();
    final categories = ["All", "Flowers", "Cakes", "Chocolates", "Balloons "];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Obx(() {
            // Now Obx is specifically wrapped around the widget that needs updating
            // and it uses productController.selectedStaticCategory.value
            bool isSelected =
                productController.selectedStaticCategory.value ==
                categories[index];

            return GestureDetector(
              onTap: () {
                if (categories[index] == "All") {
                  productController.selectedStaticCategory.value =
                      "All"; // Featured variable
                  productController.filteredProducts.assignAll(
                    productController.allProducts,
                  );
                } else {
                  productController.filterByCategory(
                    categories[index],
                  ); // Featured method
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
              ),
            );
          });
        },
      ),
    );
  }
}

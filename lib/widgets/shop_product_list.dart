import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royalpetals/controller/ProductController.dart';
import 'package:royalpetals/views/product/product_detail_screen.dart';

class ShopProduct extends StatelessWidget {
  const ShopProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find<ProductController>();

    return SizedBox(
      height: 280,
      child: Obx(() {
        // Show loader while fetching category data
        if (controller.isComboLoading.value || controller.isInitialLoading.value) {
    return const Center(child: CircularProgressIndicator());
  }
        // if (controller.isComboLoading.value) {
        //   return const Center(child: CircularProgressIndicator());
        // }

        // CRITICAL CHANGE: Use filteredProducts instead of allProducts
        final listToShow = controller.comboProducts;

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
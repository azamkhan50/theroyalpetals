import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royalpetals/controller/ProductController.dart';
import 'package:royalpetals/views/home/product_detail_screen.dart'
    show ProductDetailScreen;
import 'package:royalpetals/views/product/product_detail_screen.dart'
    show ProductDetailScreen;

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find<ProductController>();

    const Color textGrey = Color(0xFF6F6F6F);
    const Color bgGrey = Color(0xFFFBFBFB);

    return Obx(() {
      // 1. Check Loading State First
      if (controller.isInitialLoading.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(50.0),
            child: CircularProgressIndicator(color: Colors.black),
          ),
        );
      }

      // 2. Check for Empty State (After loading is done)
      if (controller.filteredProducts.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              children: [
                const Icon(Icons.search_off, size: 50, color: Colors.grey),
                const SizedBox(height: 10),
                Text(
                  "No products found.",
                  style: GoogleFonts.cabin(color: textGrey, fontSize: 16),
                ),
              ],
            ),
          ),
        );
      }

      // 3. Show Grid if data exists
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        itemCount: controller.filteredProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 15,
          childAspectRatio: 0.72,
        ),
        itemBuilder: (context, index) {
          final product = controller.filteredProducts[index];

          return GestureDetector(
            onTap: () {
              Get.to(() => ProductDetailScreen(product: product));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: bgGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: product.images.first.originalSrc,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        // What to show while the image is loading the FIRST time
                        placeholder: (context, url) => Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                        // What to show if the link is broken
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.broken_image),
                      ),
                    ),
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(10),
                    //   child: Image.network(
                    //     product.images.first.originalSrc,
                    //     width: double.infinity,
                    //     fit: BoxFit.cover,
                    //     // Error handling for network images
                    //     errorBuilder: (context, error, stackTrace) =>
                    //         const Icon(Icons.broken_image, color: Colors.grey),
                    //   ),
                    // ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.cabin(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: textGrey,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  " SAR ${product.price} ",
                  style: GoogleFonts.cabin(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}

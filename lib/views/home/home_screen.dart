import 'package:flutter/material.dart';
import 'package:royalpetals/model/favorites_provider.dart';
import 'package:royalpetals/views/home/product_detail_screen.dart';
import 'package:royalpetals/widgets/search_bar_widget.dart';
// ALWAYS use this main import to get the Product class
import 'package:shopify_flutter/shopify_flutter.dart'; 

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:Text("The Royal Petals", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold)),
//         // Image.network('https://theroyalpetals.com/cdn/shop/files/The_Royal_Petals_Logo.png', height: 40), // Your logo
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: FutureBuilder<List<Product>>(
//         future: ShopifyStore.instance.getAllProducts().then((products) async {
//   await FavoritesManager.loadFavorites(products); // Load the hearts!
//   return products;
// }),
//        // future: ShopifyStore.instance.getAllProducts(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator(color: Colors.pink));
//           }
//           final products = snapshot.data ?? [];
          
//           return GridView.builder(
//             padding: const EdgeInsets.all(15),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: 0.7,
//               crossAxisSpacing: 15,
//               mainAxisSpacing: 15,
//             ),
//             itemCount: products.length,
//             itemBuilder: (context, index) => ProductCard(product: products[index]),
//           );
//         },
//       ),
//     );
//   }
//     /// 🔍 FILTER FUNCTION
 

// }
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Product> allProducts = [];
  List<Product> filteredProducts = [];

  late Future<List<Product>> _futureProducts;

  @override
  void initState() {
    super.initState();

    _futureProducts = ShopifyStore.instance.getAllProducts().then((products) async {
      await FavoritesManager.loadFavorites(products);

      allProducts = products;
      filteredProducts = products;

      return products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "The Royal Petals",
          style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: Column(
        children: [

          /// 🔍 SEARCH BAR
          SearchBarWidget(
            onChanged: (value) {
              filterProducts(value);
            },
          ),

          /// 📦 PRODUCT LIST
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: _futureProducts,
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.pink),
                  );
                }

                /// ❌ NO DATA FOUND
                if (filteredProducts.isEmpty) {
                  return const Center(
                    child: Text(
                      "No products found 😔",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }

                /// ✅ SHOW PRODUCTS
                return GridView.builder(
                  padding: const EdgeInsets.all(15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) =>
                      ProductCard(product: filteredProducts[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 🔍 SEARCH FUNCTION
  void filterProducts(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredProducts = allProducts;
      });
      return;
    }

    final results = allProducts.where((product) {
      final title = product.title.toLowerCase();
      final search = query.toLowerCase();

      return title.contains(search);
    }).toList();

    setState(() {
      filteredProducts = results;
    });
  }
}
class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context, 
        MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(product.images.first.originalSrc),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(product.title, maxLines: 2, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(product.formattedPrice, style: const TextStyle(color: Colors.pink)),
          const SizedBox(height: 4),
        //  const Text("Add To Cart", style: TextStyle(decoration: TextDecoration.underline, fontSize: 12)),
        ],
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("The Royal Petals"),
//         centerTitle: true,
//       ),
//       // Use 'Product' here. The library exports it correctly now.
//       body: FutureBuilder<List<Product>>(
//         future: ShopifyStore.instance.getAllProducts(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           }

//           final products = snapshot.data ?? [];

//           if (products.isEmpty) {
//             return const Center(child: Text("No products found."));
//           }

//           return ListView.builder(
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               final product = products[index];
//               return _buildProductCard(product);
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildProductCard(Product product) {
//     return ListTile(
//       leading: product.images.isNotEmpty 
//           ? Image.network(
//               product.images.first.originalSrc,
//               width: 50,
//               height: 50,
//               fit: BoxFit.cover,
//             ) 
//           : const Icon(Icons.image),
//       title: Text(product.title),
//       subtitle: Text(product.formattedPrice),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:royalpetals/model/GiftCategory.dart';
// import 'package:royalpetals/widgets/categroy_card.dart';
// import 'package:royalpetals/widgets/hero_card.dart';
// import 'package:royalpetals/widgets/product_categroy.dart';
// import 'package:royalpetals/widgets/section_header.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
        
//         slivers: [
//           // Header Section
//           SliverToBoxAdapter(
//             child: Container(
//               padding: const EdgeInsets.only(top: 60, bottom: 20),
//               child: Column(
//                 children: [
//                   Text(
//                     'GIFT BY DAYS',
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.w400,
//                       color: const Color(0xFFD4AF37),
//                       letterSpacing: 3,
//                       fontFamily: 'Georgia',
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 40),
//                     child: Text(
//                       'Celebrate life\'s special moments with gifts perfect for every occasion from heartfelt celebrations to joyful milestones.',
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Colors.black87,
//                         height: 1.6,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Hero Cards Section
//           SliverToBoxAdapter(
//             child: SizedBox(
//               height: 320,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 itemCount: DataProvider.heroCards.length,
//                 itemBuilder: (context, index) {
//                   return SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.7,
//                     child: HeroCardWidget(data: DataProvider.heroCards[index]),
//                   );
//                 },
//               ),
//             ),
//           ),

//           // Celebrate Every Moment Section
//           SliverToBoxAdapter(
//             child: SectionHeader(
//               title: 'CELEBRATE EVERY MOMENT',
//               subtitle:
//                   'Celebrate life\'s special moments with gifts perfect for every occasion from heartfelt celebrations to joyful milestones.',
//             ),
//           ),

//           // Categories Grid
//           SliverPadding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             sliver: SliverGrid(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 2.2,
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 12,
//               ),
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   return CategoryCardWidget(
//                     category: DataProvider.categories[index],
//                   );
//                 },
//                 childCount: DataProvider.categories.length,
//               ),
//             ),
//           ),

//           // Featured Products Section
//           SliverToBoxAdapter(
//             child: SectionHeader(
//               title: 'FEATURED PRODUCTS',
//               subtitle:
//                   'Discover our most loved and best selling gifts, carefully selected to help you find the perfect present for any occasion.',
//             ),
//           ),

//           // Products Grid
//           SliverPadding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             sliver: SliverGrid(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.75,
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 12,
//               ),
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   return ProductCardWidget(
//                     product: DataProvider.featuredProducts[index],
//                   );
//                 },
//                 childCount: DataProvider.featuredProducts.length,
//               ),
//             ),
//           ),

//           // Shop by Combos Section
//           SliverToBoxAdapter(
//             child: SectionHeader(
//               title: 'SHOP BY COMBOS',
//               subtitle:
//                   'Discover perfectly paired gift combinations designed to make every surprise more memorable and special.',
//             ),
//           ),

//           // Combos Horizontal List
//           SliverToBoxAdapter(
//             child: SizedBox(
//               height: 200,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 itemCount: 3,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     width: MediaQuery.of(context).size.width * 0.6,
//                     margin: const EdgeInsets.only(right: 12),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 10,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: const BorderRadius.vertical(
//                                 top: Radius.circular(12),
//                               ),
//                               image: DecorationImage(
//                                 image: NetworkImage('https://theroyalpetals.com/cdn/shop/files/Untitled_design_18.png?v=1773341232&width=480'),
//                                 // image:
//                                 //  AssetImage(
//                                 //   index == 0
//                                 //       ? 'assets/combo1.jpg'
//                                 //       : index == 1
//                                 //           ? 'assets/combo2.jpg'
//                                 //           : 'assets/combo3.jpg',
//                                 // ),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(12),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text(
//                                 'Combo Set',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               Text(
//                                 '\$${(199 + (index * 50)).toString()}.00',
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color(0xFFD4AF37),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),

//           // Bottom Padding
//           const SliverToBoxAdapter(
//             child: SizedBox(height: 40),
//           ),
//         ],
//       ),
//     );
//   }
// }
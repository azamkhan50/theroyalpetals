import 'package:flutter/material.dart';
import 'package:royalpetals/widgets/category_widget.dart';
import 'package:royalpetals/widgets/home_header.dart';
import 'package:royalpetals/widgets/product_widget.dart';
import 'package:royalpetals/widgets/promo_banner.dart';
import 'package:royalpetals/widgets/search_bar_widget.dart';
import 'package:royalpetals/widgets/section_header.dart';
import 'package:royalpetals/widgets/shop_new.dart';
import 'package:royalpetals/widgets/shop_product_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Brand Color
  static const Color brandGold = Color(0xFFC39A38);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Custom Header (Profile & Location)
              const HomeHeader(),

              // 2. Search Bar
              const SearchBarWidget(),

              // 3. Promotional Banner
              const PromoCarousel(),

              const SizedBox(height: 10),

              // 4. Featured Products Section
              const SectionHeader(title: "Featured Products"),
              const CategoryFilterRow(),
              const ProductHorizontalList(),

              //const SizedBox(height: 10),

              // 5. New Arrivals Section
              // const SectionHeader(title: "New Arrivals"),
              // const CategoryFilterRow(),
              //  const ProductHorizontalList(),
            //  const SizedBox(height: 10),
                const SectionHeader(title: "Shop by Combos"),
               const  ShowNew(),
              const ShopProduct(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}




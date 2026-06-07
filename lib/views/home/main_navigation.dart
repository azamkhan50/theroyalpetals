import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royalpetals/controller/ProductController.dart';
import 'package:royalpetals/views/home/favorites_screen.dart';
import 'package:royalpetals/views/home/home_screen.dart';
import 'package:royalpetals/views/product/category_screen.dart';
import 'package:royalpetals/views/product/feature_product_screen.dart';
import 'package:royalpetals/views/product/my_cart_screen.dart';
import 'package:royalpetals/views/profile/profile_screen.dart';
import 'package:royalpetals/widgets/bottom_nav.dart';
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // INITIALIZE CONTROLLER HERE
  // This makes it available for HomeScreen, FavoritesScreen, etc.
  final ProductController productController = Get.put(ProductController());

  final List<Widget> _screens = [
    const HomeScreen(),
    const CategoryScreen(), 
    const FavoritesScreen(),
    const MyCartScreen(),
    const ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
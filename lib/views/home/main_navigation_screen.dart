// import 'package:flutter/material.dart';
// import 'package:royalpetals/views/home/cart_screen.dart';
// import 'package:royalpetals/views/home/favorites_screen.dart';
// import 'package:royalpetals/views/home/home_screen.dart';
// import 'package:royalpetals/views/profile/profile_screen.dart';
// import 'package:shopify_flutter/shopify_flutter.dart';



// class MainNavigationScreen extends StatefulWidget {
//    final int initialIndex;

//   const MainNavigationScreen({super.key, this.initialIndex = 0});
 

//   @override
//   State<MainNavigationScreen> createState() => _MainNavigationScreenState();
// }

// class _MainNavigationScreenState extends State<MainNavigationScreen> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     const HomeScreen(),
//     const FavoritesScreen(),
//     const CartScreen(),
//     const ProfileScreen()
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) => setState(() => _currentIndex = index),
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.pink,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
//           BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "Cart"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }
// // class MainNavigationScreen extends StatefulWidget {
// //   const MainNavigationScreen({super.key});

// //   @override
// //   State<MainNavigationScreen> createState() => _MainNavigationScreenState();
// // }

// // class _MainNavigationScreenState extends State<MainNavigationScreen> {
// //   int _selectedIndex = 0;
  
// //   // Define your screens here
// //   final List<Widget> _screens = [
// //     const HomeScreen(),
// //     const Center(child: Text("Favorites Screen")),
// //     const Center(child: Text("Cart Screen")),
// //     const Center(child: Text("Profile Screen")),
// //   ];

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: _screens[_selectedIndex],
// //       bottomNavigationBar: BottomNavigationBar(
// //         currentIndex: _selectedIndex,
// //         onTap: (index) => setState(() => _selectedIndex = index),
// //         type: BottomNavigationBarType.fixed,
// //         selectedItemColor: Colors.pink,
// //         unselectedItemColor: Colors.grey,
// //         items: const [
// //           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
// //           BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "Favorites"),
// //           BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: "Cart"),
// //           BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
// //         ],
// //       ),
// //     );
// //   }
// // }
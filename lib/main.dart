import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royalpetals/controller/ShopifyLoginController.dart';
import 'package:royalpetals/controller/cart_controller.dart';
import 'package:royalpetals/utils/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Ensure these imports match your project structure

import 'package:shopify_flutter/shopify_config.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   ShopifyConfig.setConfig(
    storefrontAccessToken: 'cfd6233d39f48a22965e2880afc2514f',
    storeUrl: 'theroyalpetals.com',
    storefrontApiVersion: '2024-07',
  );
await Get.putAsync(() => SharedPreferences.getInstance());
  // Initialize your permanent controllers
  // They will start loading their internal SharedPreferences immediately
 // Get.put(CartController(), permanent: true);
  Get.put(ShopifyLoginController(), permanent: true);
  await Get.putAsync(() async => CartController(), permanent: true);

 

  runApp(const RoyalPetalsApp());
}
// void main() async {
//   // 1. Ensure Flutter binding is initialized
//   WidgetsFlutterBinding.ensureInitialized();

//   // 2. Initialize Permanent Global Controllers
//   // Using Get.put here is correct for permanent global state
//   Get.put(CartController(), permanent: true);
// Get.put(ShopifyLoginController(), permanent: true);
//   // 3. Shopify Configuration
//   // Make sure you have the 'shopify_flutter' package or similar properly installed
//   ShopifyConfig.setConfig(
//     storefrontAccessToken: 'cfd6233d39f48a22965e2880afc2514f',
//     storeUrl: 'theroyalpetals.com',
//     storefrontApiVersion: '2024-07',
//   );

//   runApp(const RoyalPetalsApp());
// }

class RoyalPetalsApp extends StatelessWidget {
  const RoyalPetalsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Royal Petals',
      
      // 4. Routing Setup
      initialRoute: AppRoutes.splash, 
      getPages: AppRoutes.routes,
      
      // 5. Theme Configuration
      theme: ThemeData(
        // Seed color matches your "Petals" brand theme
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC39A38)), // Using your Brand Gold
        useMaterial3: true,
        fontFamily: 'Poppins', // Recommended for modern e-commerce apps
      ),
      
      // Default transition for a smoother app feel
      defaultTransition: Transition.cupertino, 
    );
  }
}



//2



// import 'package:flutter/material.dart';
// import 'package:royalpetals/views/auth/shopify_login_screen.dart';
// import 'package:royalpetals/views/home/main_navigation_screen.dart';
// import 'package:royalpetals/views/home/splash_screen.dart';
// import 'package:shopify_flutter/shopify_flutter.dart';
// // Make sure this path is correct for your project structure
// import 'package:royalpetals/views/home/home_screen.dart'; 

// void main() {
//   ShopifyConfig.setConfig(
//     storefrontAccessToken: 'cfd6233d39f48a22965e2880afc2514f',
//     storeUrl: 'theroyalpetals.com',
//     storefrontApiVersion: '2024-07', 
//   );

//   runApp(const RoyalPetalsApp());
// }

// class RoyalPetalsApp extends StatelessWidget {
//   const RoyalPetalsApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'The Royal Petals',
//       theme: ThemeData(
//         primarySwatch: Colors.pink,
//         useMaterial3: true,
//       ),
//       home:  ShopifyLoginScreen()
//       //SplashScreen()
//       // MainNavigationScreen(),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:royalpetals/views/home/home_screen.dart';
// import 'package:get/get.dart';
// import 'package:royalpetals/views/home/splash_screen.dart';
// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
       
//         colorScheme: .fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: const SplashScreen(),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royalpetals/views/auth/shopify_login_screen.dart';
import 'package:shopify_flutter/shopify_flutter.dart'; // Ensure this is installed // Update path as needed

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ShopifyConfig.setConfig(
    storefrontAccessToken: 'cfd6233d39f48a22965e2880afc2514f',
    storeUrl: 'theroyalpetals.com',
    storefrontApiVersion: '2024-07',
  );

  runApp(const RoyalPetalsApp());
}

class RoyalPetalsApp extends StatelessWidget {
  const RoyalPetalsApp({super.key});

  @override
  Widget build(BuildContext context) {
    // CRITICAL: Change MaterialApp to GetMaterialApp
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Royal Petals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: ShopifyLoginScreen(),
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



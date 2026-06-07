
// import 'package:flutter/material.dart';
// import 'package:flutter_appauth/flutter_appauth.dart';
// import 'package:royalpetals/views/home/main_navigation_screen.dart';



// class ShopifyLoginScreen extends StatefulWidget {
//   const ShopifyLoginScreen({super.key});

//   @override
//   State<ShopifyLoginScreen> createState() => _ShopifyLoginScreenState();
// }

// class _ShopifyLoginScreenState extends State<ShopifyLoginScreen> {
//   final FlutterAppAuth _appAuth = const FlutterAppAuth();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _codeController = TextEditingController();

//   // Configuration
//   final String _clientId = 'f0d02e49-f6f8-477a-9c86-5724b5182fad';
//   final String _redirectUrl = 'com.your.app.id://oauth-callback';
//   final String _authorizationEndpoint = 'https://shopify.com/authentication/81516691692/oauth/authorize';
//   final String _tokenEndpoint = 'https://shopify.com/authentication/81516691692/oauth/token';
//   final List<String> _scopes = ['openid', 'email', 'profile', 'customer_read'];

//   bool _isLoggingIn = false;
//   bool _isCodeSent = false; // Tracks if we should show the OTP field

//   Future<void> _handleShopifyLogin() async {
//     setState(() => _isLoggingIn = true);
//     try {
//       final AuthorizationTokenResponse? result = await _appAuth.authorizeAndExchangeCode(
//         AuthorizationTokenRequest(
//           _clientId,
//           _redirectUrl,
//           serviceConfiguration: AuthorizationServiceConfiguration(
//             authorizationEndpoint: _authorizationEndpoint,
//             tokenEndpoint: _tokenEndpoint,
//           ),
//           scopes: _scopes,
//         ),
//       );

//       if (result != null) {
//         _navigateToHome();
//       }
//     } catch (e) {
//       _showError("Login failed: $e");
//     } finally {
//       setState(() => _isLoggingIn = false);
//     }
//   }

//   void _handleSubmitEmail() {
//     if (_emailController.text.isNotEmpty) {
//       setState(() => _isCodeSent = true);
//     } else {
//       _showError("Please enter your email");
//     }
//   }

//   void _handleVerifyCode() {
//     if (_codeController.text.length == 6) {
//       // Logic to verify code would go here
//       _navigateToHome();
//     } else {
//       _showError("Please enter a valid 6-digit code");
//     }
//   }

//   void _navigateToHome() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
//     );
//   }

//   void _showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 80.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Image.network(
//                   'https://theroyalpetals.com/cdn/shop/files/the-royal-petals.jpg?v=1773263961&width=165',
//                   height: 80,
//                 ),
//               ),
//               const SizedBox(height: 40),
//               Text(
//                 _isCodeSent ? "Enter Code" : "Sign in",
//                 style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 _isCodeSent ? "We sent a 6-digit code to your email" : "Sign in or create an account",
//                 style: const TextStyle(color: Colors.grey, fontSize: 16),
//               ),
//               const SizedBox(height: 30),

//               // "Continue with Shop" Button (Only show if code not sent)
//               if (!_isCodeSent) ...[
//                 SizedBox(
//                   width: double.infinity,
//                   height: 55,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF5A31F4),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                       elevation: 0,
//                     ),
//                     onPressed: _isLoggingIn ? null : _handleShopifyLogin,
//                     child: _isLoggingIn
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text(
//                             "Continue with shop",
//                             style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                   ),
//                 ),
//                 const SizedBox(height: 25),
//                 const Row(
//                   children: [
//                     Expanded(child: Divider()),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 10),
//                       child: Text("or", style: TextStyle(color: Colors.grey)),
//                     ),
//                     Expanded(child: Divider()),
//                   ],
//                 ),
//                 const SizedBox(height: 25),
//               ],

//               // Email TextField
//               TextField(
//                 controller: _emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 enabled: !_isCodeSent, // Disable if code is already sent
//                 decoration: InputDecoration(
//                   hintText: "Email",
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
//                 ),
//               ),
              
//               const SizedBox(height: 15),

//               // NEW: 6-Digit Code TextField (Shows only after email submitted)
//               if (_isCodeSent) ...[
//                 TextField(
//                   controller: _codeController,
//                   keyboardType: TextInputType.number,
//                   maxLength: 6,
//                   decoration: InputDecoration(
//                     hintText: "Enter 6 digit code",
//                     counterText: "", // Hides the character counter
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//               ],

//               // Submit / Login Button
//               SizedBox(
//                 width: double.infinity,
//                 height: 55,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF005BD3),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                     elevation: 0,
//                   ),
//                   onPressed: _isCodeSent ? _handleVerifyCode : _handleSubmitEmail,
//                   child: Text(
//                     _isCodeSent ? "Login" : "Continue",
//                     style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
              
//               if (_isCodeSent)
//                 Center(
//                   child: TextButton(
//                     onPressed: () => setState(() => _isCodeSent = false),
//                     child: const Text("Edit Email", style: TextStyle(color: Color(0xFF005BD3))),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// // //3

// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';

// // import '../../controller/ShopifyLoginController.dart';

// // class ShopifyLoginScreen extends StatelessWidget {
// //   ShopifyLoginScreen({super.key});

// //   final controller = Get.put(ShopifyLoginController());

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 80.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Center(
// //                 child: Image.network(
// //                   'https://theroyalpetals.com/cdn/shop/files/the-royal-petals.jpg?v=1773263961&width=165',
// //                   height: 80,
// //                   errorBuilder: (context, error, stackTrace) =>
// //                       const Icon(Icons.store, size: 80),
// //                 ),
// //               ),
// //               const SizedBox(height: 40),
// //               Obx(() => Text(
// //                     controller.isCodeSent.value ? "Enter 6-digit Code" : "Sign in",
// //                     style:
// //                         const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
// //                   )),
// //               const SizedBox(height: 30),
// //               TextField(
// //                 controller: controller.emailController,
// //                 keyboardType: TextInputType.emailAddress,
// //                 decoration: InputDecoration(
// //                   hintText: "Email",
// //                   border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(12)),
// //                 ),
// //               ),
// //               const SizedBox(height: 15),
// //               Obx(() => controller.isCodeSent.value
// //                   ? TextField(
// //                       controller: controller.codeController,
// //                       keyboardType: TextInputType.number,
// //                       maxLength: 6,
// //                       decoration: InputDecoration(
// //                         hintText: "Enter 6 digit code",
// //                         counterText: "",
// //                         border: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(12)),
// //                       ),
// //                     )
// //                   : const SizedBox.shrink()),
// //               const SizedBox(height: 20),
// //               SizedBox(
// //                 width: double.infinity,
// //                 height: 55,
// //                 child: Obx(() => ElevatedButton(
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: const Color(0xFF005BD3),
// //                         shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(12)),
// //                       ),
// //                       onPressed: controller.isLoggingIn.value
// //                           ? null
// //                           : (controller.isCodeSent.value
// //                               ? controller.handleShopifyLogin
// //                               : controller.submitEmail),
// //                       child: controller.isLoggingIn.value
// //                           ? const CircularProgressIndicator(color: Colors.white)
// //                           : Text(
// //                               controller.isCodeSent.value ? "Login" : "Continue",
// //                               style: const TextStyle(
// //                                   color: Colors.white, fontSize: 16)),
// //                     )),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
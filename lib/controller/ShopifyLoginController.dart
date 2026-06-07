import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:royalpetals/utils/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopifyLoginController extends GetxController {
  final FlutterAppAuth _appAuth = const FlutterAppAuth();

  var isLoggingIn = false.obs;
  var email = ''.obs; // For input field

  // User Data Observables
  var userName = "Guest User".obs;
  var userEmail = "Not Logged In".obs;
  var accessToken = "".obs;

  final String _clientId = 'f0d02e49-f6f8-477a-9c86-5724b5182fad';
  final String _redirectUrl = 'shop.81516691692.app://callback';
  final List<String> _scopes = ['openid', 'email', 'customer-account-api:full'];

  @override
  void onInit() {
    super.onInit();
    _loadSavedUserData(); // Load data as soon as the controller is created
  }

  // --- PERSISTENCE METHODS ---

  // Load data from phone storage
  Future<void> _loadSavedUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedToken = prefs.getString('access_token');
    
    if (savedToken != null && savedToken.isNotEmpty) {
      accessToken.value = savedToken;
      userName.value = prefs.getString('user_name') ?? "Guest User";
      userEmail.value = prefs.getString('user_email') ?? "Not Logged In";
      debugPrint("Restored session for: ${userName.value}");
    }
  }

  // Save data to phone storage
  Future<void> _saveUserData(String token, String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
    await prefs.setString('user_name', name);
    await prefs.setString('user_email', email);
  }

  // Clear data (Logout)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clears all saved login data
    
    accessToken.value = "";
    userName.value = "Guest User";
    userEmail.value = "Not Logged In";
    
    Get.offAllNamed(AppRoutes.login);
  }

  // --- LOGIN LOGIC ---

  Future<void> loginWithEmail() async {
    isLoggingIn.value = true;
    try {
      final result = await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          _clientId,
          _redirectUrl,
          loginHint: email.value,
          serviceConfiguration: const AuthorizationServiceConfiguration(
            authorizationEndpoint: 'https://shopify.com/authentication/81516691692/oauth/authorize',
            tokenEndpoint: 'https://shopify.com/authentication/81516691692/oauth/token',
          ),
          scopes: _scopes,
          additionalParameters: {
            'audience': '350616da-0590-485d-88bc-2efcc6317b2b',
          },
        ),
      );

      if (result != null && result.accessToken != null) {
        accessToken.value = result.accessToken!;

        // DECODE JWT TOKEN
        Map<String, dynamic> decodedToken = JwtDecoder.decode(result.accessToken!);

        // Safely extract email and name
        userEmail.value = decodedToken['email'] ?? email.value;
        userName.value = decodedToken['name'] ?? (userEmail.value.contains('@') ? userEmail.value.split('@')[0] : "User");

        // SAVE TO LOCAL STORAGE
        await _saveUserData(accessToken.value, userName.value, userEmail.value);

        debugPrint("Logged in and saved: ${userName.value}");
        Get.offAllNamed(AppRoutes.mainNav);
      }
    } catch (e) {
      debugPrint("Login Error: $e");
      Get.snackbar(
        "Error",
        "Login failed: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoggingIn.value = false;
    }
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_appauth/flutter_appauth.dart';
// import 'package:get/get.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:royalpetals/utils/app_routes.dart';
// import 'package:shared_preferences/shared_preferences.dart'; // Add this package


// class ShopifyLoginController extends GetxController {
//   final FlutterAppAuth _appAuth = const FlutterAppAuth();

//   var isLoggingIn = false.obs;
//   var email = ''.obs; // For input field

//   // User Data Observables
//   var userName = "Guest User".obs;
//   var userEmail = "Not Logged In".obs;
//   var accessToken = "".obs;

//   final String _clientId = 'f0d02e49-f6f8-477a-9c86-5724b5182fad';
//   final String _redirectUrl = 'shop.81516691692.app://callback';

//   final List<String> _scopes = ['openid', 'email', 'customer-account-api:full'];
//   Future<void> loginWithEmail() async {
//     isLoggingIn.value = true;
//     try {
//       final result = await _appAuth.authorizeAndExchangeCode(
//         AuthorizationTokenRequest(
//           _clientId,
//           _redirectUrl,
//           loginHint: email.value,
//           serviceConfiguration: const AuthorizationServiceConfiguration(
//             authorizationEndpoint:
//                 'https://shopify.com/authentication/81516691692/oauth/authorize',
//             tokenEndpoint:
//                 'https://shopify.com/authentication/81516691692/oauth/token',
//           ),
//           scopes: _scopes,
//           additionalParameters: {
//             'audience': '350616da-0590-485d-88bc-2efcc6317b2b',
//           },
//         ),
//       );

//       // Use safe navigation ?. and check for null
//       if (result != null && result.accessToken != null) {
//         accessToken.value = result.accessToken!;

//         // DECODE JWT TOKEN
//         Map<String, dynamic> decodedToken = JwtDecoder.decode(
//           result.accessToken!,
//         );

//         // Safely extract email
//         userEmail.value = decodedToken['email'] ?? email.value ?? "No Email";

//         // Safely extract name or fallback to the part of email before @
//         userName.value =
//             decodedToken['name'] ??
//             (userEmail.value.contains('@')
//                 ? userEmail.value.split('@')[0]
//                 : "User");

//         debugPrint("Logged in as: ${userName.value}");

//         // FIX: Remove the quotes around AppRoutes.mainNav
//         Get.offAllNamed(AppRoutes.mainNav);
//       }
//     } catch (e) {
//       debugPrint("Login Error: $e");
//       Get.snackbar(
//         "Error",
//         "Login failed: $e",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoggingIn.value = false;
//     }
//   }
  
// }



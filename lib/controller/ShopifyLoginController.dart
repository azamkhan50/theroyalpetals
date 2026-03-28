import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

class ShopifyLoginController extends GetxController {
  final FlutterAppAuth _appAuth = const FlutterAppAuth();
  
  final emailController = TextEditingController();
  final codeController = TextEditingController();

  var isLoggingIn = false.obs;
  var isCodeSent = false.obs;

  // Shopify Config
  final String _clientId = 'f0d02e49-f6f8-477a-9c86-5724b5182fad';
  final String _redirectUrl = 'com.your.app.id://oauth-callback';
  final String _shop = 'the-royal-petals-2.myshopify.com'; // e.g., myshop.myshopify.com
  final List<String> _scopes = ['read_customers', 'read_orders'];

  // 1. Submit Email Logic
  Future<void> submitEmail() async {
    String email = emailController.text.trim();
    if (!GetUtils.isEmail(email)) {
      _showError("Invalid Email", "Please enter a valid email address");
      return;
    }

    isLoggingIn.value = true;
    try {
      // Simulate sending OTP
      await Future.delayed(const Duration(seconds: 2));
      isCodeSent.value = true;
      Get.rawSnackbar(
        title: "Code Sent",
        message: "Check your email for the 6-digit code.",
        backgroundColor: Colors.green.withOpacity(0.8),
      );
    } catch (e) {
      _showError("Error", "Failed to send code: $e");
    } finally {
      isLoggingIn.value = false;
    }
  }

  // 2. OAuth Login Logic
  Future<void> handleShopifyLogin() async {
    isLoggingIn.value = true;
    try {
      final authEndpoint = 'https://$_shop/admin/oauth/authorize';
      final tokenEndpoint = 'https://$_shop/admin/oauth/access_token';

      final result = await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          _clientId,
          _redirectUrl,
          serviceConfiguration: AuthorizationServiceConfiguration(
            authorizationEndpoint: authEndpoint,
            tokenEndpoint: tokenEndpoint,
          ),
          scopes: _scopes,
        ),
      );

      if (result != null) {
        print("Access Token: ${result.accessToken}");
        Get.rawSnackbar(
          title: "Login Success",
          message: "You are now logged in.",
          backgroundColor: Colors.green.withOpacity(0.8),
        );
        // Navigate to your home/profile screen
      }
    } catch (e) {
      print("Login Error: $e");
      _showError("Login Failed", "Authentication failed or was cancelled.");
    } finally {
      isLoggingIn.value = false;
    }
  }

  void _showError(String title, String message) {
    Get.rawSnackbar(
      title: title,
      message: message,
      backgroundColor: Colors.redAccent,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(15),
      borderRadius: 10,
    );
  }
}
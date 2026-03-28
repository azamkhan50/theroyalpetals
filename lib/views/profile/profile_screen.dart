import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve email passed from previous screen
    final String userEmail = Get.arguments ?? "User";

    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), elevation: 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_circle, size: 100, color: Color(0xFF005BD3)),
            const SizedBox(height: 20),
            Text(userEmail, style: const TextStyle(fontSize: 20, color: Colors.grey)),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () => Get.offAllNamed('/login'), // Logout and clear stack
                child: const Text("Logout", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
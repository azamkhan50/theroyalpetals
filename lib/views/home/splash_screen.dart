

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royalpetals/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Get.put(SplashController());

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff7B1FA2),
              Color(0xffBA68C8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Icon(
                Icons.local_florist,
                size: 90,
                color: Colors.white,
              ),

              SizedBox(height: 20),

              Text(
                "Royal Petals",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 20),

              CircularProgressIndicator(color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}
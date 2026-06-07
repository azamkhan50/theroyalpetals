import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final IconData? icon; // For Flutter Icons
  final String? imagePath; // For Figma Exported Assets (e.g., 'assets/google.png')

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFC39A38),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. Check for Image Asset first
            if (imagePath != null) ...[
              Image.asset(
                imagePath!,
                width: 20,
                height: 20,
                // color: Colors.white, // Uncomment if you want to tint the image white
              ),
              const SizedBox(width: 10),
            ] 
            // 2. Otherwise check for IconData
            else if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 10),
            ],

            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
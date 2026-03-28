import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool centerAlign;

  const SectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.centerAlign = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment:
            centerAlign ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: const Color(0xFFD4AF37),
              letterSpacing: 2,
              fontFamily: 'Georgia',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: centerAlign ? TextAlign.center : TextAlign.left,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
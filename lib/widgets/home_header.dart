import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royalpetals/views/home/home_screen.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/image/person.png') // Replace with user image
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome", style: GoogleFonts.cabin(color: Colors.grey, fontSize: 14)),
                  Text("Mr. Haseeb", style: GoogleFonts.cabin(fontWeight: FontWeight.bold, fontSize: 18, color: HomeScreen.brandGold)),
                ],
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, color: HomeScreen.brandGold, size: 20),
              const SizedBox(width: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Deliver to", style: GoogleFonts.cabin(fontSize: 10, color: Colors.grey)),
                  Text("Saudi, Riyadh", style: GoogleFonts.cabin(fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
              const Icon(Icons.keyboard_arrow_down, size: 16),
            ],
          )
        ],
      ),
    );
  }
}
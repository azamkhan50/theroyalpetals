// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:royalpetals/views/home/home_screen.dart';

// class PromoBanner extends StatelessWidget {
//   const PromoBanner({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(20),
//       height: 180,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         image: const DecorationImage(
//           image: AssetImage('assets/images/Frame1.png'), // Replace with flower girl image
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(color: HomeScreen.brandGold.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
//                   child: Text("Saudi No 1 Gifting Platform", style: GoogleFonts.cabin(fontSize: 8, fontWeight: FontWeight.bold)),
//                 ),
//                 const SizedBox(height: 8),
//                 Text("Every Celebration,\nOne Destination.", style: GoogleFonts.cabin(fontSize: 18, fontWeight: FontWeight.bold, height: 1.2)),
//                 const SizedBox(height: 8),
//                 SizedBox(
//                   width: 150,
//                   child: Text("Curated by 'THE ROYAL PETALS' to make every moment unforgettable.", style: GoogleFonts.cabin(fontSize: 10, color: Colors.black54)),
//                 ),
//                 const SizedBox(height: 12),
//                 ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: HomeScreen.brandGold,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
//                   ),
//                   child: Text("Shop Now", style: GoogleFonts.cabin(fontSize: 12, color: Colors.white)),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PromoCarousel extends StatefulWidget {
  const PromoCarousel({super.key});

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  final List<String> _banners = [
    "assets/image/Frame1.png",
    "assets/image/Frame1.png",
    "assets/image/Frame1.png",
  ];

  @override
  void initState() {
    super.initState();
    // FIX: Set viewportFraction to 0.9 to see a preview of the next slide
    // This makes the container occupy 90% of the screen width
    _pageController = PageController(initialPage: 0, viewportFraction: 0.9);

    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < _banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color brandGold = Color(0xFFC39A38);

    return Column(
      children: [
        SizedBox(
          height: 200, // Slightly reduced height to fit better
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: _banners.length,
            itemBuilder: (context, index) {
              return _buildBannerItem(_banners[index]);
            },
          ),
        ),
        const SizedBox(height: 10), // Space between banner and dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _banners.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: _currentPage == index ? 24 : 8,
              decoration: BoxDecoration(
                color: _currentPage == index ? brandGold : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBannerItem(String imagePath) {
    return Container(
      // horizontal: 8 works best when using viewportFraction: 0.9
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.fill, // Use fill if your Frame1.png is already banner-shaped
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RoyalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton; // New property to control the arrow

  const RoyalAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = true, // Default to true so you don't have to change every screen
  });

  @override
  Widget build(BuildContext context) {
    const Color brandGold = Color(0xFFC39A38);

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      toolbarHeight: 80,
      leadingWidth: 80,
      // Logic: If showBackButton is true, show the container. If false, show null.
      leading: showBackButton 
          ? Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Center(
                child: InkWell(
                  onTap: () => Get.back(),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black.withOpacity(0.05)),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: brandGold,
                      size: 20,
                    ),
                  ),
                ),
              ),
            )
          : null, 
      title: Text(
        title,
        style: GoogleFonts.cabin(
          color: brandGold,
          fontWeight: FontWeight.w600,
          fontSize: 22,
        ),
      ),
      actions: actions != null 
          ? [...actions!, const SizedBox(width: 10)] 
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// class RoyalAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final List<Widget>? actions; // Changed from Widget? to List<Widget>?

//   const RoyalAppBar({
//     super.key,
//     required this.title,
//     this.actions, // Updated constructor
//   });

//   @override
//   Widget build(BuildContext context) {
//     const Color brandGold = Color(0xFFC39A38);

//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       centerTitle: true,
//       toolbarHeight: 80,
//       leadingWidth: 80,
//       leading: Padding(
//         padding: const EdgeInsets.only(left: 20.0),
//         child: Center(
//           child: InkWell(
//             onTap: () => Get.back(),
//             borderRadius: BorderRadius.circular(10),
//             child: Container(
//               height: 48,
//               width: 48,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Colors.black.withOpacity(0.05)),
//               ),
//               child: const Icon(
//                 Icons.arrow_back,
//                 color: brandGold,
//                 size: 20,
//               ),
//             ),
//           ),
//         ),
//       ),
//       title: Text(
//         title,
//         style: GoogleFonts.cabin(
//           color: brandGold,
//           fontWeight: FontWeight.w600,
//           fontSize: 22,
//         ),
//       ),
//       // Use the list of actions here
//       actions: actions != null 
//           ? [...actions!, const SizedBox(width: 10)] 
//           : null,
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(80);
// }

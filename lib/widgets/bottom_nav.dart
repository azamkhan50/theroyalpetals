import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Your brand gold color from RGBA(195, 154, 56, 1)
    const Color brandGold = Color(0xFFC39A38);
    const Color inactiveGrey = Color(0xFF9E9E9E);

    return Container(
      height: 85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home_outlined, "Home", brandGold, inactiveGrey),
          _buildNavItem(1, Icons.grid_view_outlined, "Categories", brandGold, inactiveGrey),
          _buildNavItem(2, Icons.favorite_outline, "Wishlist", brandGold, inactiveGrey),
          _buildNavItem(3, Icons.shopping_basket_outlined, "My Cart", brandGold, inactiveGrey),
          _buildNavItem(4, Icons.person_outline, "Profile", brandGold, inactiveGrey),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, Color activeColor, Color inactiveColor) {
    bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              // Apply the specific 2.2px border only if selected
              border: isSelected 
                  ? Border.all(color: activeColor, width: 2.2) 
                  : Border.all(color: Colors.transparent, width: 2.2),
            ),
            child: Icon(
              icon,
              color: isSelected ? activeColor : inactiveColor,
              size: 26,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? activeColor : inactiveColor,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
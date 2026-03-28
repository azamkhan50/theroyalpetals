
import 'package:flutter/material.dart';

class CartSheet extends StatelessWidget {
  final dynamic product;
  final int quantity;

  const CartSheet({super.key, required this.product, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Shopping Cart ($quantity)", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              ],
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("You're out of time! Checkout now to avoid losing your order!", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 20),
                  
                  // Item Row
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(product.images.first.originalSrc, width: 70, height: 70, fit: BoxFit.cover),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                            Text(product.formattedPrice, style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 40),
                  const Text("You may also like...", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  // Placeholder for recommendation
                  _buildRecItem(),
                ],
              ),
            ),
          ),
          
          // Sticky Bottom Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade200))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Subtotal", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(product.formattedPrice, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.black), shape: const StadiumBorder()),
                    child: const Text("View Cart", style: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: const StadiumBorder()),
                    child: const Text("Checkout", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecItem() {
    return Row(
      children: [
        Container(width: 70, height: 70, decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8))),
        const SizedBox(width: 15),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Similar Product", style: TextStyle(fontSize: 14)),
            Text("Add To Cart", style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
          ],
        )
      ],
    );
  }
}
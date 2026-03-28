
import 'package:flutter/material.dart';
import 'package:royalpetals/widgets/cart_manager.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    var items = CartManager.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        centerTitle: true,
      ),
      body: items.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      var item = items[index];

                      return _cartItem(item);
                    },
                  ),
                ),

                // Bottom Section
                _bottomSection(),
              ],
            ),
    );
  }

  Widget _cartItem(CartItem item) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Image.network(
            item.product.images.first.originalSrc,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product.title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text("${item.product.price} SAR",
                    style: const TextStyle(color: Colors.pink)),
              ],
            ),
          ),

          // Quantity
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if (item.quantity > 1) {
                    setState(() {
                      item.quantity--;
                    });
                  }
                },
              ),
              Text(item.quantity.toString()),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    item.quantity++;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bottomSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Subtotal", style: TextStyle(fontSize: 16)),
              Text("${CartManager.subtotal.toStringAsFixed(2)} SAR",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),

          const SizedBox(height: 15),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: const StadiumBorder(),
              ),
              onPressed: () {},
              child: const Text("Checkout",style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:royalpetals/model/GiftCategory.dart';

class ProductCardWidget extends StatelessWidget {
  final Product product;

  const ProductCardWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage('https://theroyalpetals.com/cdn/shop/files/pEBbqfi3A5so2Z5lXJkSw0o4Gik76HBf.webp?v=1772721411&width=330'),
                 // AssetImage(product.imagePath),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (product.description.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              product.description,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.black54,
              ),
            ),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD4AF37),
                ),
              ),
              if (product.oldPrice != null) ...[
                const SizedBox(width: 8),
                Text(
                  '\$${product.oldPrice!.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
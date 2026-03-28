import 'package:flutter/material.dart';
class GiftCategory {
  final String title;
  final String subtitle;
  final String imagePath;
  final Color accentColor;

  GiftCategory({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.accentColor = const Color(0xFFD4AF37),
  });
}

class Product {
  final String name;
  final String description;
  final double price;
  final String imagePath;
  final double? oldPrice;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    this.oldPrice,
  });
}

class HeroCard {
  final String title;
  final String subtitle;
  final String imagePath;
  final String tag;

  HeroCard({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.tag,
  });
}

// Mock Data
class DataProvider {
  static List<HeroCard> get heroCards => [
        HeroCard(
          title: 'Mother\'s Day',
          subtitle: 'Celebrate mom',
          imagePath: 'assets/mothers_day.jpg',
          tag: 'MOTHER',
        ),
        HeroCard(
          title: 'Father\'s Day',
          subtitle: 'Honor dad',
          imagePath: 'assets/fathers_day.jpg',
          tag: 'FATHER',
        ),
        HeroCard(
          title: 'Valentine\'s Day',
          subtitle: 'Share love',
          imagePath: 'assets/valentines.jpg',
          tag: 'VALENTINE',
        ),
      ];

  static List<GiftCategory> get categories => [
        GiftCategory(
          title: 'RAMADAN GIFTS',
          subtitle: 'Thoughtful gifts to celebrate the blessings of Ramadan',
          imagePath: 'assets/ramadan.jpg',
        ),
        GiftCategory(
          title: 'LOVE AND ROMANCE',
          subtitle: 'Perfect gifts to express your love and affection',
          imagePath: 'assets/romance.jpg',
        ),
        GiftCategory(
          title: 'BIRTHDAY GIFTS',
          subtitle: 'Make every birthday celebration extra special',
          imagePath: 'assets/birthday.jpg',
        ),
        GiftCategory(
          title: 'EID DAY GIFTS',
          subtitle: 'Joyful gifts to celebrate the spirit of Eid',
          imagePath: 'assets/eid.jpg',
        ),
        GiftCategory(
          title: 'GET WELL SOON',
          subtitle: 'Send comfort, care, and warm wishes',
          imagePath: 'assets/getwell.jpg',
        ),
        GiftCategory(
          title: 'GRADUATION',
          subtitle: 'Celebrate success and new beginnings',
          imagePath: 'assets/graduation.jpg',
        ),
      ];

  static List<Product> get featuredProducts => [
        Product(
          name: 'Luxury Roses Bouquet Gift',
          description: 'Arrangement',
          price: 299.00,
          oldPrice: 349.00,
          imagePath: 'assets/product1.jpg',
        ),
        Product(
          name: 'Red Round Orchid Balloon Bouquet',
          description: '',
          price: 159.00,
          imagePath: 'assets/product2.jpg',
        ),
        Product(
          name: 'Colorful Balloon Balloon Bouquet',
          description: '',
          price: 129.00,
          oldPrice: 149.00,
          imagePath: 'assets/product3.jpg',
        ),
        Product(
          name: 'Luxury Red & Gold Balloon Bouquet',
          description: '',
          price: 199.00,
          imagePath: 'assets/product4.jpg',
        ),
      ];
}

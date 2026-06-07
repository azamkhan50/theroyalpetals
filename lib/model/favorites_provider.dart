import 'package:flutter/material.dart';
import 'package:shopify_flutter/shopify_flutter.dart';

// Simple global state for Favorites
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopify_flutter/shopify_flutter.dart';

class FavoritesManager {
  static List<Product> favoriteProducts = [];
  static const String _key = 'favorite_ids';

  // 1. Load IDs from storage and match them with the current product list
  static Future<void> loadFavorites(List<Product> allProducts) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedIds = prefs.getStringList(_key) ?? [];
    
    // Match saved IDs with the actual Product objects
    favoriteProducts = allProducts.where((p) => savedIds.contains(p.id)).toList();
  }

  // 2. Save current favorite IDs to storage
  static Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> idsToSave = favoriteProducts.map((p) => p.id).toList();
    await prefs.setStringList(_key, idsToSave);
  }

  static bool isFavorite(Product product) {
    return favoriteProducts.any((p) => p.id == product.id);
  }
static void toggleFavorite(Product product) {
  // Use product.id to compare because object instances might change
  if (isFavorite(product)) {
    favoriteProducts.removeWhere((p) => p.id == product.id);
  } else {
    favoriteProducts.add(product);
  }
  _saveToStorage(); 
}
  // static void toggleFavorite(Product product) {
  //   if (isFavorite(product)) {
  //     favoriteProducts.removeWhere((p) => p.id == product.id);
  //   } else {
  //     favoriteProducts.add(product);
  //   }
  //   _saveToStorage(); // Save every time someone clicks the heart
  // }
}
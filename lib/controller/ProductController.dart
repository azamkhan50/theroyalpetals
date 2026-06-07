

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:royalpetals/model/favorites_provider.dart';
import 'package:shopify_flutter/shopify_flutter.dart';


class ProductController extends GetxController {
  var allProducts = <Product>[].obs;
  var filteredProducts = <Product>[].obs;
  var comboProducts = <Product>[].obs;
  var favoriteProducts = <Product>[].obs;
  var categories = <Collection>[].obs;

  // SEPARATED LOADING STATES
  var isInitialLoading = false.obs; // For the first fetch
  var isFilterLoading = false.obs;  // For ProductHorizontalList
  var isComboLoading = false.obs;   // For ShopProduct

  var selectedStaticCategory = "All".obs;
  var selectedComboCategory = "All".obs;

  @override
  void onInit() {
    super.onInit();
    fetchInitialData();
    fetchAllCategories();
  }

  void fetchInitialData() async {
    try {
      isInitialLoading(true);
      // Fetch both categories and products
      List<Collection> colls = await ShopifyStore.instance.getAllCollections();
      categories.assignAll(colls);

      List<Product> products = await ShopifyStore.instance.getAllProducts();
      await FavoritesManager.loadFavorites(products);
      favoriteProducts.assignAll(FavoritesManager.favoriteProducts);

      allProducts.assignAll(products);
      filteredProducts.assignAll(products);
      comboProducts.assignAll(products); // Initial state
    } catch (e) {
      debugPrint("Init Error: $e");
    } finally {
      isInitialLoading(false);
    }
  }

  // Filter for ProductHorizontalList (CategoryFilterRow)
  void filterByCategory(String categoryTitle) async {
    try {
      isFilterLoading(true); // ONLY triggers ProductHorizontalList
      selectedStaticCategory.value = categoryTitle;

      final collection = categories.firstWhereOrNull(
        (c) => c.title?.toLowerCase() == categoryTitle.toLowerCase()
      );

      if (collection != null && collection.id != null) {
        List<Product> result = await ShopifyStore.instance.getXProductsAfterCursorWithinCollection(
          collection.id!,
          20,
        ) ?? [];
        filteredProducts.assignAll(result);
      } else {
        filteredProducts.assignAll(allProducts);
      }
    } catch (e) {
      debugPrint("Filter error: $e");
    } finally {
      isFilterLoading(false);
    }
  }

  // Filter for ShopProduct (ShowNew)
  void filterByComboCategory(String categoryTitle) async {
    try {
      isComboLoading(true); // ONLY triggers ShopProduct
      selectedComboCategory.value = categoryTitle;

      final collection = categories.firstWhereOrNull(
        (c) => c.title?.toLowerCase() == categoryTitle.toLowerCase()
      );

      if (collection != null) {
        List<Product> result = await ShopifyStore.instance.getXProductsAfterCursorWithinCollection(
          collection.id!,
          20,
        ) ?? [];
        comboProducts.assignAll(result);
      }
    } catch (e) {
      debugPrint("Combo filter error: $e");
    } finally {
      isComboLoading(false);
    }
  }
   void fetchAllCategories() async {
  try {
    // 1. Fetch the collections
    List<Collection> result = await ShopifyStore.instance.getAllCollections();
    
    // 2. Assign to your observable list
    categories.assignAll(result);

    // 3. Print the names of each category
    debugPrint("--- List of Category Names (${categories.length}) ---");
    for (var collection in result) {
      debugPrint("Category Name: ${collection.title} | Handle: ${collection.handle}");
    }
    
    debugPrint("------------------------------------------");

  } catch (e) {
    debugPrint("Category Fetch Error: $e");
  }
}

  void toggleFav(Product product) {
    FavoritesManager.toggleFavorite(product);
    favoriteProducts.assignAll(FavoritesManager.favoriteProducts);
  }
 void filterProducts(String query) {
    if (query.isEmpty) {
      // If search is cleared, show everything
      filteredProducts.assignAll(allProducts);
    } else {
      // Filter based on the master list (allProducts)
      final results = allProducts.where((product) {
        final title = (product.title ?? "").toLowerCase();
        final search = query.toLowerCase();
        return title.contains(search);
      }).toList();
      
      filteredProducts.assignAll(results);
    }
  }
  bool isProductFavorite(String id) => favoriteProducts.any((p) => p.id == id);
}
// class ProductController extends GetxController {
//   var allProducts = <Product>[].obs;
//   var filteredProducts = <Product>[].obs;
//   var comboProducts = <Product>[].obs;
//   // 1. Add an observable list for Favorites
//   var favoriteProducts = <Product>[].obs; 
//   var categories = <Collection>[].obs; // To store category list
//   var isLoading = false.obs;
//   var selectedCategoryHandle = "".obs;
//   var selectedStaticCategory = "All".obs;
//   var selectedComboCategory = "All".obs;
  

//   @override
//   void onInit() {
//     super.onInit();
//     fetchProducts();
//     fetchAllCategories();
//   }
//   void fetchAllCategories() async {
//   try {
//     // 1. Fetch the collections
//     List<Collection> result = await ShopifyStore.instance.getAllCollections();
    
//     // 2. Assign to your observable list
//     categories.assignAll(result);

//     // 3. Print the names of each category
//     debugPrint("--- List of Category Names (${categories.length}) ---");
//     for (var collection in result) {
//       debugPrint("Category Name: ${collection.title} | Handle: ${collection.handle}");
//     }
    
//     debugPrint("------------------------------------------");

//   } catch (e) {
//     debugPrint("Category Fetch Error: $e");
//   }
// }
// // void fetchAllCategories() async {
// //     try {
// //       var result = await ShopifyStore.instance.getAllCollections();
// //       categories.assignAll(result);
// //       debugPrint("Fetched ${categories.length} categories");
// //     } catch (e) {
// //       debugPrint("Category Fetch Error: $e");
// //     }
// //   }

//   void fetchProducts() async {
//     try {
//       isLoading(true);
//       List<Product> products = await ShopifyStore.instance.getAllProducts();
      
//       // 2. Load from storage and update the observable list
//       await FavoritesManager.loadFavorites(products);
//       favoriteProducts.assignAll(FavoritesManager.favoriteProducts);

//       allProducts.assignAll(products);
//       filteredProducts.assignAll(products);
      

//     } catch (e) {
//       print("Error: $e");
//     } finally {
//       isLoading(false);
//     }
//   }

//   // NEW Method to filter specifically for the Combo list
//   void filterByComboCategory(String categoryTitle) async {
//     try {
//       isLoading(true);
//       selectedComboCategory.value = categoryTitle; // Update the combo-specific selection

//       final collection = categories.firstWhereOrNull(
//         (c) => c.title?.toLowerCase() == categoryTitle.toLowerCase()
//       );

//       if (collection != null) {
//         List<Product> result = await ShopifyStore.instance.getXProductsAfterCursorWithinCollection(
//           collection.id!,
//           20,
//         ) ?? [];
//         comboProducts.assignAll(result);
//       }
//     } catch (e) {
//       debugPrint("Combo filter error: $e");
//     } finally {
//       isLoading(false);
//     }
//   }

// // --- ADDED THIS METHOD TO FIX YOUR ERROR ---
// void filterByCategory(String categoryTitle) async {
//   try {
//     isLoading(true);
//     selectedStaticCategory.value = categoryTitle;

//     // 1. Find the collection object from your loaded categories list that matches the title
//     // We do this because we need the real Shopify ID, not just the name
//     final collection = categories.firstWhereOrNull(
//       (c) => c.title?.toLowerCase() == categoryTitle.toLowerCase()
//     );

//     if (collection != null && collection.id != null) {
//       // 2. Pass the collection.id (the long ID string), not the handle
//       List<Product> result = await ShopifyStore.instance.getXProductsAfterCursorWithinCollection(
//         collection.id!, // Use ID here
//         20,
//       ) ?? [];

//       filteredProducts.assignAll(result);
//     } else {
//       debugPrint("Collection not found for: $categoryTitle");
//       // Optional: if not found, show all products
//       filteredProducts.assignAll(allProducts);
//     }
//   } catch (e) {
//     debugPrint("Error filtering by category: $e");
//   } finally {
//     isLoading(false);
//   }
// }
//   // void filterByCategory(String collectionHandle) async {
//   //   try {
//   //     isLoading(true);
//   //     selectedCategoryHandle.value = collectionHandle; // This updates the color

//   //     // Fetch products for this specific category
//   //     List<Product> result = await ShopifyStore.instance.getXProductsAfterCursorWithinCollection(
//   //       collectionHandle, 
//   //       20
//   //     ) ?? []; 
      
//   //     filteredProducts.assignAll(result);
//   //   } catch (e) {
//   //     debugPrint("Error filtering by category: $e");
//   //   } finally {
//   //     isLoading(false);
//   //   }
//   // }
//   // 3. Global toggle method
//   void toggleFav(Product product) {
//     FavoritesManager.toggleFavorite(product);
//     // Update the observable list so GetX UI refreshes everywhere
//     favoriteProducts.assignAll(FavoritesManager.favoriteProducts);
//   }

//   // 4. Check if favorite
//   bool isProductFavorite(String id) {
//     return favoriteProducts.any((p) => p.id == id);
//   }
//    void filterProducts(String query) {
//     if (query.isEmpty) {
//       // If search is cleared, show everything
//       filteredProducts.assignAll(allProducts);
//     } else {
//       // Filter based on the master list (allProducts)
//       final results = allProducts.where((product) {
//         final title = (product.title ?? "").toLowerCase();
//         final search = query.toLowerCase();
//         return title.contains(search);
//       }).toList();
      
//       filteredProducts.assignAll(results);
//     }
//   }

// }

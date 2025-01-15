

import 'package:Saz/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

class FavoriteProductController extends GetxController {
  final RxList<Product> favoriteProducts = <Product>[].obs;
  final GetStorage storage = GetStorage(); // Access GetStorage
  final String storageKey = 'favoriteProducts';

  @override
  void onInit() {
    super.onInit();
    loadFavorites(); // Load favorites from storage when the controller initializes
  }

  // Load favorite products from GetStorage
  void loadFavorites() {
    final storedData = storage.read<List<dynamic>>(storageKey);
    if (storedData != null) {
      favoriteProducts.assignAll(storedData.map((e) => Product.fromMap(e)).toList());
    }
  }

  // Save favorite products to GetStorage
  void saveFavorites() {
    storage.write(storageKey, favoriteProducts.map((p) => p.toMap()).toList());
  }

  // Check if a product is favorite
  bool isFavorite(Product product) {
    return favoriteProducts.any((p) => p.id == product.id);
  }

  // Add or remove a product from favorites
  void toggleFavorite(Product product) {
    if (isFavorite(product)) {
      favoriteProducts.removeWhere((p) => p.id == product.id);
    } else {
      favoriteProducts.add(product);
    }
    saveFavorites(); // Persist changes
  }

  // Get all favorite products
  List<Product> getFavorites() {
    return favoriteProducts;
  }
}
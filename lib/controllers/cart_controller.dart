

import 'package:Saz/controllers/product_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartProduct {
  final Product product;
  int quantity;

  CartProduct({
    required this.product,
    this.quantity = 1,
  });

  // Convert CartProduct to Map (for storage)
  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  // Convert Map to CartProduct (for loading)
  static CartProduct fromMap(Map<String, dynamic> map) {
    return CartProduct(
      product: Product.fromMap(map['product']),
      quantity: map['quantity'],
    );
  }
}

class CartController extends GetxController {
  final RxList<CartProduct> cartItems = <CartProduct>[].obs;
  final GetStorage storage = GetStorage(); // Access GetStorage
  final String storageKey = 'cartItems';

  @override
  void onInit() {
    super.onInit();
    loadCart(); // Load cart items from storage when the controller initializes
  }

  // Load cart items from GetStorage
  void loadCart() {
    final storedData = storage.read<List<dynamic>>(storageKey);
    if (storedData != null) {
      cartItems.assignAll(storedData.map((e) => CartProduct.fromMap(e)).toList());
    }
  }

  // Save cart items to GetStorage
  void saveCart() {
    storage.write(storageKey, cartItems.map((p) => p.toMap()).toList());
  }

  // Add or update a product in the cart
  void addToCart(Product product) {
    final existingCartProduct = cartItems.firstWhereOrNull((p) => p.product.id == product.id);

    if (existingCartProduct != null) {
      // If product is already in the cart, increase quantity
      existingCartProduct.quantity++;
    } else {
      // If product is not in the cart, add it
      cartItems.add(CartProduct(product: product, quantity: 1)); // Set initial quantity to 1
    }

    saveCart(); // Persist cart changes
  }

  // Remove a product from the cart
  void removeFromCart(Product product) {
    cartItems.removeWhere((p) => p.product.id == product.id);
    saveCart(); // Persist cart changes
  }

void updateQuantity(Product product, int newQuantity) {
  final cartIndex = cartItems.indexWhere((p) => p.product.id == product.id);

  if (cartIndex != -1) {
    if (newQuantity >= 1) {
      cartItems[cartIndex].quantity = newQuantity; // Update quantity
      cartItems.refresh(); // Notify observers about the change
      saveCart(); // Persist changes
    } else {
      removeFromCart(product); // Remove the product if quantity is less than 1
    }
  }
}


 bool isInCart(Product product) {
    final cartProduct = cartItems.firstWhereOrNull(
      (p) => p.product.id == product.id,
    );
    return cartProduct!= null;
  }


  // Get all cart items
  List<CartProduct> getCartItems() {
    return cartItems;
  }

  int totalCount(){
    return cartItems.length;
  }

  // Get the total price of the cart
  double getTotalPrice() {
    return cartItems.fold(0.0, (total, cartProduct) => total + (cartProduct.product.salePrice * cartProduct.quantity));
  }
}


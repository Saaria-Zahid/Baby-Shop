


import 'package:Saz/common/widgets/appbar/appbar_screen.dart';
import 'package:Saz/controllers/cart_controller.dart';
import 'package:Saz/screens/authentication/screen/checkout/checkout.dart';
import 'package:Saz/utils/constants/colors.dart';
import 'package:Saz/utils/constants/sizes.dart';
import 'package:Saz/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              // Handle clearing the cart
              cartController.cartItems.clear();
              cartController.saveCart();
            },
          ),
        ],
      ),
      body: Obx(() {
        final cartItems = cartController.getCartItems();

        if (cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart, size: 100, color: Colors.grey),
                Text('Your cart is empty', style: TextStyle(fontSize: 18, color: Colors.grey)),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            final cartProduct = cartItems[index];
            final product = cartProduct.product;

            return Card(
                 color: darkMode? TColors.dark : TColors.light,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        product.image,
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text('\$${product.salePrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 14, color: Colors.grey)),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove, color: TColors.primary),
                                onPressed: () {
                                  if (cartProduct.quantity > 1) {
                                    cartController.updateQuantity(product, cartProduct.quantity - 1);
                                  }
                                },
                              ),
                              Text(cartProduct.quantity.toString(), style: TextStyle(fontSize: 16)),
                              IconButton(
                                icon: Icon(Icons.add, color: TColors.primary),
                                onPressed: () {
                                  cartController.updateQuantity(product, cartProduct.quantity + 1);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_forever, color: Colors.red),
                      onPressed: () {
                        cartController.removeFromCart(product);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        final totalPrice = cartController.getTotalPrice();
        return Padding(
          padding: EdgeInsets.all(16),
          child: Container(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            decoration: BoxDecoration(
              color: darkMode ? TColors.dark: TColors.light ,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total: \$${totalPrice.toStringAsFixed(2)}', style: TextStyle(color:  darkMode ? TColors.light: TColors.dark, fontSize: 18, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  onPressed: () {
                    Get.to(CheckoutPage());
                  },
                  style: ElevatedButton.styleFrom(
                  
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('Checkout', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

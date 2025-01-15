

import 'package:Saz/common/widgets/appbar/appbar_screen.dart';
import 'package:Saz/controllers/cart_controller.dart';
import 'package:Saz/screens/user/home_screen.dart';
import 'package:Saz/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

class CheckoutPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
  final TextEditingController cardNameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardExpiryController = TextEditingController();
  final TextEditingController cardCVVController = TextEditingController();

  final GetStorage storage = GetStorage();
  final String paymentInfoKey = 'paymentInfo';

  CheckoutPage({super.key});

  // Save payment info to GetStorage
  void savePaymentInfo() {
    final paymentInfo = {
      'cardName': cardNameController.text,
      'cardNumber': cardNumberController.text,
      'cardExpiry': cardExpiryController.text,
      'cardCVV': cardCVVController.text,
    };
    storage.write(paymentInfoKey, paymentInfo);
    Get.snackbar(
      'Success',
      'Payment information saved!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.greenAccent,
      colorText: Colors.white,
    );
    Get.to(HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
    
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Review Your Cart',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                return ListView.separated(
                  itemCount: cartController.cartItems.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final cartProduct = cartController.cartItems[index];
                    return ListTile(
                      leading: Image(image: AssetImage(cartProduct.product.image, ),   width: 80,
                        height: 80,
                        fit: BoxFit.contain,),
                      title: Text(
                        cartProduct.product.name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        'Quantity: ${cartProduct.quantity}\nPrice: \$${(cartProduct.product.salePrice * cartProduct.quantity).toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Iconsax.trash, color: Colors.red),
                        onPressed: () {
                          cartController.removeFromCart(cartProduct.product);
                        },
                      ),
                    );
                  },
                );
              }),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${cartController.getTotalPrice().toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            const Text(
              'Payment Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            _buildTextField(
              controller: cardNameController,
              hint: 'Cardholder Name',
              icon: Iconsax.user,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: cardNumberController,
              hint: 'Card Number',
              icon: Iconsax.card,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: cardExpiryController,
                    hint: 'MM/YY',
                    icon: Iconsax.calendar,
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextField(
                    controller: cardCVVController,
                    hint: 'CVV',
                    icon: Iconsax.key,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: savePaymentInfo,
                icon: const Icon(Iconsax.save_2),
                label: const Text('Save Payment Info'),
                
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon,),
        hintText: hint,
      
       
      ),
    );
  }
}
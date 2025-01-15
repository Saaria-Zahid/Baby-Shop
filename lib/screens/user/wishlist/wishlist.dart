import 'package:Saz/common/widgets/Icons/icons.dart';
import 'package:Saz/common/widgets/appbar/appbar_screen.dart';
import 'package:Saz/common/widgets/products/card/product_card_verticle.dart';
import 'package:Saz/controllers/favorite_controller.dart';
import 'package:Saz/screens/user/home_screen.dart';
import 'package:Saz/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteProductController());
    return Scaffold(
      appBar: SAppBar(
        title: Text(
          'Whishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const HomeScreen()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Obx(
                ()=> TGridLayout(
                  itemBuilder: (_, index) {
                    final product = controller.favoriteProducts[index];
                    return TProductCardVerticle(product: product);
                  },
                  itemCount: controller.favoriteProducts.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

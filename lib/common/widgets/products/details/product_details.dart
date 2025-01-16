import 'package:Saz/common/widgets/Icons/icons.dart';
import 'package:Saz/common/widgets/appbar/appbar_screen.dart';
import 'package:Saz/common/widgets/favorites/favorite_icon.dart';
import 'package:Saz/common/widgets/images/rounded_image.dart';
import 'package:Saz/common/widgets/shapes/containers/custom_curved.dart';
import 'package:Saz/common/widgets/shapes/containers/rounded_container.dart';
import 'package:Saz/controllers/cart_controller.dart';
import 'package:Saz/controllers/product_controller.dart';
import 'package:Saz/screens/authentication/screen/cart/cart.dart';
import 'package:Saz/utils/constants/colors.dart';
import 'package:Saz/utils/constants/image_strings.dart';
import 'package:Saz/utils/constants/sizes.dart';
import 'package:Saz/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final cartController = Get.put(CartController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TProductImageSlider(product: product),
            TRatingAndShare(product: product),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  final isProductInCart = cartController.isInCart(product);

                  // Add product to the cart
                  isProductInCart?
                  Get.to(CartPage()):
                  {
                  cartController.addToCart(product),
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${product.name} added to cart')),
                  )};
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Obx(() {
                  final isProductInCart = cartController.isInCart(product);

                  return isProductInCart
                      ? Text(
                          'Checkout',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                }),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class TRatingAndShare extends StatelessWidget {
  const TRatingAndShare({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          right: TSizes.defaultSpace,
          left: TSizes.defaultSpace,
          bottom: TSizes.defaultSpace),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Iconsax.star5, size: 24, color: Colors.amber),
                  SizedBox(width: TSizes.spaceBtwItems / 2),
                  Text.rich(TextSpan(
                    children: [
                      TextSpan(
                        text: '5.0',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const TextSpan(text: '(89)'),
                    ],
                  )),
                  SizedBox(width: TSizes.spaceBtwItems / 2),
                ],
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.share, size: TSizes.iconMd)),
            ],
          ),
          TProductMetaData(product: product),
        ],
      ),
    );
  }
}

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);

    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20),),
        color: darkMode ? TColors.darkGrey : TColors.light,
      ),
        child: Stack(
          children: [
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
                child: TRoundedBorderImage(
                  imageUrl: product.image,
                ),
              ),
            ),
            SAppBar(
              showBackArrow: true,
              actions: [FavoriteIcon(product: product)],
            ),
          ],
        ),
      
    );
  }
}

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price and Sale Information
        Row(
          children: [
            TRoundedContainer(
              radius: TSizes.sm,
              backgroundColor: TColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.xs),
              child: Text(
                '${((1 - product.salePrice / product.price) * 100).toStringAsFixed(0)}% OFF',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.black),
              ),
            ),
            SizedBox(width: TSizes.spaceBtwItems),
            // Sale tag
            TProductPriceText(
              lineThrough: true,
                price: '${product.price}',
                isLarge: false,
                
              ),
            SizedBox(
              width: 5,
            ),
            TProductPriceText(
                price: '${product.salePrice}',
                isLarge: true,
              ),
          ],
        ),
        SizedBox(height: TSizes.spaceBtwItems),
          Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            product.name,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(height: TSizes.spaceBtwItems),
        // Description or metadata section
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            product.description,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}

class TProductPriceText extends StatelessWidget {
  const TProductPriceText({
    super.key,
    this.currencySign = '\$',
    required this.price,
    this.isLarge = false,
    this.maxLines = 1,
    this.lineThrough = false,
  });

  final String currencySign, price;
  final int maxLines;
  final bool isLarge;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      currencySign + price,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context).textTheme.headlineMedium!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null)
          : Theme.of(context).textTheme.titleLarge!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null),
    );
  }
}

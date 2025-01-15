

import 'package:Saz/common/widgets/Icons/icons.dart';
import 'package:Saz/controllers/favorite_controller.dart';
import 'package:Saz/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FavoriteIcon extends StatelessWidget {
  final Product product;

  FavoriteIcon({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteController = Get.find<FavoriteProductController>();

    return Obx(() {
      final isFavorite = favoriteController.isFavorite(product);

      return TCircularIcon(icon: Iconsax.heart5, color:  isFavorite ? Colors.red : Colors.grey, onPressed: ()=> favoriteController.toggleFavorite(product));
    
    });
  }
}



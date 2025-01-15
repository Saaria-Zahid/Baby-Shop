


import 'package:Saz/utils/constants/colors.dart';
import 'package:Saz/utils/constants/sizes.dart';
import 'package:Saz/utils/device/device_utility.dart';
import 'package:Saz/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TSearchBarContainer extends StatelessWidget {
 const TSearchBarContainer({
    super.key,
   required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true, this.onTap
  });

  final String text;
  final IconData? icon;
  final bool showBackground;
  final bool showBorder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
   final darkMode = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: TDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(TSizes.md),
          decoration: BoxDecoration(
            color: showBackground? darkMode? TColors.dark: TColors.light :Colors.transparent,
            borderRadius:
                BorderRadius.circular(TSizes.cardRadiusLg),
            border: showBorder? darkMode? Border.all(color: TColors.darkGrey) :Border.all(color: TColors.grey) : null,
          ), // BoxDecoration
          child: Row(
            children: [
              const Icon(Iconsax.search_normal,
                  color: TColors.grey),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text(
                text,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ), // Row
        ),
      ), // Container
    );
  }
}


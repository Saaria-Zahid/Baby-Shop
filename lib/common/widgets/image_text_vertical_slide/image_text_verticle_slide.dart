import 'package:Saz/utils/constants/colors.dart';
import 'package:Saz/utils/constants/sizes.dart';
import 'package:Saz/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TVerticleImageText extends StatelessWidget {
  const TVerticleImageText({
    super.key, required this.image, required this.text,  this.textColor = TColors.white , this.backgroundColor = TColors.white, this.onTap,
  });

final String image, text;
final Color textColor;
final Color? backgroundColor;
final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final darkMode =THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
            right: TSizes.spaceBtwItems),
        child: Container(
          
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
          color: TColors.primary
        ),
          child:
              Center(
                child: Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          
        ),
      ),
    );
  }
}

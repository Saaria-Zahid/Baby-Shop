import 'package:Saz/common/styles/spacing_style.dart';
import 'package:Saz/utils/constants/image_strings.dart';
import 'package:Saz/utils/constants/sizes.dart';
import 'package:Saz/utils/constants/text_strings.dart';
import 'package:Saz/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key,
  required this.title, required this.subtitle, required this.image, required this.onPressed
  });

final String image, title, subtitle;
final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Padding(padding: TSpacingStyle.paddingWithAppBarHeigth, child: 
      Column(
        children: [
            Image(image: AssetImage(TImages.successfulRegistrationAnimation),
              width: THelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
              // Title ans SubTitle
              Text(title, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
              const SizedBox(height: TSizes.spaceBtwItems,),

              Text(subtitle , style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
              const SizedBox(height: TSizes.spaceBtwSections,),
              //Buttons
              SizedBox(width: double.infinity,child: 
              ElevatedButton(onPressed: onPressed, child: const Text(TTexts.tContinue))
              ,),
        ],
      )
      ,)),
    );
  }
}
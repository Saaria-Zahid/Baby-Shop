import 'package:Saz/screens/authentication/controller/onboarding_controller.dart';
import 'package:Saz/utils/constants/colors.dart';
import 'package:Saz/utils/constants/image_strings.dart';
import 'package:Saz/utils/constants/sizes.dart';
import 'package:Saz/utils/constants/text_strings.dart';
import 'package:Saz/utils/device/device_utility.dart';
import 'package:Saz/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          // Scrollable page
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children:const [
              OnBaordingPage(image: TImages.onBoardingImage1 , title: TTexts.onBoardingTitle1,subtitle: TTexts.onBoardingSubTitle1),
              OnBaordingPage(image: TImages.onBoardingImage2 , title: TTexts.onBoardingTitle2,subtitle: TTexts.onBoardingSubTitle2),
              OnBaordingPage(image: TImages.onBoardingImage3 , title: TTexts.onBoardingTitle3,subtitle: TTexts.onBoardingSubTitle3),
            ],
          )
       ,  
        //  skip Button
         const OnBoardingSkip(),

        //  Dot Navigation
        
        OnBoardingDotNavigation(darkMode: darkMode),
        
      // circular button
       
       Positioned(
        right: TSizes.defaultSpace,
        bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      
        child: ElevatedButton(onPressed: ()=> controller.nextPage(), 
        style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: darkMode ? TColors.primary : Colors.black),
        
        child: const Icon(Iconsax.arrow_right_3))
        ),
 
        ],
      ),
    );
  }
}

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
    required this.darkMode,
  });

  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: TSizes.defaultSpace,
      child: SmoothPageIndicator(controller: controller.pageController, onDotClicked: controller.dotNavigation, count: 3, effect: ExpandingDotsEffect(activeDotColor: darkMode ? TColors.light : TColors.dark, dotHeight: 6), ));
  }
}

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    return Positioned( top: TDeviceUtils.getAppBarHeight(), right: TSizes.defaultSpace, child: TextButton(onPressed: ()=> controller.skipPage(), child: const Text("Skip")));
  }
}

class OnBaordingPage extends StatelessWidget {
  const OnBaordingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle
  });

final String image, title, subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          Image(
            image: AssetImage(image),
            width: THelperFunctions.screenWidth() * 0.8,
            height: THelperFunctions.screenHeight() * 0.6,
          ),
          Text(
           title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

import 'package:Saz/screens/authentication/screen/cart/cart.dart';
import 'package:Saz/screens/user/home_screen.dart';
import 'package:Saz/screens/user/profile/profile.dart';
import 'package:Saz/screens/user/wishlist/wishlist.dart';
import 'package:Saz/utils/constants/colors.dart';
import 'package:Saz/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
final controller = Get.put(NavigationController());
final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () =>  NavigationBar(
          height: 80,
          elevation: 0,
          backgroundColor: darkMode ? TColors.black : Colors.white,
          indicatorColor: darkMode? TColors.white.withOpacity(0.1): TColors.black.withOpacity(0.1),
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
          NavigationDestination(icon: Icon(Iconsax.shopping_bag), label: "Cart"),
          NavigationDestination(icon: Icon(Iconsax.heart), label: "Wishlist"),
          NavigationDestination(icon: Icon(Iconsax.user), label: "Profile"),
        ]),
      ),
      body: Obx(()=> controller.screens[controller.selectedIndex.value]),
    );
  }
}


class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;
  final screens = [const HomeScreen(), CartPage(),const WishlistScreen(), const Profile(),];
}
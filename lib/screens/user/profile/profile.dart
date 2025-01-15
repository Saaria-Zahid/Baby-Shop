import 'package:Saz/common/widgets/appbar/appbar_screen.dart';
import 'package:Saz/common/widgets/images/rounded_image.dart';
import 'package:Saz/data/repositories/authentication_repo.dart';
import 'package:Saz/screens/user/home_screen.dart';
import 'package:Saz/utils/constants/colors.dart';
import 'package:Saz/utils/constants/image_strings.dart';
import 'package:Saz/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header

            TPrimaryHeaderContainer(
                child: Column(
              children: [
                SAppBar(
                  title: Text(
                    "Account ",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: TColors.white),
                  ),
                ),


                TUserProfileInfo(),

                SizedBox(height: TSizes.spaceBtwSections,),

              ],
            )),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  TSectionHeading(title: "Account Settings", showActionButton: false,),
                  SizedBox(height: TSizes.spaceBtwItems,),
              
                  TSettingMenuTile(icon: Iconsax.safe_home, title: 'My Addresses', subtitle: 'Set shopping delivery address'),
                  TSettingMenuTile(icon: Iconsax.shopping_cart, title: 'My Cart', subtitle: 'Add, remove products and move to checkout'),
                  TSettingMenuTile(icon: Iconsax.bag_tick, title: 'My Orders', subtitle: 'In-progress and Completed Orders'),
                  TSettingMenuTile(icon: Iconsax.bank, title: 'Bank Account', subtitle: 'Withdraw balance to registered bank account'),
                  TSettingMenuTile(icon: Iconsax.discount_shape, title: 'My Coupons', subtitle: 'List of all the discounted coupons'),
                  TSettingMenuTile(icon: Iconsax.notification, title: 'Notifications', subtitle: 'Set any kind of notification message'),
                  TSettingMenuTile(icon: Iconsax.security_card, title: 'Account Privacy', subtitle: 'Manage data usage and connected accounts'),
                
              
                // App Settings
                  SizedBox(height: TSizes.spaceBtwSections,),
                  TSectionHeading(title: 'App Settings', showActionButton: false,),
                  SizedBox(height: TSizes.spaceBtwItems,),
              
                  TSettingMenuTile(icon: Iconsax.like_dislike, title: 'Feedback', subtitle: 'Write your honest feedback for our app', onTap: (){},),
                  TSettingMenuTile(icon: Iconsax.message_question, title: 'Help & Support', subtitle: 'Get support and answer your questions', onTap: (){},),
                  TSettingMenuTile(icon: Iconsax.location, title: 'Location', subtitle: 'Set recommendation based on location', onTap: (){}, trailing: Switch(value: true, onChanged: (value) {},),),
              
                  SizedBox(height: TSizes.spaceBtwSections,),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed:()=> AuthenticationRepository.instance.logout(), child: Text('Logout'))
                  ),
              
                    SizedBox(height: TSizes.spaceBtwSections * 2.5,),
              
              
               
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TUserProfileInfo extends StatelessWidget {
  const TUserProfileInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
        final controller = AuthenticationRepository.instance;

    return 
    FutureBuilder<Map<String, dynamic>>(
          future: controller.fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final data = snapshot.data!;
              return    ListTile(
      leading: TRoundedBorderImage(imageUrl: TImages.user, width: 50,height: 50,padding: EdgeInsets.all(0),),
      title: Text( ' ${data['firstName']} ${data['lastName']}', style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white ),) ,
      subtitle: Text( ' ${data['email']}', style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),) ,
      trailing: IconButton(onPressed: (){}, icon: Icon(Iconsax.edit, color: TColors.white,)),
    );
            } else {
              return Text('No data available');
            }
          },
        );
 
  }
}

                  



class TSettingMenuTile extends StatelessWidget {
  const TSettingMenuTile({super.key, required this.icon, required this.title, required this.subtitle, this.trailing, this.onTap});

  final IconData icon;
  final String title, subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 28, color: TColors.primary,),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium,),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.labelMedium,),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
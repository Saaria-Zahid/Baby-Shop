import 'package:Saz/common/styles/spacing_style.dart';
import 'package:Saz/screens/authentication/screen/login_signup_assets.dart';
import 'package:Saz/utils/constants/sizes.dart';
import 'package:Saz/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeigth,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            LoginHeader(darkMode: darkMode),
            LoginForm(darkMode: darkMode),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            const LoginFooter()
          ]),
        ),
      ),
    );
  }
}

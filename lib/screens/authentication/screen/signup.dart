import 'package:Saz/screens/authentication/controller/signup_controller.dart';
import 'package:Saz/utils/constants/colors.dart';
import 'package:Saz/utils/constants/sizes.dart';
import 'package:Saz/screens/authentication/screen/login_signup_assets.dart';
import 'package:Saz/utils/constants/text_strings.dart';
import 'package:Saz/utils/helpers/helper_functions.dart';
import 'package:Saz/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              const TSignUpForm()
            ],
          ),
        ),
      ),
    );
  }
}

class TSignUpForm extends StatelessWidget {
  const TSignUpForm({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
        final darkMode = THelperFunctions.isDarkMode(context);
     final controller = Get.put(SignupController());
    return Form(

 key: controller.signupFormKey,
        child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.firstName,
                validator: (value) => TValidator.validateEmptyText("First name", value),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.user),
                  labelText: TTexts.firstName,
                ),
              ),
            ),
            const SizedBox(
              width: TSizes.spaceBtwInputFields,
            ),
            Expanded(
              child: TextFormField(
                validator: (value) => TValidator.validateEmptyText("Last name", value),
                controller: controller.lastName,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.user),
                  labelText: TTexts.lastName,
                ),
              ),
            )
          ],
        ),
       const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        //username
        TextFormField(
          validator: (value) => TValidator.validateEmptyText("Username", value),
          controller: controller.username,
          decoration: const InputDecoration(
            prefixIcon: Icon(Iconsax.user_edit),
            labelText: TTexts.username,
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        //email
        TextFormField(
          validator: (value) => TValidator.validateEmail(value),
          controller: controller.email,
          decoration: const InputDecoration(
            prefixIcon: Icon(Iconsax.direct),
            labelText: TTexts.email,
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        //phone
        TextFormField(
          validator: (value) => TValidator.validatePhoneNumber(value),
          controller: controller.phoneNumber,
          decoration: const InputDecoration(
            prefixIcon: Icon(Iconsax.call),
            labelText: TTexts.phoneNo,
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        //password
        Obx(
          ()=> TextFormField(
            validator: (value) => TValidator.validatePassword(value),
            controller: controller.password,
            obscureText: controller.hidePassword.value,
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.password_check),
              suffixIcon: IconButton(onPressed: ()=> controller.hidePassword.value = !controller.hidePassword.value, icon: Icon(controller.hidePassword.value == true? Iconsax.eye_slash: Iconsax.eye)) ,
              labelText: TTexts.password,
            ),
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 24,
                height: 24,
                child: Obx(
                  ()=> Checkbox(
                    value: controller.privacyPolicy.value,
                    onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value,
                  ),
                )),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: '${TTexts.iAgreeTo} ',
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                  text: '${TTexts.privacyPolicy} ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(
                          color: darkMode
                              ? TColors.white
                              : TColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: darkMode
                              ? TColors.white
                              : TColors.primary)),
              TextSpan(
                  text: '${TTexts.and} ',
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                  text: '${TTexts.termsOfUse} ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(
                          color: darkMode
                              ? TColors.white
                              : TColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: darkMode
                              ? TColors.white
                              : TColors.primary)),
            ])),
            
          ],
        ),
    
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
    
        //signup Button
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () => controller.signup(),
                child: const Text(TTexts.createAccount))),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
    
        CustomDivider(
          darkMode: darkMode,
          text: TTexts.orSignUpWith.capitalize!,
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
    
        const LoginFooter()
      ],
    ));
  }
}

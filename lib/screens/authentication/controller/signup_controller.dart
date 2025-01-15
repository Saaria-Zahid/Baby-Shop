import 'package:Saz/data/models/user_model.dart';
import 'package:Saz/data/repositories/authentication_repo.dart';
import 'package:Saz/data/repositories/user_repo.dart';
import 'package:Saz/screens/authentication/screen/verification/verify.dart';
import 'package:Saz/utils/constants/image_strings.dart';
import 'package:Saz/utils/helpers/network_manager.dart';
import 'package:Saz/utils/popups/full_screen_loader.dart';
import 'package:Saz/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final privacyPolicy = true.obs;
  final hidePassword = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signup() async {
    try {
      //Loading
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information', TImages.docerAnimation);
      // Check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
      TFullScreenLoader.stopLoading();
      return;
      }

      // Form Validation
      if (!signupFormKey.currentState!.validate()){
         TFullScreenLoader.stopLoading();
      return;
      }

      //Privacy Policy
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In Order to create account, you must have to read the Privacy Policy & Terms of Use');
        return;
      }

      // Register

      // Save Auth
      final UserCredential userCredential =
          await AuthenticationRepository.instance.registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: username.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '');
          
          final userRepository = Get.put(UserRepository());
        await   userRepository.saveUserRecord(newUser);
      TFullScreenLoader.stopLoading();

         TLoaders.successSnackBar(title: 'Congratulations!', message: 'Your Account has been created! Verify your email to continue');

         Get.to(()=>  EmailVerificationScreen(email: email.text.trim(),));

    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    
  }
}}

import 'package:Saz/data/repositories/authentication_repo.dart';
import 'package:Saz/utils/constants/image_strings.dart';
import 'package:Saz/utils/helpers/network_manager.dart';
import 'package:Saz/utils/popups/full_screen_loader.dart';
import 'package:Saz/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
   
   final rememberMe = false.obs;
   final hidePassword = true.obs;
   final storage = GetStorage();
   final email = TextEditingController();
   final password = TextEditingController();
   GlobalKey<FormState> formKey = GlobalKey<FormState>();


  //  @override
  // void onInit() {
  //   email.text = storage.read('REMEMBER_ME_EMAIL');
  //   password.text = storage.read('REMEMBER_ME_PASSWORD');
  //   super.onInit();
  // }

   void emailAndPasswordSignin() async {
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
      if (!formKey.currentState!.validate()){
         TFullScreenLoader.stopLoading();
      return;
      }

      //Privacy Policy
      if (rememberMe.value) {
       storage.write('REMEMBER_ME_EMAIL', email.text.trim());
       storage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Register

      // Save Auth
      final UserCredential userCredential =
          await AuthenticationRepository.instance.signInWithEmailPassword(email.text.trim(), password.text.trim());

      
      TFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    
  }
}
}

import 'package:Saz/screens/authentication/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardingController extends GetxController{

  static OnBoardingController get instance => Get.find();
 final pageController = PageController();
 Rx<int> currentIndex = 0.obs;


  void updatePageIndicator(index) => currentIndex.value = index;

  void dotNavigation(index){
    currentIndex.value = index;
    pageController.jumpTo(index);
  }

  void nextPage(){
   if(currentIndex.value == 2){
    final storage = GetStorage();
    storage.write('IsFirsTime', false);
Get.offAll(const LoginScreen());
   }else{
    int page = currentIndex.value +1;
       pageController.jumpToPage(page);
   }
  }

  void skipPage(){
    currentIndex.value = 2;
    pageController.jumpTo(2);
  }



}
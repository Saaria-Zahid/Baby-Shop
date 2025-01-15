import 'package:Saz/bottom_navigation.dart';
import 'package:Saz/data/models/user_model.dart';
import 'package:Saz/screens/authentication/screen/login.dart';
import 'package:Saz/screens/authentication/screen/onboarding.dart';
import 'package:Saz/screens/authentication/screen/verification/verify.dart';
import 'package:Saz/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:Saz/utils/exceptions/firebase_exceptions.dart';
import 'package:Saz/utils/exceptions/format_exceptions.dart';
import 'package:Saz/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  final deviceStorage = GetStorage();
    final _firestore = FirebaseFirestore.instance;


  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() async {
     final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const BottomNavigation());
      } else {
        Get.offAll(() => EmailVerificationScreen(
              email: _auth.currentUser?.email,
            ));
      }
    } else {
      deviceStorage.writeIfNull('IsFirsTime', true);
      deviceStorage.read('IsFirsTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(const OnBoarding());
    }
  }

   Future<Map<String, dynamic>> fetchUserData() async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("No user logged in");
    }

    final doc = await _firestore.collection('Users').doc(user.uid).get();

    if (!doc.exists) {
      throw Exception("User data not found");
    }

    return doc.data()!;
  }

// Register
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

// Verification

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }


 // Login
     Future<UserCredential> signInWithEmailPassword(String email, String password) async{
    try {
     return  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email , password: password);
      Get.offAll(() =>const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }




  // Logout
    Future<void> logout() async{

    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() =>const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}

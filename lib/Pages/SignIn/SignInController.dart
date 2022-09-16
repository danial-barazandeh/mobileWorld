import 'dart:developer';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jmob/Model/User.dart';
import 'package:jmob/Pages/Home/Home.dart';
import 'package:jmob/Pages/Home/HomeBinding.dart';
import 'package:jmob/Pages/SignUpForm/SignUpForm.dart';
import 'package:jmob/Pages/SignUpForm/SignUpFormBinding.dart';
import 'package:jmob/Pages/SignUpForm/SignUpFormController.dart';
import 'package:jmob/Services/BackendServices.dart';
import 'package:jmob/Services/MyColors.dart';
import 'package:jmob/Services/MyStrings.dart';

import '../../Widget/Drawer/MyDrawerController.dart';

class SignInController extends GetxController {
  var isLoading = false.obs;
  var status = "".obs;
  var verificationIdTemp = "6Digit".obs;
  static var myColors = Get.find<MyColors>();
  MyStrings myStrings = Get.find<MyStrings>();
  var isWaitingForCode = false.obs;

  var countryCode = "".obs;
  var phoneNumber = "".obs;

  var userList = <JmobUser>[].obs;

  verifyCode(String pin) async {
    try {
      isLoading(true);
      await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationIdTemp.value, smsCode: pin)).then((value) async {
        if (value.user != null) {
          print("------------");
          print(await value.user!.getIdToken());
          print("------------");

          var user = await BackendServices.onClickRegisterOrLogin(countryCode.value, phoneNumber.value, await value.user!.getIdToken());
          if (user != null) {


            var storage = GetStorage("userStorage");
            await storage.write('user', user.toJson());
            SignUpFormController signUpFormController = Get.find<SignUpFormController>();
            signUpFormController.checkUser();
            signUpFormController.getUser();

            MyDrawerController myDrawerController = Get.find<MyDrawerController>();
            myDrawerController.selectHome();
            Get.to(() => Home(), binding: HomeBinding());
          }
        } else {
          isLoading.value = false;
        }
      });
    } catch (e) {
      print(e.toString());
      isLoading.value = false;
      Get.snackbar(
        myStrings.error,
        e.toString(),
        icon: Icon(Icons.lock, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: myColors.coll.withAlpha(200),
      );
    } finally {
      isLoading(false);
    }
  }

  newAgeVerifyPhoneNumberForRegister(String code, String number) async {
    try {
      countryCode.value = code;
      phoneNumber.value = number;
      isLoading(true);
      final auth = FirebaseAuth.instance;
      print("Ver called");
      isLoading.value = true;
      try {
        await auth.verifyPhoneNumber(
          // mobile no. with country code
          phoneNumber: code + number,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            isLoading.value = false;
            Get.snackbar(
              myStrings.error,
              e.message.toString(),
              icon: Icon(Icons.lock, color: Colors.white),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: myColors.coll.withAlpha(200),
            );
          },
          codeSent: (String verificationId, int? resendToken) {
            verificationIdTemp.value = verificationId;
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            isLoading.value = false;
            // Get.snackbar(
            //     myStrings.error,
            //     myStrings.timeout,
            //     icon: Icon(Icons.lock, color: Colors.white),
            //     snackPosition: SnackPosition.BOTTOM,
            //     colorText: Colors.white,
            //   backgroundColor: myColors.coll.withAlpha(200),
            // );
          },
        );
      } finally {}
    } catch (e) {
      Get.snackbar(
        myStrings.error,
        e.toString(),
        icon: Icon(Icons.lock, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: myColors.coll.withAlpha(200),
      );
      isLoading(false);
    } finally {
      isLoading(false);
      isWaitingForCode(true);
    }

  }
}

import 'dart:developer';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jmob/Pages/PhoneModelView/PhoneModelView.dart';
import 'package:jmob/Pages/PhoneModelView/PhoneModelViewController.dart';
import 'package:jmob/Pages/PhoneModelView/PhoneModelViewBinding.dart';
import 'package:jmob/Services/BackendServices.dart';
import 'package:jmob/Services/MyStrings.dart';
import 'package:woocommerce/woocommerce.dart';

class BottomNavigationController extends GetxController {
  var page = 1.obs;
  var bottomNavigationKey = GlobalKey().obs;

  @override
  void onInit(){
    super.onInit();
  }


  void selectSignUp(){
    page.value = 0;
  }

  void selectHome(){
    page.value = 1;
  }

  void selectOrders(){
    page.value = 2;
  }

  void selectSearch(){
    page.value = 3;
  }



}
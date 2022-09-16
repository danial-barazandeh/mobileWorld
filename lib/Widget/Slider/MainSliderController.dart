import 'dart:developer';

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

class MainSliderController extends GetxController {

  var imgList = <String>[].obs;

  @override
  void onInit(){
    getSlidersImages();
    super.onInit();
  }

  getSlidersImages() async {
    // imgList.value = await BackendServices.fetchSliders();
  }


}
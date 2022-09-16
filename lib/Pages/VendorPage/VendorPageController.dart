import 'dart:async';
import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jmob/Model/Vendor.dart';
import 'package:jmob/Pages/PartList/PartList.dart';
import 'package:jmob/Pages/ProductView/ProductController.dart';
import 'package:jmob/Pages/ProductView/ProductView.dart';
import 'package:jmob/Services/BackendServices.dart';
import 'package:jmob/Services/MyColors.dart';
import 'package:jmob/Services/MyStrings.dart';
import 'package:jmob/Widget/ProductWidget.dart';
import 'package:woocommerce/woocommerce.dart';

class VendorPageController extends GetxController {
  var isLoading = true.obs;
  var vendorID = 0.obs;

  var vendors = <Vendor>[].obs;
  MyStrings myStrings = new MyStrings();
  MyColors myColors = new MyColors();
  @override
  void onInit() {
    print("*** "+vendorID.toString()+" ***");
    super.onInit();
  }


  fetchVendors() async {
    // isLoading(true);
    // vendors.clear();
    // try{
    //   var temp = await BackendServices.fetchVendor(vendorID.value);
    //   temp.forEach((element) {
    //     vendors.add(element);
    //   });
    //   isLoading(false);
    //   return temp;
    // }catch(e){
    //   Get.snackbar(
    //     myStrings.error,
    //     myStrings.notVendorInfo,
    //     icon: Icon(Icons.lock, color: Colors.white),
    //     snackPosition: SnackPosition.BOTTOM,
    //     colorText: Colors.white,
    //     backgroundColor: myColors.coll.withAlpha(200),
    //   );
    //   isLoading(false);
    //   return false;
    // }
  }



}

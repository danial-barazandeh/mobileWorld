import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jmob/Model/Brand.dart';
import 'package:jmob/Model/Device.dart';
import 'package:jmob/Model/Order.dart';
import 'package:jmob/Model/Product.dart';
import 'package:jmob/Model/ProductCategory.dart';
import 'package:jmob/Pages/PartList/PartList.dart';
import 'package:jmob/Services/BackendServices.dart';
import 'package:jmob/Services/MyStrings.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../Services/MyColors.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  var selectedDevice = Device(id: 1).obs;
  var selectedProductCategory = ProductCategory(id: 0).obs;

  var products = <Product>[].obs;
  var productsTemp = <Product>[];
  var productCategories = <ProductCategory>[];
  var ordersTemp = <Order>[].obs;
  var orders = <Order>[].obs;


  @override
  void onInit(){
    // getProducts();
    super.onInit();
  }



}
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jmob/Pages/Home/Home.dart';
import 'package:jmob/Pages/Home/HomeBinding.dart';
import 'package:jmob/Pages/PhoneModelView/PhoneModelViewController.dart';
import 'package:jmob/Services/MyColors.dart';
import 'package:jmob/Services/MyStrings.dart';
import 'package:jmob/Widget/BottomNavigation/ButtomNavigation.dart';
import 'package:jmob/Widget/BrandWidget.dart';
import 'package:jmob/Widget/DeviceWidget.dart';
import 'package:jmob/Widget/Slider/MainSlider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:woocommerce/models/product_category.dart';
import 'package:woocommerce/models/product_tag.dart';
import '../../Widget/BrandWidgetPlaceHolder.dart';
import 'SearchPageController.dart';

class SearchPage extends GetView<SearchPageController> {
  SearchPageController searchPageController = Get.find<SearchPageController>();
  PhoneModelViewController phoneModelViewController = Get.find<PhoneModelViewController>();

  @override
  Widget build(BuildContext context) {
    MyColors myColors = new MyColors();
    MyStrings myStrings = Get.find<MyStrings>();

    TextEditingController searchController = new TextEditingController();

    Timer searchOnStoppedTyping = new Timer(Duration(microseconds: 1), () => print(""));

    search(value) {
      print('hello world from search . the value is $value');
    }

    _onChangeHandler(value) {
      const duration = Duration(milliseconds: 800); // set the duration that you want call search() after that.
      if (searchOnStoppedTyping != null) {
        searchOnStoppedTyping.cancel(); // clear timer
      }
      searchOnStoppedTyping = new Timer(duration, () => searchPageController.doTheSearch(value));
    }

    return Scaffold(
        backgroundColor: myColors.background,
        bottomNavigationBar: ButtomNavigation(),
        body: Container(
            margin: EdgeInsets.only(top: 35),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close, color: myColors.textColor),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      alignment: Alignment.center,
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(right: 12, left: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                      onChanged: (text) {
                                        if (text.length >= 2) _onChangeHandler(text);
                                      },
                                      controller: searchController,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      keyboardType: TextInputType.emailAddress,
                                      textAlign: TextAlign.right,
                                      autofocus: true,
                                      style: TextStyle(color: Colors.black87),
                                      decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        hintText: myStrings.search,
                                        labelStyle: TextStyle(color: Colors.black87),
                                      )),
                                ),
                                Icon(
                                  Icons.search,
                                  color: myColors.textColor,
                                  size: 24,
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
                Expanded(
                  child: Obx(() {
                    if (searchPageController.isLoading.value)
                      return GridView.builder(
                          padding: EdgeInsets.all(0),
                          scrollDirection: Axis.vertical,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Container(
                                padding: EdgeInsets.all(6),
                                child: BrandWidgetPlaceHolder());
                          });
                    else
                      return GridView.builder(
                          padding: EdgeInsets.all(0),
                          scrollDirection: Axis.vertical,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: searchPageController.categoryList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                phoneModelViewController.selectDevice(searchPageController.categoryList.value[index]);
                              },
                              child: DeviceWidget(searchPageController.categoryList.value[index]),
                            );
                          });
                  }),
                )
              ],
            )));
  }
}

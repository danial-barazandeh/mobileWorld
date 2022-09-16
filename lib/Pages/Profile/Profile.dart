import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:jmob/Pages/PhoneModelView/PhoneModelViewController.dart';
import 'package:jmob/Services/MyColors.dart';
import 'package:jmob/Services/MyStrings.dart';
import 'package:jmob/Widget/BottomNavigation/ButtomNavigation.dart';
import 'package:jmob/Widget/Drawer/MyDrawerController.dart';
import 'package:jmob/Widget/Drawer/MyPerfectDrawer.dart';
import 'package:jmob/Widget/BrandWidget.dart';
import 'package:jmob/Widget/Slider/MainSlider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:woocommerce/models/product_category.dart';
import 'package:woocommerce/models/product_tag.dart';
import 'ProfileController.dart';

class Profile extends GetView<ProfileController> {
  ProfileController profileController = Get.find<ProfileController>();

  MyColors myColors = Get.find<MyColors>();
  MyStrings myStrings = Get.find<MyStrings>();
  final myPerfectDrawer = Get.find<MyPerfectDrawer>();
  final myDrawerController = Get.find<MyDrawerController>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: myColors.background,
        bottomNavigationBar: ButtomNavigation(),
        body: Stack(
          children: [
            myPerfectDrawer,
            Obx(
              () => AnimatedContainer(
                transform: Matrix4.translationValues(
                    myDrawerController.xOffset.value, myDrawerController.yOffset.value * 1.5, 0)
                  ..scale(myDrawerController.scaleFactor.value),
                duration: Duration(milliseconds: 250),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: myColors.backgroundColor,
                    borderRadius: BorderRadius.circular(myDrawerController.isDrawerOpen.value ? 30 : 0)),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(height: myDrawerController.isDrawerOpen.value ? 10 : 30,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        myDrawerController.isDrawerOpen.value
                            ? IconButton(
                          icon: Icon(Icons.arrow_back,
                              color: myColors.textColor),
                          onPressed: () =>
                              myDrawerController.CloseDrawer(),
                        )
                            : IconButton(
                          icon: Icon(Icons.menu,
                              color: myColors.textColor),
                          onPressed: () =>
                              myDrawerController.OpenDrawer(context),
                        ),
                        Text(
                          myStrings.editAccount,
                          style: TextStyle(color: myColors.textColor),
                        ),
                      ],
                    ),
                    Container(),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
